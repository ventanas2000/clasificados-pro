# Plan de Ejecución del Proyecto
## Clasificados Pro — App de Clasificados Hiperlocales para Guadalajara, México

---

**Fecha de elaboración:** 17 de octubre de 2026  
**Duración total:** 8 semanas  
**Moneda de referencia:** Peso Mexicano (MXN)  
**Metodología:** Scrum adaptado (sprints de 1 semana)  

---

## 1. Visión General y Objetivos

### 1.1 Descripción del Proyecto

**Clasificados Pro** es una aplicación móvil desarrollada en Flutter que permite a los residentes de Guadalajara, Jalisco, publicar, buscar y contactar anuncios clasificados de manera hiperlocal. La app opera bajo un modelo freemium con suscripciones "Bump Ads" y "Pro", apoyada en un backend de Firebase (Auth, Firestore, Storage y Cloud Functions).

### 1.2 Objetivos Estratégicos

| # | Objetivo | Métrica de Éxito |
|---|---------|------------------|
| 1 | Lanzar una app Flutter funcional en Guadalajara | Disponible en App Store y Google Play al final de la semana 8 |
| 2 | Implementar sistema de monetización freemium | Pagos integrados y funcionales vía Stripe/Play Store |
| 3 | Arquitectura escalable basada en Firebase | ≤200ms latencia promedio en consultas Firestore |
| 4 | Experiencia de usuario profesional | ≥4.5★ en tiendas de aplicaciones post-lanzamiento |
| 5 | Cobertura de pruebas ≥80% | Reporte de cobertura generado en semana 7 |

### 1.3 Alcance

**Dentro del alcance:**
- Autenticación (email, Google, Apple)
- Creación y gestión de anuncios (texto, imágenes, ubicación GPS)
- Búsqueda y filtros hiperlocales (colonia, categoría, distancia)
- Sistema de pagos y suscripciones (Bump Ads, Pro)
- Notificaciones push
- Panel de administración básico
- Integración con mapas (Google Maps SDK)

**Fuera del alcance:**
- Mensajería in-app entre usuarios (fase 2)
- Sistema de reseñas y calificaciones (fase 2)
- Versión web (fase 2)
- Multilingüismo (fase 2)

### 14 Stakeholders

| Rol | Responsabilidad |
|-----|-----------------|
| Product Owner | Priorización, aprobación de features, aceptación de sprints |
| Tech Lead / Dev Sr. | Arquitectura, code review, decisiones técnicas |
| Desarrollador Flutter Jr. | Implementación de features, corrección de bugs |
| Diseñador UI/UX | Prototipos, design system, assets visuales |
| QA Tester | Plan de pruebas, ejecución, reporte de incidencias |
| Marketing Lead | Estrategia de lanzamiento, contenido, métricas de adquisición |

---

## 2. Estructura de Desglose del Trabajo (WBS)

### Nivel 1 — Proyecto Clasificados Pro

```
1.0 Clasificados Pro
├── 1.1 Setup y Arquitectura
│   ├── 1.1.1 Configuración de proyecto Flutter y repositorio Git
│   ├── 1.1.2 Configuración de Firebase (Auth, Firestore, Storage, Functions)
│   ├── 1.1.3 CI/CD pipeline (GitHub Actions + Codemagic/Fastlane)
│   ├── 1.1.4 Design system y guía de estilos
│   └── 1.1.5 Arquitectura de carpetas y patrones (BLoC/Riverpod)
│
├── 1.2 Funcionalidades Nucleo
│   ├── 1.2.1 Autenticación (Email, Google Sign-In, Apple Sign-In)
│   ├── 1.2.2 Perfil de usuario
│   ├── 1.2.3 Creación de anuncios (imagen, texto, GPS, categoría)
│   ├── 1.2.4 Edición y eliminación de anuncios
│   ├── 1.2.5 Mis anuncios (dashboard del usuario)
│   └── 1.2.6 Modelado de datos Firestore
│
├── 1.3 Funcionalidades Avanzadas
│   ├── 1.3.1 Sistema de pagos y suscripciones (Bump Ads, Pro)
│   ├── 1.3.2 Notificaciones push (FCM)
│   ├── 1.3.3 Búsqueda avanzada con filtros hiperlocales
│   ├── 1.3.4 Integración Google Maps
│   ├── 1.3.5 Bump Ads (posicionamiento destacado)
│   └── 1.3.6 Subida de imágenes a Firebase Storage
│
├── 1.4 Pruebas y QA
│   ├── 1.4.1 Plan de pruebas
│   ├── 1.4.2 Pruebas unitarias
│   ├── 1.4.3 Pruebas de integración
│   ├── 1.4.4 Pruebas de widgets/UI
│   ├── 1.4.5 Pruebas beta (TestFlight / Internal Testing)
│   └── 1.4.6 Corrección de bugs críticos
│
├── 1.5 Lanzamiento y Marketing
│   ├── 1.5.1 Preparación de tiendas (assets, descripciones, screenshots)
│   ├── 1.5.2 Estrategia de lanzamiento (soft launch GDL)
│   ├── 1.5.3 Campaña en redes sociales
│   ├── 1.5.4 Optimización ASO
│   ├── 1.5.5 Monitoreo post-lanzamiento
│   └── 1.5.6 Métricas de adquisición y retención
│
└── 1.6 Gestión de Proyecto
    ├── 1.6.1 Sprint planning y daily standups
    ├── 1.6.2 Sprint review y retrospective
    ├── 1.6.3 Gestión de riesgos
    └── 1.6.4 Comunicación con stakeholders
```

---

## 3. Cronograma Detallado — Timeline por Fases y Sprints

### Fase 1: Setup y Arquitectura (Semanas 1–2)

#### Semana 1 — Fundamentos Técnicos

| Día | Actividad | Responsable | Entregable |
|-----|-----------|-------------|------------|
| Lun 19 oct | Kickoff de proyecto, definición de roles, setup de herramientas (Jira/Notion, Slack) | Product Owner | Acta de kickoff, tablero de proyecto creado |
| Mar 20 oct | Creación del repositorio GitHub, estructura base del proyecto Flutter (arquitectura limpia), configuración de Firebase console | Tech Lead | Repo GitHub con estructura de carpetas, proyecto Firebase "clasificados-pro-gdl" |
| Mié 21 oct | Configuración de entornos (dev, staging, prod) en Firebase; reglas de seguridad de Firestore y Storage | Tech Lead | Firestore rules desplegadas, Storage buckets configurados |
| Jue 22 oct | CI/CD pipeline con GitHub Actions (análisis estático, tests, build APK/IPA) | Tech Lead | Pipeline funcional ejecutando en cada PR |
| Vie 23 oct | Sprint Review #1 | Equipo | Retrospectiva, ajustes al plan |

#### Semana 2 — Design System y Arquitectura

| Día | Actividad | Responsable | Entregable |
|-----|-----------|-------------|------------|
| Lun 26 oct | Definición del design system: tipografía (Google Fonts), paleta de colores, componentes base | Diseñador UI/UX | Design system documentado en Figma |
| Mar 27 oct | Prototipos de baja fidelidad: Onboarding, Home, Crear Anuncio, Perfil | Diseñador UI/UX | Wireframes en Figma |
| Mié 28 oct | Implementación del design system en Flutter (theme, widgets reutilizables) | Dev Jr. | Componentes base en código |
| Jue 29 oct | Configuración de Firebase Cloud Functions (HTTP triggers y Firestore triggers) | Tech Lead | Functions desplegadas y documentadas |
| Vie 30 oct | Prototipo navegable validado con Product Owner | Product Owner | Aprobación de wireframes |
| Vie 30 oct | Sprint Review #2 — **Milestone M1: Arquitectura lista** | Equipo | Infraestructura y diseño aprobados |

**Hitos Fase 1:**
- ✅ Repositorio configurado con CI/CD operativo
- ✅ Firebase proyecto con entornos separados
- ✅ Design system documentado y aprobado
- ✅ Wireframes validados por Product Owner

---

### Fase 2: Funcionalidades Núcleo (Semanas 3–4)

#### Semana 3 — Autenticación y Perfil

| Día | Actividad | Responsable | Entregable |
|-----|-----------|-------------|------------|
| Lun 2 nov | Pantalla de onboarding (intro screens) | Dev Jr. | 3 slides de onboarding implementadas |
| Mar 3 nov | Autenticación con Email y contraseña (Firebase Auth) | Dev Jr. | Login/registro funcional |
| Mié 4 nov | Google Sign-In integration | Dev Jr. | Login con Google operativo |
| Jue 5 nov | Apple Sign-In integration | Dev Jr. | Login con Apple operativo |
| Vie 6 nov | Pantalla de perfil de usuario (edición de datos, foto) | Dev Jr. | Perfil editable |

#### Semana 4 — Anuncios

| Día | Actividad | Responsable | Entregable |
|-----|-----------|-------------|------------|
| Lun 9 nov | Modelado de datos Firestore (colecciones: users, ads, categories) | Tech Lead | Esquema Firestore documentado |
| Mar 10 nov | Pantalla de creación de anuncio (título, descripción, precio, categoría) | Dev Jr. | Formulario funcional |
| Mié 11 nov | Subida de imágenes a Firebase Storage (múltiples, compresión) | Dev Jr. | Upload de imágenes con preview |
| Jue 12 nov | Geolocalización: obtener colonia/ubicación del usuario | Dev Jr. | Ubicación capturada y mostrada |
| Vie 13 nov | Mis Anuncios: listado, edición, eliminación | Dev Jr. | Dashboard de anuncios del usuario |
| Vie 13 nov | Sprint Review #4 — **Milestone M2: Funcionalidades núcleo completas** | Equipo | MVP funcional con auth + anuncios |

**Hitos Fase 2:**
- ✅ Autenticación con 3 proveedores funcional
- ✅ Usuario puede crear anuncios con imágenes y GPS
- ✅ Edición y eliminación de anuncios

---

### Fase 3: Funcionalidades Avanzadas (Semanas 5–6)

#### Semana 5 — Pagos y Notificaciones

| Día | Actividad | Responsable | Entregable |
|-----|-----------|-------------|------------|
| Lun 16 nov | Configuración de Stripe / Play Store Billing | Tech Lead | Entorno de pagos sandbox |
| Mar 17 nov | Implementación de Bump Ads (pago único por posicionamiento) | Dev Jr. | Flujo Bump Ads funcional |
| Mié 18 nov | Implementación de suscripción Pro (mensual/anual) | Dev Jr. | Suscripción Pro funcional |
| Jue 19 nov | Configuración de FCM (Firebase Cloud Messaging) | Tech Lead | Notificaciones push operativas |
| Vie 20 nov | Lógica de notificaciones: nuevo anuncio en tu colonia, respuestas | Dev Jr. | Notifications enviadas por triggers |

#### Semana 6 — Búsqueda y Mapas

| Día | Actividad | Responsable | Entregable |
|-----|-----------|-------------|------------|
| Lun 23 nov | Pantalla de búsqueda con filtros (categoría, precio, distancia) | Dev Jr. | Buscador con filtros funcional |
| Mar 24 nov | Integración Google Maps SDK (mostrar anuncios en mapa) | Dev Jr. | Mapa con marcadores de anuncios |
| Mié 25 nov | Vista de detalle de anuncio (imagen grande, info, botón contacto) | Dev Jr. | Detail screen completa |
| Jue 26 nov | Bump Ads: lógica de destacado en listados y mapa | Dev Jr. | Anuncios Bump posicionados primero |
| Vie 27 nov | Sprint Review #6 — **Milestone M3: Funcionalidades avanzadas completas** | Equipo | App completa funcional |

**Hitos Fase 3:**
- ✅ Pagos funcionales (Bump Ads + Pro) en sandbox
- ✅ Notificaciones push operativas
- ✅ Búsqueda con filtros y mapa integrado
- ✅ Lógica de destacado Bump Ads implementada

---

### Fase 4: Pruebas y QA (Semana 7)

#### Semana 7 — Aseguramiento de Calidad

| Día | Actividad | Responsable | Entregable |
|-----|-----------|-------------|------------|
| Lun 30 nov | Plan de pruebas detalcado: casos de prueba, escenarios, datos de prueba | QA Tester | Documento de plan de pruebas |
| Mar 1 dic | Pruebas unitarias de lógica de negocio (Firebase mocks) | Dev Jr. | Cobertura ≥60% |
| Mié 2 dic | Pruebas de widgets/UI (flutter_test) | Dev Jr. | Cobertura ≥80% total |
| Jue 3 dic | Pruebas beta cerrada (TestFlight + Play Internal Testing) con 10 usuarios beta de GDL | QA Tester + Equipo | Reporte de feedback beta |
| Vie 4 dic | Corrección de bugs críticos y de alta prioridad | Dev Jr. + Tech Lead | Bugs P0/P1 resueltos |

**Hitos Fase 4:**
- ✅ Plan de pruebas ejecutado
- ✅ Cobertura de código ≥80%
- ✅ Beta con usuarios reales completada
- ✅ Cero bugs críticos (P0) abiertos

---

### Fase 5: Lanzamiento y Marketing (Semana 8)

#### Semana 8 — Go-Live

| Día | Actividad | Responsable | Entregable |
|-----|-----------|-------------|------------|
| Lun 7 dic | Preparación de assets para tiendas (icono, screenshots, feature graphic) | Diseñador UI/UX | Assets finales exportados |
| Mar 8 dic | Creación de listings en App Store Connect y Google Play Console | Product Owner + Marketing | Listings completos y enviados para revisión |
| Mié 9 dic | Estrategia de lanzamiento: soft launch en Guadalajara (evento, prensa local, redes) | Marketing Lead | Campaña de lanzamiento activa |
| Jue 10 dic | Revisión de app en tiendas (resolver comentarios de revisión de Apple) | Tech Lead | Apps aprobadas |
| Vie 11 dic | **LANZAMIENTO OFICIAL** — App disponible al público | Equipo completo | 🚀 Clasificados Pro en producción |
| Vie 11 dic | Monitoreo post-lanzamiento: Firebase Crashlytics, Analytics, revenue | Tech Lead + Marketing | Dashboard de métricas en tiempo real |

**Hitos Fase 5:**
- ✅ Apps aprobadas y publicadas en App Store y Google Play
- ✅ Campaña de lanzamiento ejecutada
- ✅ Monitoreo activo de métricas

---

### 3.1 Diagrama de Dependencias

```
[Setup Flutter + Firebase] ──────► [CI/CD] ──────► [Design System]
       │                                                │
       ▼                                                ▼
[Modelado Firestore] ◄─────────────────────── [Prototipos Figma]
       │
       ▼
[Autenticación] ──────► [Perfil Usuario]
       │
       ▼
[Crear Anuncios] ──────► [Subida Imágenes] ──────► [Geolocalización]
       │
       ▼
[Mis Anuncios] ──────► [Búsqueda + Filtros] ──────► [Google Maps]
       │                      │
       ▼                      ▼
[Pagos: Bump Ads]        [Notificaciones Push]
       │                      │
       ▼                      ▼
[Suscripción Pro] ──────────► [Vista Detalle]
                                  │
                                  ▼
                           [Pruebas Beta]
                                  │
                                  ▼
                           [Corrección Bugs]
                                  │
                                  ▼
                           [Lanzamiento 🚀]
```

### 3.2 Matriz de Dependencias Críticas

| Entregable | Depende de | Impacto si se retrasa |
|------------|-----------|----------------------|
| Autenticación | Firebase Auth configurado | Bloquea todo el flujo de usuario |
| Crear Anuncios | Modelado Firestore + Storage | Bloquea MVP |
| Pagos | Stripe/Play Store configurado + Auth | Bloquea monetización |
| Búsqueda | Anuncios creados + geolocalización | Reduce retención |
| Notificaciones | FCM + backend de anuncios | Baja engagement |
| Lanzamiento | QA completa + tiendas configuradas | Crítico para go-live |

---

## 4. Asignación de Recursos

### 4.1 Equipo Propuesto

| Rol | Persona | Dedicación Semanal | Semanas Activas | Resp. Principal |
|-----|---------|-------------------|-----------------|----------------|
| Product Owner | 1 persona | 20 h | 1–8 | Priorización, aceptación, stakeholders |
| Tech Lead / Dev Sr. | 1 persona | 40 h | 1–8 | Arquitectura, Firebase, code review, CI/CD |
| Desarrollador Flutter Jr. | 1 persona | 40 h | 2–7 | Implementación de features, pruebas unitarias |
| Diseñador UI/UX | 1 persona | 20 h | 1–2, 8 | Design system, wireframes, assets tiendas |
| QA Tester | 1 persona | 20 h | 6–7 | Plan de pruebas, ejecución, reporte |
| Marketing Lead | 1 persona | 15 h | 7–8 | Estrategia de lanzamiento, contenido, ASO |

### 4.2 Horas Estimadas por Fase

| Fase | Semanas | Horas estimadas | Costo estimado (MXN) |
|------|---------|-----------------|----------------------|
| Setup y Arquitectura | 1–2 | 100 h | $130,000 |
| Funcionalidades Núcleo | 3–4 | 120 h | $132,000 |
| Funcionalidades Avanzadas | 5–6 | 120 h | $132,000 |
| Pruebas y QA | 7 | 60 h | $54,000 |
| Lanzamiento y Marketing | 8 | 50 h | $62,500 |
| **Gestión de proyecto** | 1–8 | 80 h | $100,000 |
| **TOTAL** | **8 semanas** | **~530 h** | **~$610,500 MXN** |

### 4.3 Herramientas y Suscripciones

| Herramienta | Proposto | Costo mensual (MXN) |
|-------------|----------|---------------------|
| GitHub ( equipo 5 usuarios) | Equipo | $2,500 |
| Figma (2 diseñadores) | Profesional | $3,000 |
| Firebase (Blaze plan) | Producción | Variable (ver presupuesto) |
| Google Maps SDK | Geolocalización | Variable (~$2,000/mes estimado) |
| Stripe | Pagos | 2.9% + $3 por transacción |
| Jira o Notion | Gestión de proyecto | $1,500 |
| Slack | Comunicación | $0 (plan gratuito) |
| Codemagic o Fastlane match | CI/CD builds iOS | $5,000 |

---

## 5. Evaluación de Riesgos y Mitigación

### 5.1 Matriz de Riesgos

| ID | Riesgo | Probabilidad | Impacto | Severidad | Mitigencia |
|----|--------|-------------|---------|-----------|------------|
| R01 | Retraso en revisión de App Store (Apple) | Media | Alto | 🔴 Alta | Enviar a revisión 3 días antes del lanzamiento; tener build de respaldo |
| R02 | Bugs críticos encontrados en fase beta | Media | Alto | 🔴 Alta | QA desde semana 5; buffer de 2 días en semana 7 para correcciones |
| R03 | Costos Firebase superan estimación | Baja | Medio | 🟡 Media | Monitoreo diario con alertas de presupuesto en Firebase Console |
| R04 | Desarrollador Jr. bloqueado sin soporte | Media | Alto | 🔴 Alta | Tech Lead disponible para pairing sessions diarias |
| R05 | Cambios en políticas de Google Play Store | Baja | Alto | 🟡 Media | Mantener cumplimiento de políticas desde el día 0 |
| R06 | Retraso en integración de pagos (Stripe) | Baja | Alto | 🟡 Media | Iniciar configuración Stripe en semana 4 (paralelo) |
| R07 | Fuga de información de usuarios | Muy baja | Crítico | 🔴 Alta | Reglas de seguridad Firestore estrictas; revisión obligatoria antes de merge |
| R08 | Alcance expansivo (scope creep) crítico | Media | Medio | 🟡 Media | Product Owner protege backlog; cambios requieren aprobación formal |
| R09 | Bajo rendimiento en dispositivos Android gama baja | Media | Medio | 🟡 Media | Optimizar imágenes, usar listas lazy, performance profiling desde semana 3 |
| R10 | Contingencia sanitaria / evento externo | Muy bajo | Alto | 🟢 Baja | Trabajo remoto ya contemplado; comunicación asíncrona vía Slack/Jira |

### 5.2 Plan de Contingencia

- **Si se retrasa la autenticación:** Repriorizar features; lanzar MVP sin Apple Sign-In en v1.0.
- **Si el desarrollador Jr. se bloquea por >2 horas:** Tech Lead interviene inmediatamente.
- **Si Firebase supera presupuesto:** Revisar reglas de seguridad, eliminar lecturas innecesarias, implementar caché.
- **Si la revisión de Apple rechaza la app:** Tener respuesta preparada; corregir y resubir en <24 horas.

---

## 6. Estimación de Presupuesto (MXN)

### 6.1 Recursos Humanos

| Concepto | Horas | Tarifa (MXN/h) | Subtotal |
|----------|-------|----------------|----------|
| Product Owner | 80 h | $1,200 | $96,000 |
| Tech Lead / Dev Sr. | 160 h | $1,500 | $240,000 |
| Desarrollador Flutter Jr. | 160 h | $850 | $136,000 |
| Diseñador UI/UX | 60 h | $800 | $48,000 |
| QA Tester | 40 h | $700 | $28,000 |
| Marketing Lead | 30 h | $850 | $25,500 |
| **Subtotal Nómina** | **530 h** | | **$573,500** |

### 6.2 Infraestructura y Herramientas (8 semanas)

| Concepto | Costo total 8 sem. (MXN) |
|----------|--------------------------|
| GitHub Team | $5,000 |
| Figma Profesional | $6,000 |
| Firebase Blaze (estimado) | $15,000 |
| Google Maps SDK | $4,000 |
| CI/CD (Codemagic/Fastlane) | $10,000 |
| Jira / Notion | $3,000 |
| Dominio + hosting landing page | $2,000 |
| **Subtotal Infraestructura** | **$45,000** |

### 6.3 Marketing y Lanzamiento

| Concepto | Costo (MXN) |
|----------|-------------|
| Campaña Meta Ads (2 semanas) | $15,000 |
| Campaña Google Ads (búsqueda) | $10,000 |
| Influencers locales GDL | $8,000 |
| Material gráfico / video promo | $5,000 |
| **Subtotal Marketing** | **$38,000** |

### 6.4 Contingencia

| Concepto | Porcentaje | Monto (MXN) |
|----------|-----------|--------------|
| Reserva de contingencia | 10% | $65,650 |

### 6.5 Resumen Presupuestal

| Rubro | Monto (MXN) |
|-------|-------------|
| Recursos humanos | $573,500 |
| Infraestructura y herramientas | $45,000 |
| Marketing y lanzamiento | $38,000 |
| Contingencia (10%) | $65,650 |
| **PRESUPUESTO TOTAL ESTIMADO** | **$722,150 MXN** |

> **Nota:** Las tarifas son estimaciones de mercado para profesionales freelance/contratados en México. Firebase y Google Maps tienen costos variables basados en uso real; se recomienda configurar alertas de presupuesto.

---

## 7. Plan de Aseguramiento de Calidad

### 7.1 Estrategia de Pruebas

| Tipo de Prueba | Herramienta | Cobertura Objetivo | Responsable |
|----------------|-------------|--------------------|-------------|
| Pruebas unitarias | `flutter_test` | ≥80% | Dev Jr. |
| Pruebas de widgets | `flutter_test` + `WidgetTester` | Componentes clave | Dev Jr. |
| Pruebas de integración | `integration_test` | Flujos principales | QA Tester |
| Pruebas manuales | Dispositivos reales (iOS + Android) | UI/UX completa | QA Tester |
| Pruebas beta | TestFlight + Play Internal | 10 usuarios reales | Equipo |
| Análisis estático | `flutter analyze` + GitHub Actions | Cero warnings | CI/CD |
| Rendimiento | Flutter DevTools | <16ms frame time | Tech Lead |
| Seguridad | Revisión manual + Firebase Rules | Sin vulnerabilidades | Tech Lead |

### 7.2 Criterios de Aceptación de Código

- ✅ PR aprobado por Tech Lead (mínimo 1 review)
- ✅ Cero errores en `flutter analyze`
- ✅ Tests unitarios pasando en CI
- ✅ Cobertura no decrece (mínimo 80%)
- ✅ Documentación de funciones complejas

### 7.3 Proceso de Code Review

1. Dev Jr. crea rama `feature/xxx` y abre PR
2. CI ejecuta análisis estático y tests automáticamente
3. Tech Lead revisa código (máximo 24h tiempo de respuesta)
4. Si hay comentarios → Dev Jr. ajusta y notifica
5. Tech Lead aprueba y hace merge a `develop`
6. Al final de sprint, `develop` se mergea a `main`

### 7.4 Plan de Pruebas Beta

| Aspecto | Detalle |
|---------|---------|
| Plataforma | TestFlight (iOS) + Internal Testing (Android) |
| Participantes | 10–15 usuarios beta de Guadalajara |
| Duración | 3 días |
| Método | Feedback vía formulario Google + entrevistas cortas |
| Métricas | Tasa de finalización de tareas, NPS, bugs reportados |

### 7.5 Definition of Done (DoD)

Una funcionalidad se considera **terminada** cuando:
- [ ] Código implementado y mergeado a `develop`
- [ ] Tests unitarios cubren la nueva lógica
- [ ] `flutter analyze` sin errores ni warnings
- [ ] Probada en dispositivo real (al menos Android)
- [ ] Aprobada por Product Owner en sprint review
- [ ] Sin bugs P0/P1 asociados

---

## 8. Plan de Comunicación

### 8.1 Ritmo de Reuniones

| Reunión | Frecuencia | Duración | Participantes | Propósito |
|---------|-----------|----------|---------------|-----------|
| Daily Standup | L–V (diario) | 15 min | Dev Team | Bloqueadores, avances, plan del día |
| Sprint Planning | Inicio de semana (Lun) | 60 min | Todo el equipo | Priorizar sprint, estimar tareas |
| Sprint Review | Fin de semana (Vie) | 45 min | Equipo + PO | Demostrar incremento, recibir feedback |
| Retrospective | Fin de semana (Vie) | 30 min | Equipo técnico | Mejorar proceso, lecciones aprendidas |
| Demo a Stakeholders | Fin de fase | 30 min | Equipo + Stakeholders | Presentar hitos, alinear expectativas |
| 1:1 Dev Jr. ↔ Tech Lead | 2x por semana | 20 min | Tech Lead + Dev Jr. | Mentoría, resolver dudas técónicas |

### 8.2 Canales de Comunicación

| Canal | Uso | Tiempo de Respuesta |
|-------|-----|---------------------|
| Slack — #desarrollo | Comunicación diaria del equipo técnico | <2 horas |
| Slack — #general | Anuncios, coordinación general | <4 horas |
| Jira / Notion | Gestión de tareas y backlog | Semanal (planning) |
| Email | Comunicación formal con stakeholders externos | <24 horas |
| GitHub PRs | Discusiones técnicas de código | <24 horas |
| Figma | Comentarios de diseño | <48 horas |

### 8.3 Reporte de Estado

| Frecuencia | Formato | Audiencia | Contenido |
|------------|---------|-----------|-----------|
| Semanal | Documento breve en Notion | Product Owner + Stakeholders | Avance %, riesgos, blockers, próximos hitos |
| Fin de fase | Presentación (30 min) | Todos los stakeholders | Demo, métricas, retrospectiva, plan siguiente fase |
| Post-lanzamiento | Dashboard en tiempo real | Equipo + Inversionistas | DAU, ingresos, crashes, NPS, reviews tiendas |

---

## 9. Criterios de Éxito

### 9.1 Criterios de Éxito del Proyecto

| Criterio | Métrica | Meta | Cómo se mide |
|----------|---------|------|--------------|
| **Tiempo** | Fecha de lanzamiento | 11 dic 2026 (fin semana 8) | Fecha de publicación en tiendas |
| **Alcance** | Features implementadas | 100% del alcance v1.0 | Backlog en Jira |
| **Calidad** | Bugs críticos (P0) post-launch | 0 | Crashlytics + Jira |
| **Calidad** | Cobertura de código | ≥80% | Reporte `flutter test --coverage` |
| **Calidad** | Crash-free sessions | ≥99.5% | Firebase Crashlytics |
| **Rendimiento** | Tiempo de carga Home | <2 segundos | Firebase Performance |
| **Rendimiento** | Latencia Firestore | <200ms p95 | Firestore metrics |
| **Adopción** | Descargas primer mes | ≥500 | App Store + Play Console |
| **Adopción** | Registros completados | ≥200 | Firebase Analytics |
| **Retención** | D7 retention | ≥25% | Firebase Analytics |
| **Monetización** | Primeras ventas Bump/Pro | ≥20 transacciones | Stripe dashboard |
| **Satisfacción** | Rating tiendas | ≥4.5★ | App Store + Google Play |
| **Satisfacción** | NPS usuarios beta | ≥40 | Encuesta post-beta |

### 9.2 Métricas Post-Lanzamiento (Semana 8+)

| Métrica | Frecuencia de review | Responsable | Acción si no se cumple |
|---------|----------------------|-------------|------------------------|
| DAU / MAU | Diaria | Product Owner | Ajustar estrategia de retención |
| Tasa de conversión a Bump/Pro | Semanal | Marketing + Tech Lead | Ajustar pricing / UX de compra |
| Crash-free users | Diaria | Tech Lead | Hotfix inmediato |
| Reviews tiendas | Semanal | Product Owner | Responder y priorizar fixes |
| CAC (Costo de Adquisición) | Semanal | Marketing Lead | Optimizar campañas |
| LTV (Life Time Value) | Mensual | Product Owner | Mejorar retención y upsell |

### 9.3 Go/No-Go para Lanzamiento

**Se lanza si:**
- ✅ Cero bugs P0 (críticos) abiertos
- ✅ ≤3 bugs P1 (importantes) abiertos con workaround documentado
- ✅ Apps aprobadas en App Store Connect y Play Console
- ✅ Monitoreo (Crashlytics, Analytics) configurado y funcional
- ✅ Landing page y material de marketing publicado
- ✅ Equipo de soporte briefed para atender usuarios iniciales

**Se pospone si:**
- ❌ Existe algún bug P0 sin resolver
- ❌ La app ha sido rechazada por Apple sin plan de resolución
- ❌ La cobertura de pruebas <60%
- ✅ El monitoreo no está configurado

---

## 10. Apéndices

### A. Glosario

| Término | Definición |
|---------|-----------|
| **Bump Ads** | Modelo de pago único para posicionar un anuncio en los resultados de búsqueda |
| **Pro** | Suscripción mensual/anual con beneficios premium |
| **Hiperlocal** | Enfocado en un radio geográfico pequeño (colonia/zona específica) |
| **CI/CD** | Integración Continua / Despliegue Continuo |
| **ASO** | App Store Optimization |
| **DAU/MAU** | Daily/Monthly Active Users |
| **CAC** | Customer Acquisition Cost |
| **LTV** | Lifetime Value |

### B. Referencias

- Flutter Documentation: [flutter.dev/docs](https://flutter.dev/docs)
- Firebase Flutter SDK: [firebase.flutter.dev](https://firebase.flutter.dev)
- Google Flutter Team — BLoC Pattern
- Scrum Guide 2020 (Schwaber & Sutherland)
- Play Store Developer Policy: [support.google.com/googleplay](https://support.google.com/googleplay)
- App Store Review Guidelines: [developer.apple.com/app-store/review/guidelines](https://developer.apple.com/app-store/review/guidelines)

---

**Documento preparado para:** Clasificados Pro  
**Versión:** 1.0  
**Última actualización:** 17 de octubre de 2026

---

## Resumen Ejecutivo

| Aspecto | Valor |
|---------|-------|
| Duración | 8 semanas (19 oct – 11 dic 2026) |
| Equipo | 6 personas (PO, Tech Lead, Dev Jr., Diseñador, QA, Marketing) |
| Presupuesto estimado | **$722,150 MXN** |
| Tecnologías | Flutter, Firebase (Auth, Firestore, Storage, Functions), Google Maps, Stripe |
| Modelo de negocio | Freemium (Bump Ads + Pro) |
| Mercado objetivo | Guadalajara, Jalisco, México |
| Riesgo principal | Retraso en revisión de App Store (probabilidad: media) |
| Mitigación clave | Enviar a revisión 3 días antes del launch; QA desde semana 5 |
