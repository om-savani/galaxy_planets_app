import 'package:flutter/material.dart';

import '../../../helper/data_helper.dart';
import '../../../model/data_model.dart';

class HomeProvider extends ChangeNotifier {
  List<Planet> planetList = [];
  int selectedPlanetIndex = 0;
  final DataHelper helper = DataHelper();

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
}
