import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state_provider.dart';
import '../services/firestore_service.dart';

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
  List<Map<String, dynamic>> _cities = [];
  List<Map<String, dynamic>> _filteredCities = [];
  bool _isLoading = true;
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
            padding: const EdgeInsets.all(16),
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
                            onTap: {
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
