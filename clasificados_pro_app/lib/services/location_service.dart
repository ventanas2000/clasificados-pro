import 'dart:async';
import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

/// Resultado de la ubicación obtenida por GPS.
class LocationResult {
  final double latitude;
  final double longitude;
  final String cityName;

  const LocationResult({
    required this.latitude,
    required this.longitude,
    required this.cityName,
  });
}

/// Servicio de geolocalización: permisos + posición + geocodificación inversa.
///
/// Flujo: se pide el permiso de ubicación, se obtiene la posición actual con
/// `geolocator` y se traduce a un nombre de ciudad con OpenStreetMap
/// (Nominatim), que es gratuito y no requiere llave de API.
class LocationService {
  static const String _reverseUrl =
      'https://nominatim.openstreetmap.org/reverse';

  /// Verifica (y de ser necesario pide) el permiso de ubicación.
  ///
  /// Regresa `true` si el permiso quedó concedido. Si el usuario lo negó de
  /// forma permanente, abre los ajustes de la app y regresa `false`.
  Future<bool> ensurePermission() async {
    var status = await Permission.location.status;
    if (status.isGranted || status.isLimited) return true;

    if (status.isPermanentlyDenied || status.isRestricted) {
      await openAppSettings();
      return false;
    }

    status = await Permission.location.request();
    return status.isGranted || status.isLimited;
  }

  /// Obtiene la posición actual y la ciudad detectada.
  ///
  /// Regresa `null` si no hay permiso, el GPS está apagado o no se pudo
  /// determinar la ubicación en un tiempo razonable.
  Future<LocationResult?> getCurrent() async {
    final granted = await ensurePermission();
    if (!granted) return null;

    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return null;

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    ).timeout(const Duration(seconds: 25));

    final cityName = await reverseGeocode(position.latitude, position.longitude);

    return LocationResult(
      latitude: position.latitude,
      longitude: position.longitude,
      cityName: cityName ?? '',
    );
  }

  /// Convierte coordenadas en un nombre de ciudad usando OpenStreetMap.
  Future<String?> reverseGeocode(double latitude, double longitude) async {
    try {
      final uri = Uri.parse(
        '$_reverseUrl?format=jsonv2&lat=$latitude&lon=$longitude'
        '&zoom=10&accept-language=es',
      );

      final response = await http
          .get(uri, headers: const {'User-Agent': 'ClasificadosPro/1.0'})
          .timeout(const Duration(seconds: 15));

      if (response.statusCode != 200) return null;

      final data = json.decode(response.body) as Map<String, dynamic>;
      final address = data['address'] as Map<String, dynamic>? ?? {};

      // Nominatim usa distintas claves según el tipo de asentamiento.
      for (final key in const [
        'city',
        'town',
        'village',
        'municipality',
        'county',
      ]) {
        final name = (address[key] ?? '').toString().trim();
        if (name.isNotEmpty) return name;
      }
      return null;
    } catch (_) {
      return null;
    }
  }
}
