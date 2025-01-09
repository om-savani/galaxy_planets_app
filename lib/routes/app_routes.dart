import 'package:flutter/material.dart';
import 'package:galaxy_planets_app/screen/favaourite/view/favourite_screen.dart';

import '../screen/detail/view/detail_screen.dart';
import '../screen/home/view/home_screen.dart';
import '../screen/splash/view/splash_screen.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String home = '/home';
  static const String detail = '/detail';
  static const String favourite = '/favourite';

  static Map<String, WidgetBuilder> routes = {
    home: (context) => const HomeScreen(),
    splash: (context) => const SplashScreen(),
    detail: (context) => const DetailScreen(),
    favourite: (context) => const FavouriteScreen(),
  };
}
