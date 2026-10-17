# Programa de Trabajo
## Clasificados Pro — App de Clasificados Hiperlocales
**Guadalajara, Jalisco, México · v1.0 · 17 de octubre de 2026**

---

## 1. Punto de partida (estado real del proyecto)

Hoy existen dos prototipos en Flutter:

| Prototipo | Manejo de estado | Líneas | Qué incluye |
|---|---|---|---|
| `clasificados_pro_app` | Provider | ~2,600 | Auth (email + Google), Firestore (users/ads), pantallas Home / Crear anuncio / Detalle |
| `clasificados_pro` | setState | ~1,625 | Taxonomía, selección de categoría, ubicación y contacto, tarjeta de anuncio |

Servicios Firebase ya escritos: `FirebaseService` (init), `AuthService`, `FirestoreService`.
Dependencias ya declaradas: firebase_core / auth / firestore / storage / messaging, google_sign_in, image_picker, geolocator, go_router, provider.

Roadmap abierto en GitHub: 7 issues (Auth, Firestore, Fotos, Pagos, Push, Expiración, Marketing).

**Conclusión:** hay base real, pero dividida en dos apps. El primer paso no es programar más: es decidir una sola línea de trabajo.

---

## 2. Lo más adecuado (decisión de arquitectura)

El plan anterior (8 semanas, 6 personas, $722,150 MXN) no aplica: no hay equipo de 6 ni ese presupuesto. El proyecto lo lleva una persona (tú) con Hermes como asistente. Por eso:

1. **Una sola app:** quedarse con `clasificados_pro_app` (Provider). Es la más completa y ya tiene los servicios Firebase.
2. **Archivar `clasificados_pro`** (setState): conservar su código como referencia, no seguirlo desarrollando. Evita mantener dos códigos.
3. **Sin agencia:** sprints cortos de 1 semana, tú decides prioridades, Hermes ayuda a programar y revisar.
4. **MVP primero:** lanzar lo antes posible con lo esencial; pagos y push después.

---

## 3. Limpieza del repositorio (recomendación)

El repo `github.com/ventanas2000/clasificados-pro` se creó desde una plantilla de ejercicio y arrastró cosas que no son del proyecto:

- 2 commits automáticos del ejercicio ("Start exercise", "Create config and homepages files") y los archivos `index.md` / `_config.yml`.
- Workflows `0-start-exercise.yml`, `1-step.yml` … `4-step.yml` (del exercise-toolkit).
- Issue #8 "Exercise: GitHub Pages".

**Recomendación:** limpiar el repo y dejar `main` en el commit del proyecto. Es recuperable (los commits quedan en el historial de GitHub), pero como implica reescribir la rama `main`, conviene confirmarlo antes.

---

## 4. Programa de trabajo por sprints

Cada sprint = 1 semana. El orden está pensado para tener algo lanzable lo antes posible.

### Sprint 0 — Fundamentos (esta semana)
- Elegir `clasificados_pro_app` como app única; archivar la otra.
- Limpiar el repo (ver sección 3).
- Crear el proyecto real en Firebase Console (entorno dev).
- Definir reglas de seguridad de Firestore y Storage.
- **Entregable:** repo limpio + proyecto Firebase funcionando.

### Sprint 1 — Autenticación
- Pantalla de login / registro (email + contraseña).
- Google Sign-In.
- Guardar perfil en Firestore (`users/{uid}`).
- **Entregable:** entrar y salir de la app con cuenta real.

### Sprint 2 — Anuncios (CRUD)
- Modelo de datos Firestore (`ads`) y validaciones.
- Crear anuncio (título, descripción, precio, categoría, colonia).
- Editar y eliminar anuncios propios.
- "Mis anuncios" (dashboard del usuario).
- **Entregable:** publicar un anuncio y verlo en tu lista.

### Sprint 3 — Fotos
- Selector de imágenes (`image_picker`), compresión.
- Subida a Firebase Storage con reglas.
- Mostrar imágenes en Home y Detalle.
- **Entregable:** anuncio con fotos reales.

### Sprint 4 — Home y búsqueda hiperlocal
- Home con listado de anuncios (más recientes).
- Filtros por categoría, precio y colonia/distancia.
- Geolocalización del usuario (`geolocator`).
- **Entregable:** buscar anuncios cerca de ti.

### Sprint 5 — Expiración automática
- Marcar anuncios como expirados a los N días.
- Opción: Cloud Functions (trigger programado) o lógica en la app.
- **Entregable:** los anuncios viejos dejan de aparecer.

### Sprint 6 — Notificaciones push (FCM)
- Configurar Firebase Cloud Messaging.
- Notificar: nuevo anuncio en tu colonia, respuestas.
- **Entregable:** llegar notificaciones reales al dispositivo.

### Sprint 7 — Pagos (el más pesado)
- Cuentas en Stripe y consolas de Apple/Google.
- Bump Ads (pago único por destacado).
- Suscripción Pro (mensual/anual).
- Webhooks y validación de recibos.
- **Entregable:** comprar un Bump y ver el anuncio destacado.

### Sprint 8 — QA, beta y lanzamiento
- Pruebas en dispositivo real (Android).
- Beta cerrada con 10 usuarios de Guadalajara.
- Assets para tiendas (icono, capturas, descripción).
- Publicar en Google Play y App Store.
- **Entregable:** app pública.

---

## 5. Prioridad: qué hace primero

| Prioridad | Qué | Por qué |
|---|---|---|
| 1 (ya) | Auth + Firestore | Sin esto no hay app |
| 2 | Anuncios CRUD | Es el producto |
| 3 | Fotos | Sin fotos no es un clasificado |
| 4 | Home + búsqueda | Es lo que usa la gente |
| 5 | Expiración | Mantiene el catálogo limpio |
| 6 | Push | Engagement |
| 7 | Pagos | Ingresos (pero requiere cuentas externas) |

**Regla:** no empezar Pagos hasta que el MVP (1–4) esté en manos de usuarios reales.

---

## 6. Riesgos y mitigación

| Riesgo | Mitigación |
|---|---|
| Mantener dos apps y perder tiempo | Quedarse con una desde el Sprint 0 |
| Firebase fuera de presupuesto | Plan gratis (Spark) para el MVP; medir uso |
| Cuentas de Stripe/Apple/Google tardan | Tramitarlas en paralelo desde el Sprint 5 |
| Revisión de Apple rechaza la app | Enviar 3 días antes; cumplir políticas desde el inicio |
| El proyecto se estanca | Sprints de 1 semana con entregable obligatorio |

---

## 7. Criterios de éxito

- App funcionando con Auth + anuncios + fotos en menos de 5 sprints.
- Beta con 10 usuarios reales de Guadalajara.
- Publicada en Google Play y App Store.
- Primeros anuncios pagados (Bump/Pro) antes de terminar el mes.

---

## 8. Próximos pasos inmediatos

1. Confirmar: ¿limpio el repo del ruido del ejercicio?
2. Crear el proyecto Firebase (te paso los pasos exactos).
3. Archivar `clasificados_pro` y seguir con `clasificados_pro_app`.
4. Empezar el Sprint 1 (Auth).

---

**Documento preparado para:** Rodrigo · Clasificados Pro
**Versión:** 1.0 · 17 de octubre de 2026
