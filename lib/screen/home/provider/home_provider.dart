import 'package:flutter/material.dart';
import 'package:galaxy_planets_app/helper/shr_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helper/data_helper.dart';
import '../../../model/data_model.dart';

class HomeProvider extends ChangeNotifier {
  List<Planet> planetList = [];
  int selectedPlanetIndex = 0;
  List<String> favouritePlanets = [];
  final DataHelper helper = DataHelper();
  bool isDark = false;
  ShrHelper shrHelper = ShrHelper();

  HomeProvider() {
    getPlanetList();
    loadFavourites();
    getThemeMode();
  }

  void setSelectedPlanetIndex(int index) {
    if (index >= 0 && index < planetList.length) {
      selectedPlanetIndex = index;
      notifyListeners();
    }
  }

  Future<void> getPlanetList() async {
    planetList = await helper.planetJsonParsing();
    notifyListeners();
  }

  Future<void> loadFavourites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    favouritePlanets = prefs.getStringList('favourites') ?? [];
    notifyListeners();
  }

  Future<void> toggleFavourite(String planetName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (favouritePlanets.contains(planetName)) {
      favouritePlanets.remove(planetName);
    } else {
      favouritePlanets.add(planetName);
    }
    await prefs.setStringList('favourites', favouritePlanets);
    notifyListeners();
  }

  bool isFavourite(String planetName) {
    return favouritePlanets.contains(planetName);
  }

  changeThemeMode() async {
    isDark = !isDark;
    shrHelper.setThemeMode(isDark);
    print("isDark: $isDark");
    notifyListeners();
  }

  void getThemeMode() async {
    isDark = await shrHelper.getThemeMode();
    notifyListeners();
  }
}
