import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/ad_model.dart';
import '../providers/app_state_provider.dart';
import '../services/firestore_service.dart';
import '../services/location_service.dart';

/// Pantalla de selección de ciudad con soporte de áreas metropolitanas.
///
/// Muestra las ciudades activas desde Firestore, agrupadas por estado.
/// Al seleccionar una ciudad, se guarda en AppStateProvider y se filtran
/// los anuncios por su área metropolitana.
class CitySelectorScreen extends StatefulWidget {
  const CitySelectorScreen({super.key});

  @override
  State<CitySelectorScreen> createState() => _CitySelectorScreenState();
}

class _CitySelectorScreenState extends State<CitySelectorScreen> {
  final _searchController = TextEditingController();
  final _locationService = LocationService();
  List<Map<String, dynamic>> _cities = [];
  List<Map<String, dynamic>> _filteredCities = [];
  bool _isLoading = true;
  bool _isDetecting = false;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadCities();
  }

  Future<void> _loadCities() async {
    final firestore = FirestoreService();
    final cities = await firestore.getCities();
    if (mounted) {
      setState(() {
        _cities = cities;
        _filteredCities = cities;
        _isLoading = false;
      });
    }
  }

  void _filterCities(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredCities = _cities;
      } else {
        final lower = query.toLowerCase();
        _filteredCities = _cities.where((city) {
          final name = (city['name'] ?? '').toString().toLowerCase();
          final state = (city['state'] ?? '').toString().toLowerCase();
          final metro = (city['metro_area'] ?? '').toString().toLowerCase();
          return name.contains(lower) || state.contains(lower) || metro.contains(lower);
        }).toList();
      }
    });
  }

  /// Detecta la ciudad con el GPS y la guarda en el provider.
  Future<void> _useMyLocation() async {
    setState(() => _isDetecting = true);

    final result = await _locationService.getCurrent();
    if (!mounted) return;

    if (result == null) {
      setState(() => _isDetecting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'No se pudo obtener tu ubicación. Revisa los permisos o elige tu '
            'ciudad manualmente.',
          ),
        ),
      );
      return;
    }

    // Busca la ciudad detectada dentro del catálogo de Firestore.
    final detected = result.cityName.trim().toLowerCase();
    Map<String, dynamic>? match;
    if (detected.isNotEmpty) {
      for (final city in _cities) {
        final name = (city['name'] ?? '').toString().trim().toLowerCase();
        if (name == detected) {
          match = city;
          break;
        }
      }
    }

    final provider = context.read<AppStateProvider>();
    if (match != null) {
      final name = (match['name'] ?? '') as String;
      final state = (match['state'] ?? '') as String;
      final country = (match['country'] ?? '') as String;
      final metro = (match['metro_area'] ?? '') as String;

      provider.setLocation(
        LocationModel(
          city: name,
          state: state,
          country: country,
          metroArea: metro,
          latitude: result.latitude,
          longitude: result.longitude,
        ),
        useAuto: true,
      );
      provider.setSelectedCity(name, metro);
    } else {
      provider.setLocation(
        LocationModel(
          city: result.cityName,
          state: '',
          country: '',
          latitude: result.latitude,
          longitude: result.longitude,
        ),
        useAuto: true,
      );
      provider.setSelectedCity(result.cityName, '');
    }

    setState(() => _isDetecting = false);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecciona tu ciudad'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isDetecting ? null : _useMyLocation,
                icon: _isDetecting
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.my_location),
                label: Text(
                  _isDetecting ? 'Detectando...' : 'Usar mi ubicación',
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar ciudad o área metropolitana...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              onChanged: _filterCities,
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredCities.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.location_city, size: 64, color: Colors.grey[400]),
                            const SizedBox(height: 16),
                            Text(
                              'No se encontraron ciudades',
                              style: TextStyle(color: Colors.grey[600], fontSize: 16),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: _filteredCities.length,
                        itemBuilder: (context, index) {
                          final city = _filteredCities[index];
                          final name = city['name'] ?? '';
                          final state = city['state'] ?? '';
                          final metroArea = city['metro_area'] ?? '';
                          final isMetro = metroArea.isNotEmpty;

                          return ListTile(
                            leading: Icon(
                              isMetro ? Icons.location_city : Icons.location_on,
                              color: isMetro ? Colors.blue : Colors.grey,
                            ),
                            title: Text(
                              name,
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            subtitle: Text(
                              isMetro ? '$state · Área: $metroArea' : state,
                            ),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () {
                              final provider = context.read<AppStateProvider>();
                              provider.setSelectedCity(name, metroArea);
                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
