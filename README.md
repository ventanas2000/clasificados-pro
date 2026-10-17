# Clasificados Pro 📱

App móvil de clasificados hiper-local para Guadalajara, Jalisco. Flutter + Firebase.

## Características

- **4 categorías**: Servicios, Transporte/Personal, Bienes/Activos, Empleos
- **Ubicación híbrida**: GPS automático + navegación manual (País → Estado → Ciudad)
- **Wizard de 3 pasos** para publicar anuncios
- **Modelo freemium**: primer anuncio gratis, Bump Ads, Suscripción Pro
- **Expiración inteligente**: Servicios 60 días, Transporte 30 días, Bienes 20 días, Empleos 20 días

## Stack Tecnológico

| Capa | Tecnología |
|------|-----------|
| Frontend | Flutter (Dart) |
| Estado | Provider |
| Auth | Firebase Auth (email + Google) |
| Base de datos | Cloud Firestore |
| Almacenamiento | Cloud Storage |
| Notificaciones | Firebase Cloud Messaging |
| Pagos | Stripe / RevenueCat (pendiente) |
| Analytics | Firebase Analytics + Crashlytics |

## Estructura del Proyecto

```
clasificados_pro_app/
├── lib/
│   ├── main.dart                    # Punto de entrada
│   ├── models/
│   │   ├── ad_model.dart            # Modelo de anuncio
│   │   └── taxonomy.dart            # Categorías y subcategorías
│   ├── providers/
│   │   └── app_state_provider.dart  # Estado global (Provider)
│   ├── screens/
│   │   ├── home_screen.dart         # Feed principal
│   │   ├── create_ad_wizard.dart    # Controlador del wizard
│   │   ├── category_selection_screen.dart
│   │   ├── ad_details_screen.dart
│   │   └── location_contact_screen.dart
│   └── widgets/
│       └── ad_card.dart             # Tarjeta de anuncio
├── pubspec.yaml
└── README.md
```

## Desarrollo

```bash
# Instalar dependencias
flutter pub get

# Ejecutar en modo desarrollo
flutter run

# Ejecutar tests
flutter test

# Build para producción
flutter build apk --release
flutter build ios --release
```

## Roadmap

- [x] Estructura base del proyecto
- [x] Modelos de datos
- [x] Pantallas principales
- [ ] Firebase Auth (email + Google)
- [ ] Cloud Firestore (anuncios reales)
- [ ] Cloud Storage (fotos)
- [ ] Sistema de pagos (Stripe/RevenueCat)
- [ ] Notificaciones push
- [ ] Expiración automática
- [ ] Analytics y monitoreo

## Licencia

MIT
