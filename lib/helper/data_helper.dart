import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:galaxy_planets_app/model/data_model.dart';

class DataHelper {
  Future<List<Planet>> planetJsonParsing() async {
    try {
      String jsonString = await rootBundle.loadString("assets/planets.json");
      var jsonMap = jsonDecode(jsonString);
      List<dynamic> jsonList = jsonMap['solarSystem']['planets'] ?? [];
      List<Planet> planetList = jsonList
          .map((e) => Planet(
                name: e['name'] ?? 'Unknown',
                orderFromSun: e['orderFromSun'] ?? 0,
                diameter: e['diameter'] ?? 0.0,
                mass: e['mass'] ?? 'Unknown',
                numberOfSatellites: e['numberOfSatellites'] ?? 0,
                hasRings: e['hasRings'] ?? false,
                description: e['description'] ?? 'No description available',
                averageOrbitalSpeed: e['averageOrbitalSpeed'] ?? 'Unknown',
                image: e['image'] ?? 'default_image.png',
                surfaceArea: e['surfaceArea'] ?? 'Unknown',
                rotationPeriod: e['rotationPeriod'] ?? 'Unknown',
                atmosphere: e['atmosphere'] ?? 'Unknown',
                distanceFromEarth: e['distanceFromEarth'] ?? 'Unknown',
                type: e['type'] ?? 'Unknown',
                temperature: e['temperature'] ?? 'Unknown',
              ))
          .toList();

      return planetList;
    } catch (e) {
      print("Error parsing JSON: $e");
      return [];
    }
  }
}
