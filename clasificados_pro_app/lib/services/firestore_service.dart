import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../models/ad_model.dart';

/// Servicio de Firestore para operaciones CRUD de anuncios y perfiles.
///
/// Todas las operaciones trabajan con las colecciones:
///   - users/{userId}   → perfil de usuario
///   - ads/{adId}       → anuncios con campos que mapean a [AdModel]
class FirestoreService {
  FirestoreService({FirebaseFirestore? firestore})
      : _db = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _db;

  // Referencias a colecciones para reutilizar
  CollectionReference get _usersRef => _db.collection('users');
  CollectionReference get _adsRef => _db.collection('ads');

  // ===================== Perfiles de Usuario =====================

  /// Crea o actualiza el documento del perfil en Firestore.
  ///
  /// Se debe llamar después de registrar un nuevo usuario en Auth
  /// para sincronizar su información con la base de datos.
  Future<void> createUserProfile({
    required String userId,
    required String name,
    required String email,
    String phoneNumber = '',
  }) async {
    try {
      await _usersRef.doc(userId).set({
        'id': userId,
        'name': name.trim(),
        'email': email.trim().toLowerCase(),
        'phone_number': phoneNumber.trim(),
        'is_pro': false,
        'pro_expires_at': null,
        'ads_count': 0,
        'first_ad_free': true,
        'created_at': FieldValue.serverTimestamp(),
      });
      debugPrint('[FirestoreService] Perfil creado para: $userId');
    } on FirebaseException catch (e) {
      debugPrint('[FirestoreService] Error creando perfil: ${e.code}');
      throw Exception('Error al crear el perfil de usuario.');
    }
  }

  /// Obtiene el perfil de usuario desde Firestore.
  ///
  /// Retorna un [Map<String, dynamic>] con los datos del usuario.
  /// Lanza [Exception] si el perfil no existe o hay error de red.
  Future<Map<String, dynamic>> getUserProfile(String userId) async {
    try {
      final doc = await _usersRef.doc(userId).get();
      if (!doc.exists) {
        throw Exception('Perfil de usuario no encontrado.');
      }
      return doc.data() as Map<String, dynamic>;
    } on FirebaseException catch (e) {
      debugPrint('[FirestoreService] Error obteniendo perfil: ${e.code}');
      throw Exception('Error al obtener el perfil de usuario.');
    }
  }

  /// Actualiza campos específicos del perfil de usuario.
  ///
  /// Solo incluye los campos proporcionados en [data].
  Future<void> updateUserProfile({
    required String userId,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _usersRef.doc(userId).update(data);
      debugPrint('[FirestoreService] Perfil actualizado: $userId');
    } on FirebaseException catch (e) {
      debugPrint('[FirestoreService] Error actualizando perfil: ${e.code}');
      throw Exception('Error al actualizar el perfil.');
    }
  }

  /// Incrementa el contador de anuncios del usuario.
  Future<void> incrementAdsCount(String userId) async {
    try {
      await _usersRef.doc(userId).update({
        'ads_count': FieldValue.increment(1),
      });
    } on FirebaseException catch (e) {
      debugPrint('[FirestoreService] Error incrementando adsCount: ${e.code}');
      // No lanzamos excepción: no es crítico para el flujo principal
    }
  }

  /// Marca el primer anuncio como usado (isFirstAdFree = false).
  Future<void> markFirstAdAsUsed(String userId) async {
    try {
      await _usersRef.doc(userId).update({'first_ad_free': false});
    } on FirebaseException catch (e) {
      debugPrint('[FirestoreService] Error marcando primer anuncio: ${e.code}');
    }
  }

  // ===================== Anuncios — CRUD =====================

  /// Crea un nuevo anuncio en Firestore.
  ///
  /// El [adId] se genera automáticamente por Firestore si está vacío.
  /// Retorna el ID del anuncio creado.
  Future<String> createAd(AdModel ad) async {
    try {
      // Generar ID si no viene uno
      final docRef = ad.id.isEmpty ? _adsRef.doc() : _adsRef.doc(ad.id);

      // Datos del anuncio para Firestore
      final data = {
        'title': ad.title.trim(),
        'description': ad.description.trim(),
        'category_id': ad.categoryId,
        'category_name': ad.categoryName,
        'price': ad.price,
        'currency': ad.currency,
        'user_id': ad.userId,
        'user_name': ad.userName,
        'is_pro': ad.isPro,
        'country': ad.country,
        'state': ad.state,
        'city': ad.city,
        'metro_area': ad.metroArea,
        'latitude': ad.latitude,
        'longitude': ad.longitude,
        'created_at': FieldValue.serverTimestamp(),
        'expires_at': ad.expiresAt.toIso8601String(),
        'is_expired': ad.isExpired,
        'is_bumped': ad.isBumped,
        'images': ad.imageUrls,
        'primary_image': ad.primaryImageUrl,
        'phone_number': ad.phoneNumber,
        'email': ad.email,
      };

      await docRef.set(data);

      // Incrementar contador de anuncios del usuario
      await incrementAdsCount(ad.userId);

      debugPrint('[FirestoreService] Anuncio creado: ${docRef.id}');
      return docRef.id;
    } on FirebaseException catch (e) {
      debugPrint('[FirestoreService] Error creando anuncio: ${e.code}');
      throw Exception('Error al crear el anuncio. Inténtalo de nuevo.');
    }
  }

  /// Actualiza un anuncio existente.
  ///
  /// Solo modifica los campos proporcionados en [ad].
  /// Retorna true si el anuncio existió y fue actualizado.
  Future<bool> updateAd(AdModel ad) async {
    try {
      final doc = await _adsRef.doc(ad.id).get();
      if (!doc.exists) {
        debugPrint('[FirestoreService] Anuncio no encontrado: ${ad.id}');
        return false;
      }

      await _adsRef.doc(ad.id).update({
        'title': ad.title.trim(),
        'description': ad.description.trim(),
        'category_id': ad.categoryId,
        'category_name': ad.categoryName,
        'price': ad.price,
        'currency': ad.currency,
        'country': ad.country,
        'state': ad.state,
        'city': ad.city,
        'metro_area': ad.metroArea,
        'latitude': ad.latitude,
        'longitude': ad.longitude,
        'is_pro': ad.isPro,
        'is_bumped': ad.isBumped,
        'images': ad.imageUrls,
        'primary_image': ad.primaryImageUrl,
        'phone_number': ad.phoneNumber,
        'email': ad.email,
      });

      debugPrint('[FirestoreService] Anuncio actualizado: ${ad.id}');
      return true;
    } on FirebaseException catch (e) {
      debugPrint('[FirestoreService] Error actualizando anuncio: ${e.code}');
      throw Exception('Error al actualizar el anuncio.');
    }
  }

  /// Elimina un anuncio de Firestore por su ID.
  ///
  /// Retorna true si fue eliminado, false si no existía.
  Future<bool> deleteAd(String adId) async {
    try {
      await _adsRef.doc(adId).delete();
      debugPrint('[FirestoreService] Anuncio eliminado: $adId');
      return true;
    } on FirebaseException catch (e) {
      debugPrint('[FirestoreService] Error eliminando anuncio: ${e.code}');
      throw Exception('Error al eliminar el anuncio.');
    }
  }

  // ===================== Anuncios — Consultas =====================

  /// Stream de todos los anuncios activos ordenados por fecha descendente.
  ///
  /// Útil para la pantalla principal: la UI se actualiza en tiempo real.
  Stream<List<AdModel>> getAds() {
    return _adsRef
        .where('is_expired', isEqualTo: false)
        .orderBy('created_at', descending: true)
        .snapshots()
        .map(_mapQuerySnapshotToAds);
  }

  /// Stream de anuncios filtrados por área metropolitana.
  ///
  /// [metroArea] coincide con el campo `metro_area` en Firestore.
  /// Si está vacío, retorna todos los anuncios activos.
  Stream<List<AdModel>> getAdsByMetroArea(String metroArea) {
    if (metroArea.isEmpty) {
      return getAds();
    }
    return _adsRef
        .where('is_expired', isEqualTo: false)
        .where('metro_area', isEqualTo: metroArea)
        .orderBy('created_at', descending: true)
        .snapshots()
        .map(_mapQuerySnapshotToAds);
  }

  /// Obtiene la lista de ciudades activas desde Firestore.
  ///
  /// Lee de la colección `cities` donde cada documento tiene:
  /// name, state, country, metro_area, is_active, created_at
  Future<List<Map<String, dynamic>>> getCities() async {
    try {
      final snapshot = await _db.collection('cities')
          .where('is_active', isEqualTo: true)
          .orderBy('state')
          .orderBy('name')
          .get();
      return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } on FirebaseException catch (e) {
      debugPrint('[FirestoreService] Error obteniendo ciudades: ${e.code}');
      return [];
    }
  }

  /// Obtiene anuncios filtrados por categoría.
  ///
  /// [categoryId] coincide con el campo `category_id` en Firestore.
  Stream<List<AdModel>> getAdsByCategory(String categoryId) {
    return _adsRef
        .where('is_expired', isEqualTo: false)
        .where('category_id', isEqualTo: categoryId)
        .orderBy('created_at', descending: true)
        .snapshots()
        .map(_mapQuerySnapshotToAds);
  }

  /// Obtiene los anuncios de un usuario específico (stream).
  ///
  /// Retorna tiempo real de todos los anuncios del usuario,
  /// incluyendo los expirados.
  Stream<List<AdModel>> getAdsByUser(String userId) {
    return _adsRef
        .where('user_id', isEqualTo: userId)
        .orderBy('created_at', descending: true)
        .snapshots()
        .map(_mapQuerySnapshotToAds);
  }

  /// Obtiene todos los anuncios activos como lista única (Future).
  ///
  /// Ideal para sincronizar el estado inicial o para búsqueda local.
  Future<List<AdModel>> getAllActiveAds() async {
    try {
      final snapshot = await _adsRef
          .where('is_expired', isEqualTo: false)
          .orderBy('created_at', descending: true)
          .get();

      return _mapQuerySnapshotToAds(snapshot);
    } on FirebaseException catch (e) {
      debugPrint('[FirestoreService] Error obteniendo anuncios: ${e.code}');
      throw Exception('Error al cargar los anuncios.');
    }
  }

  // ===================== Búsqueda =====================

  /// Busca anuncios por título o descripción que coincidan con [query].
  ///
  /// Realiza la búsqueda local sobre todos los anuncios activos
  /// para evitar costos por consultas compuestas en Firestore.
  ///
  /// Retorna una lista de [AdModel] que contienen [query] en título
  /// o descripción (case-insensitive).
  Future<List<AdModel>> searchAds(String query) async {
    if (query.trim().isEmpty) {
      return [];
    }

    try {
      final ads = await getAllActiveAds();
      final lowerQuery = query.toLowerCase().trim();

      return ads.where((ad) {
        return ad.title.toLowerCase().contains(lowerQuery) ||
            ad.description.toLowerCase().contains(lowerQuery) ||
            ad.categoryName.toLowerCase().contains(lowerQuery);
      }).toList();
    } catch (e) {
      debugPrint('[FirestoreService] Error en búsqueda: $e');
      throw Exception('Error al buscar anuncios.');
    }
  }

  // ===================== Anuncios Pro =====================

  /// Obtiene los anuncios destacados (Pro + bump) para la sección premium.
  ///
  /// Prioriza los bump (primero) y luego los Pro.
  Stream<List<AdModel>> getFeaturedAds() {
    return _adsRef
        .where('is_expired', isEqualTo: false)
        .where('is_bumped', isEqualTo: true)
        .orderBy('created_at', descending: true)
        .limit(10)
        .snapshots()
        .map(_mapQuerySnapshotToAds);
  }

  /// Obtiene anuncios Pro (sin bump) para la sección de destacados secundaria.
  Stream<List<AdModel>> getProAds() {
    return _adsRef
        .where('is_expired', isEqualTo: false)
        .where('is_pro', isEqualTo: true)
        .orderBy('created_at', descending: true)
        .limit(20)
        .snapshots()
        .map(_mapQuerySnapshotToAds);
  }

  // ===================== Utilidades Internas =====================

  /// Convierte un [QuerySnapshot] a una lista de [AdModel].
  List<AdModel> _mapQuerySnapshotToAds(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;

      // Manejar timestamps de Firestore (Timestamp → DateTime)
      final createdAt = data['created_at'] is Timestamp
          ? (data['created_at'] as Timestamp).toDate()
          : DateTime.now();

      final expiresAtStr = data['expires_at'] as String?;
      final expiresAt = expiresAtStr != null
          ? DateTime.parse(expiresAtStr)
          : DateTime.now().add(const Duration(days: 30));

      return AdModel(
        id: doc.id,
        title: data['title'] ?? '',
        description: data['description'] ?? '',
        categoryId: data['category_id'] ?? '',
        categoryName: data['category_name'] ?? '',
        price: (data['price'] ?? 0).toDouble(),
        currency: data['currency'] ?? 'MXN',
        userId: data['user_id'] ?? '',
        userName: data['user_name'] ?? '',
        isPro: data['is_pro'] ?? false,
        country: data['country'] ?? '',
        state: data['state'] ?? '',
        city: data['city'] ?? '',
        metroArea: data['metro_area'] ?? '',
        latitude: data['latitude']?.toDouble(),
        longitude: data['longitude']?.toDouble(),
        createdAt: createdAt,
        expiresAt: expiresAt,
        isExpired: data['is_expired'] ?? false,
        isBumped: data['is_bumped'] ?? false,
        imageUrls: List<String>.from(data['images'] ?? []),
        primaryImageUrl: data['primary_image'] ?? '',
        phoneNumber: data['phone_number'] ?? '',
        email: data['email'],
      );
    }).toList();
  }
}
