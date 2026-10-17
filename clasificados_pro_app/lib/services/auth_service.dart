import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Servicio de Autenticación con Firebase
///
/// Maneja todas las operaciones de autenticación: email/password,
/// Google Sign-In, y el stream de cambios de estado de autenticación.
///
/// Uso con Provider:
///   final auth = context.read<AuthService>();
///   await auth.signUpWithEmail(email: ..., password: ..., name: ...);
class AuthService {
  AuthService({FirebaseAuth? auth})
      : _auth = auth ?? FirebaseAuth.instance;

  final FirebaseAuth _auth;

  /// Instancia de Google Sign-In
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  // ===================== Usuario Actual =====================

  /// Retorna el usuario autenticado actual o null si no hay sesión.
  User? get getCurrentUser => _auth.currentUser;

  /// Retorna el UID del usuario actual o null.
  String? get currentUserId => _auth.currentUser?.uid;

  /// Indica si hay un usuario autenticado.
  bool get isSignedIn => _auth.currentUser != null;

  // ===================== Stream de Estado =====================

  /// Stream que emite eventos cuando cambia el estado de autentificación.
  ///
  /// Emite [User?] (null cuando el usuario cierra sesión).
  /// Útil para redirectear en la UI (login ↔ home).
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // ===================== Email / Password =====================

  /// Inicia sesión con correo electrónico y contraseña.
  ///
  /// Retorna el [UserCredential] exitoso.
  /// Lanza [FirebaseAuthException] con código descriptivo si falla.
  Future<UserCredential> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      debugPrint('[AuthService] Inicio de sesión exitoso: ${credential.user?.uid}');
      return credential;
    } on FirebaseAuthException catch (e) {
      debugPrint('[AuthService] Error signInWithEmail: ${e.code}');
      throw _mapAuthException(e);
    }
  }

  /// Registra un nuevo usuario con correo y contraseña.
  ///
  /// Actualiza el displayName del usuario con el nombre proporcionado.
  /// Retorna el [UserCredential] con el usuario recién creado.
  Future<UserCredential> signUpWithEmail({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      // Actualizar el nombre del perfil
      await credential.user?.updateDisplayName(name.trim());
      // Recargar para reflejar el cambio
      await credential.user?.reload();

      debugPrint('[AuthService] Usuario registrado: ${credential.user?.uid}');
      return credential;
    } on FirebaseAuthException catch (e) {
      debugPrint('[AuthService] Error signUpWithEmail: ${e.code}');
      throw _mapAuthException(e);
    }
  }

  // ===================== Google Sign-In =====================

  /// Inicia sesión con Google.
  ///
  /// Abre el selector nativo de cuenta de Google.
  /// Retorna [UserCredential] con el usuario autenticado.
  ///
  /// Nota: requiere configurar las credenciales de OAuth en Firebase Console.
  Future<UserCredential> signInWithGoogle() async {
    try {
      // Disparar el flujo de autenticación de Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // El usuario canceló el flujo
        throw Exception('Inicio de sesión con Google cancelado por el usuario.');
      }

      // Obtener tokens de autenticación
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Crear credencial de Firebase con los tokens de Google
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Iniciar sesión en Firebase con la credencial
      final userCredential = await _auth.signInWithCredential(credential);

      debugPrint(
        '[AuthService] Google Sign-In exitoso: ${userCredential.user?.uid}',
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      debugPrint('[AuthService] Error Firebase en Google Sign-In: ${e.code}');
      throw _mapAuthException(e);
    } catch (e) {
      debugPrint('[AuthService] Error en Google Sign-In: $e');
      throw Exception('Error al iniciar sesión con Google. Inténtalo de nuevo.');
    }
  }

  // ===================== Cerrar Sesión =====================

  /// Cierra la sesión del usuario actual tanto en Firebase como en Google.
  Future<void> signOut() async {
    try {
    // Cerrar sesión en Google solo si hay un usuario activo
      await _googleSignIn.signOut();
      await _auth.signOut();
      debugPrint('[AuthService] Sesión cerrada exitosamente.');
    } on FirebaseAuthException catch (e) {
      debugPrint('[AuthService] Error al cerrar sesión: ${e.code}');
      throw _mapAuthException(e);
    }
  }

  // ===================== Utilidades =====================

  /// Mapea [FirebaseAuthException] a un mensaje legible en español.
  String _mapAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'El correo electrónico no es válido.';
      case 'user-disabled':
        return 'Esta cuenta ha sido deshabilitada.';
      case 'user-not-found':
        return 'No existe una cuenta con este correo.';
      case 'wrong-password':
        return 'Contraseña incorrecta.';
      case 'email-already-in-use':
        return 'Ya existe una cuenta con este correo.';
      case 'weak-password':
        return 'La contraseña es muy débil. Usa al menos 6 caracteres.';
      case 'invalid-credential':
        return 'Credenciales inválidas. Verifica tu correo y contraseña.';
      case 'account-exists-with-different-credential':
        return 'Ya existe una cuenta con este correo pero con otro método de autenticación.';
      case 'operation-not-allowed':
        return 'Este método de autenticación no está habilitado.';
      case 'too-many-requests':
        return 'Demasiados intentos. Intenta más tarde.';
      case 'network-request-failed':
        return 'Error de conexión. Verifica tu internet.';
      default:
        return 'Error de autenticación: ${e.message ?? "desconocido"}';
    }
  }
}
