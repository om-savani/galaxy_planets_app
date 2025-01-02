class SolarSystem {
  final List<Planet> planets;

  SolarSystem({required this.planets});
  factory SolarSystem.fromJson(Map<String, dynamic> json) {
    return SolarSystem(
      planets: (json['solarSystem']['planets'] as List)
          .map((planet) => Planet.fromJson(planet))
          .toList(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'solarSystem': {
        'planets': planets.map((planet) => planet.toJson()).toList(),
      }
    };
  }
}

class Planet {
  final String name;
  final int orderFromSun;
  final num diameter;
  final String mass;
  final int numberOfSatellites;
  final bool hasRings;
  final String description;
  final String averageOrbitalSpeed;
  final String image;
  final String surfaceArea;
  final String rotationPeriod;
  final String atmosphere;
  final int temperature;
  final num distanceFromEarth;
  final String type;

  Planet({
    required this.name,
    required this.orderFromSun,
    required this.diameter,
    required this.mass,
    required this.numberOfSatellites,
    required this.hasRings,
    required this.description,
    required this.averageOrbitalSpeed,
    required this.image,
    required this.surfaceArea,
    required this.rotationPeriod,
    required this.atmosphere,
    required this.temperature,
    required this.distanceFromEarth,
    required this.type,
  });

  factory Planet.fromJson(Map<String, dynamic> json) {
    return Planet(
      name: json['name'] ?? 'Unknown',
      orderFromSun: json['orderFromSun'] ?? 0,
      diameter: (json['diameter'] ?? 0.0),
      mass: json['mass'] ?? 'Unknown',
      numberOfSatellites: json['numberOfSatellites'] ?? 0,
      hasRings: json['hasRings'] ?? false,
      description: json['description'] ?? 'No description available',
      averageOrbitalSpeed: json['averageOrbitalSpeed'] ?? 'Unknown',
      image: json['image'] ?? '',
      surfaceArea: json['surfaceArea'] ?? 'Unknown',
      rotationPeriod: json['rotationPeriod'] ?? 'Unknown',
      atmosphere: json['atmosphere'] ?? 'Unknown',
      temperature: json['temperature'] ?? 0,
      distanceFromEarth: json['distanceFromEarth'] ?? 0.0,
      type: json['type'] ?? 'Unknown',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'orderFromSun': orderFromSun,
      'diameter': diameter,
      'mass': mass,
      'numberOfSatellites': numberOfSatellites,
      'hasRings': hasRings,
      'description': description,
      'averageOrbitalSpeed': averageOrbitalSpeed,
      'image': image,
      'surfaceArea': surfaceArea,
      'rotationPeriod': rotationPeriod,
    };
  }
}
