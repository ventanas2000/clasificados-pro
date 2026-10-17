import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

/// Servicio de inicialización de Firebase
///
/// Maneja la configuración e inicialización de Firebase para toda la app.
/// Debe ser llamado antes que cualquier otro servicio de Firebase.
class FirebaseService {
  static FirebaseApp? _app;

  /// Indica si Firebase ya fue inicializado
  static bool get isInitialized => _app != null;

  /// Inicializa Firebase con la configuración por defecto.
  ///
  /// Si ya está inicializado, retorna la instancia existente sin error.
  /// Retorna la [FirebaseApp] lista para usar.
  static Future<FirebaseApp> initialize() async {
    if (_app != null) {
      return _app!;
    }

    try {
      _app = await Firebase.initializeApp();
      debugPrint('[FirebaseService] Firebase inicializado correctamente.');
      return _app!;
    } on FirebaseException catch (e) {
      debugPrint(
        '[FirebaseService] Error al inicializar Firebase: ${e.code} - ${e.message}',
      );
      rethrow;
    } catch (e) {
      debugPrint('[FirebaseService] Error inesperado: $e');
      rethrow;
    }
  }

  /// Obtiene la instancia actual de FirebaseApp.
  ///
  /// Lanza un [StateError] si aún no se ha inicializado Firebase.
  static FirebaseApp get app {
    if (_app == null) {
      throw StateError(
        'Firebase no ha sido inicializado. Llama a FirebaseService.initialize() primero.',
      );
    }
    return _app!;
  }
}
