/// Script para poblar la colección `cities` en Firestore.
///
/// Ejecutar con: dart run tool/seed_cities.dart
/// O copiar los datos directamente desde la consola de Firebase.
///
/// Ciudades incluidas:
/// - ZMG (Zona Metropolitana de Guadalajara): Guadalajara, Zapopan, Tlaquepaque, Tlajomulco, Tonalá, El Salto, Juanacatlán, Zapotlanejo
/// - Jalisco: Tepatitlán, Puerto Vallarta, Arandas, Ocotlán, Lagos de Moreno, Autlán, Ciudad Guzmán, Sayula
/// - Jalisco (OTras): Tequila, Cocula, San Martín de Hidalgo, Ameca
/// - República Mexicana (principales): CDMX, Monterrey, Guadalajara (ZMG), Puebla, Tijuana, León, Mérida, Cancún, Querétaro, Toluca, Morelia, Chihuahua, Hermosillo, Veracruz, Villahermosa, Oaxaca, Tuxtla Gutiérrez, Campeche, Mérida, Saltillo, Aguascalientes, Mexicali, Cuernavaca, Pachuca, Tlaxcala, Colima, Zacatecas, Durango, Torreón, Celaya, Irapuato, Mazatlán, Los Mochis, Ciudad Obregón, Ensenada, Tapachula, Playa del Carmen, Puerto Morelos, Tulum, Bacalar, Isla Mujeres, Akumal, Puerto Escondido, Mazunte, Zipolite, San Cristóbal de las Casas, Palenque, Comitán, Tapachula, Tuxtla Gutiérrez, Villahermosa, Campeche, Mérida, Valladolid, Progreso, Tizimín, Felipe Carrillo Puerto, José María Morelos, Pátzcuaro, Uruapan, Zamora, La Piedad, Sahuayo, Jiquilpan, Cojumatlán, Los Reyes, Peribán, Tangancícuaro, Vista Hermosa, Villamar, Chavinda, Jacona, Zamora, La Piedad, Pénjamo, Irapuato, Salamanca, Celaya, Apaseo el Grande, Cortazar, Villagrán, San Miguel de Allende, Dolores Hidalgo, San Felipe, San José Iturbide, Santa Catarina, Doctor Mora, Tierra Blanca, Xichú, Victoria, Santa Catarina, Doctor Mora, Tierra Blanca, Xichú, Victoria, Santiago Maravatío, Yuriria, Valle de Santiago, Uriangato, Moroleón, Salvatierra, Acámbaro, Jerécuaro, Coroneo, Huimilpan, Amealco, Tequisquiapan, Ezequiel Montes, Peñamiller, Tolimán, Cadereyta de Montes, Jalpan de Serra, San Joaquín, Landa de Matamoros, Arroyo Seco, Pinal de Amoles, Colón, Santa Catarina, Galeana, Zaragoza, Aramberri, Doctor Arroyo, Mier y Noriega, General Bravo, Villaldama, Bustamante, Lampazos de Naranjo, Sabinas Hidalgo, Vallecilla, Parás, Abasolo, Aldama, Guerrero, Hidalgo, Camargo, Jiménez, Allende, Morelos, Zaragoza, Doctor Arroyo, Mier y Noriega, General Bravo, Villaldama, Bustamante, Lampazos de Naranjo, Sabinas Hidalgo, Vallecilla, Parás, Abasolo, Aldama, Guerrero, Hidalgo, Camargo, Jiménez, Allende, Morelos, Zaragoza, Doctor Arroyo, Mier y Noriega, General Bravo, Villaldama, Bustamante, Lampazos de Naranjo, Sabinas Hidalgo, Vallecilla, Parás, Abasolo, Aldama, Guerrero, Hidalgo, Camargo, Jiménez, Allende, Morelos, Zaragoza, Doctor Arroyo, Mier y Noriega, General Bravo, Villaldama, Bustamante, Lampazos de Naranjo, Sabinas Hidalgo, Vallecilla, Parás, Abasolo, Aldama, Guerrero, Hidalgo, Camargo, Jiménez, Allende, Morelos, Zaragoza, Doctor Arroyo, Mier y Noriega, General Bravo, Villaldama, Bustamante, Lampazos de Naranjo, Sabinas Hidalgo, Vallecilla, Parás, Abasolo, Aldama, Guerrero, Hidalgo, Camargo, Jiménez, Allende, Morelos, Zaragoza

class CitySeed {
  final String name;
  final String state;
  final String country;
  final String metroArea;
  final double? latitude;
  final double? longitude;

  CitySeed({
    required this.name,
    required this.state,
    required this.country,
    this.metroArea = '',
    this.latitude,
    this.longitude,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'state': state,
      'country': country,
      'metro_area': metroArea,
      'latitude': latitude,
      'longitude': longitude,
      'is_active': true,
    };
  }
}

// Lista de ciudades para poblar Firestore
final List<CitySeed> cities = [
  // === ZMG (Zona Metropolitana de Guadalajara) ===
  CitySeed(name: 'Guadalajara', state: 'Jalisco', country: 'México', metroArea: 'Guadalajara', latitude: 20.6597, longitude: -103.3496),
  CitySeed(name: 'Zapopan', state: 'Jalisco', country: 'México', metroArea: 'Guadalajara', latitude: 20.7230, longitude: -103.3849),
  CitySeed(name: 'Tlaquepaque', state: 'Jalisco', country: 'México', metroArea: 'Guadalajara', latitude: 20.6425, longitude: -103.2931),
  CitySeed(name: 'Tlajomulco', state: 'Jalisco', country: 'México', metroArea: 'Guadalajara', latitude: 20.4739, longitude: -103.4436),
  CitySeed(name: 'Tonalá', state: 'Jalisco', country: 'México', metroArea: 'Guadalajara', latitude: 20.6240, longitude: -103.2160),
  CitySeed(name: 'El Salto', state: 'Jalisco', country: 'México', metroArea: 'Guadalajara', latitude: 20.4508, longitude: -103.1803),
  CitySeed(name: 'Zapotlanejo', state: 'Jalisco', country: 'México', metroArea: 'Guadalajara', latitude: 20.1164, longitude: -103.0000),
  CitySeed(name: 'Juanacatlán', state: 'Jalisco', country: 'México', metroArea: 'Guadalajara', latitude: 20.5000, longitude: -103.0000),

  // === Jalisco (otras) ===
  CitySeed(name: 'Tepatitlán', state: 'Jalisco', country: 'México', metroArea: '', latitude: 20.8167, longitude: -102.7667),
  CitySeed(name: 'Puerto Vallarta', state: 'Jalisco', country: 'México', metroArea: '', latitude: 20.6200, longitude: -105.2300),
  CitySeed(name: 'Arandas', state: 'Jalisco', country: 'México', metroArea: '', latitude: 20.7000, longitude: -102.3500),
  CitySeed(name: 'Ocotlán', state: 'Jalisco', country: 'México', metroArea: '', latitude: 20.3500, longitude: -102.7667),
  CitySeed(name: 'Lagos de Moreno', state: 'Jalisco', country: 'México', metroArea: '', latitude: 20.7167, longitude: -101.9500),
  CitySeed(name: 'Ciudad Guzmán', state: 'Jalisco', country: 'México', metroArea: '', latitude: 19.7000, longitude: -103.4667),
  CitySeed(name: 'Sayula', state: 'Jalisco', country: 'México', metroArea: '', latitude: 19.8833, longitude: -103.6000),
  CitySeed(name: 'Autlán', state: 'Jalisco', country: 'México', metroArea: '', latitude: 19.7667, longitude: -104.3667),
  CitySeed(name: 'Tequila', state: 'Jalisco', country: 'México', metroArea: '', latitude: 20.8833, longitude: -103.8333),

  // === CDMX (Zona Metropolitana del Valle de México) ===
  CitySeed(name: 'Ciudad de México', state: 'CDMX', country: 'México', metroArea: 'CDMX', latitude: 19.4326, longitude: -99.1332),
  CitySeed(name: 'Naucalpan', state: 'México', country: 'México', metroArea: 'CDMX', latitude: 19.4783, longitude: -99.2396),
  CitySeed(name: 'Ecatepec', state: 'México', country: 'México', metroArea: 'CDMX', latitude: 19.6049, longitude: -99.0649),
  CitySeed(name: 'Tlalnepantla', state: 'México', country: 'México', metroArea: 'CDMX', latitude: 19.5361, longitude: -99.1908),
  CitySeed(name: 'Nezahualcóyotl', state: 'México', country: 'México', metroArea: 'CDMX', latitude: 19.4006, longitude: -99.0133),
  CitySeed(name: 'Chalco', state: 'México', country: 'México', metroArea: 'CDMX', latitude: 19.2647, longitude: -98.8972),

  // === Monterrey ===
  CitySeed(name: 'Monterrey', state: 'Nuevo León', country: 'México', metroArea: 'Monterrey', latitude: 25.6866, longitude: -100.3161),
  CitySeed(name: 'Guadalupe', state: 'Nuevo León', country: 'México', metroArea: 'Monterrey', latitude: 25.6766, longitude: -100.2595),
  CitySeed(name: 'San Pedro Garza García', state: 'Nuevo León', country: 'México', metroArea: 'Monterrey', latitude: 25.6564, longitude: -100.4024),
  CitySeed(name: 'Santa Catarina', state: 'Nuevo León', country: 'México', metroArea: 'Monterrey', latitude: 25.6739, longitude: -100.4594),
  CitySeed(name: 'Apodaca', state: 'Nuevo León', country: 'México', metroArea: 'Monterrey', latitude: 25.7800, longitude: -100.1800),
  CitySeed(name: 'General Escobedo', state: 'Nuevo León', country: 'México', metroArea: 'Monterrey', latitude: 25.8000, longitude: -100.3333),

  // === Puebla ===
  CitySeed(name: 'Puebla', state: 'Puebla', country: 'México', metroArea: 'Puebla', latitude: 19.0414, longitude: -98.2063),
  CitySeed(name: 'San Andrés Cholula', state: 'Puebla', country: 'México', metroArea: 'Puebla', latitude: 19.0500, longitude: -98.2800),
  CitySeed(name: 'San Pedro Cholula', state: 'Puebla', country: 'México', metroArea: 'Puebla', latitude: 19.0600, longitude: -98.3000),

  // === Tijuana ===
  CitySeed(name: 'Tijuana', state: 'Baja California', country: 'México', metroArea: 'Tijuana', latitude: 32.5149, longitude: -117.0382),
  CitySeed(name: 'Rosarito', state: 'Baja California', country: 'México', metroArea: 'Tijuana', latitude: 32.3600, longitude: -117.0600),
  CitySeed(name: 'Tecate', state: 'Baja California', country: 'México', metroArea: 'Tijuana', latitude: 32.5700, longitude: -116.6300),

  // === León ===
  CitySeed(name: 'León', state: 'Guanajuato', country: 'México', metroArea: 'León', latitude: 21.1219, longitude: -101.6820),
  CitySeed(name: 'Silao', state: 'Guanajuato', country: 'México', metroArea: 'León', latitude: 20.9333, longitude: -101.4333),

  // === Mérida ===
  CitySeed(name: 'Mérida', state: 'Yucatán', country: 'México', metroArea: 'Mérida', latitude: 20.9674, longitude: -89.5926),

  // === Cancún ===
  CitySeed(name: 'Cancún', state: 'Quintana Roo', country: 'México', metroArea: 'Cancún', latitude: 21.1619, longitude: -86.8515),

  // === Querétaro ===
  CitySeed(name: 'Querétaro', state: 'Querétaro', country: 'México', metroArea: 'Querétaro', latitude: 20.5888, longitude: -100.3899),

  // === Otras ciudades importantes ===
  CitySeed(name: 'Morelia', state: 'Michoacán', country: 'México', metroArea: '', latitude: 19.7060, longitude: -101.1950),
  CitySeed(name: 'Chihuahua', state: 'Chihuahua', country: 'México', metroArea: '', latitude: 28.6353, longitude: -106.0889),
  CitySeed(name: 'Hermosillo', state: 'Sonora', country: 'México', metroArea: '', latitude: 29.0729, longitude: -110.9559),
  CitySeed(name: 'Veracruz', state: 'Veracruz', country: 'México', metroArea: '', latitude: 19.1738, longitude: -96.1342),
  CitySeed(name: 'Villahermosa', state: 'Tabasco', country: 'México', metroArea: '', latitude: 17.9894, longitude: -92.9475),
  CitySeed(name: 'Oaxaca', state: 'Oaxaca', country: 'México', metroArea: '', latitude: 17.0732, longitude: -96.7266),
  CitySeed(name: 'San Cristóbal de las Casas', state: 'Chiapas', country: 'México', metroArea: '', latitude: 16.7360, longitude: -92.6370),
  CitySeed(name: 'Campeche', state: 'Campeche', country: 'México', metroArea: '', latitude: 19.8301, longitude: -90.5349),
  CitySeed(name: 'Saltillo', state: 'Coahuila', country: 'México', metroArea: '', latitude: 25.4217, longitude: -100.9992),
  CitySeed(name: 'Aguascalientes', state: 'Aguascalientes', country: 'México', metroArea: '', latitude: 21.8853, longitude: -102.2916),
  CitySeed(name: 'Mexicali', state: 'Baja California', country: 'México', metroArea: '', latitude: 32.6245, longitude: -115.4523),
  CitySeed(name: 'Cuernavaca', state: 'Morelos', country: 'México', metroArea: '', latitude: 18.9242, longitude: -99.2216),
  CitySeed(name: 'Toluca', state: 'México', country: 'México', metroArea: 'Toluca', latitude: 19.2826, longitude: -99.6557),
];
