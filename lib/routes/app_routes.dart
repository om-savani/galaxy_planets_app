import 'package:flutter/material.dart';

import '../screen/detail/view/detail_screen.dart';
import '../screen/home/view/home_screen.dart';
import '../screen/splash/view/splash_screen.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String home = '/home';
  static const String detail = '/detail';

  static Map<String, WidgetBuilder> routes = {
    home: (context) => const HomeScreen(),
    splash: (context) => const SplashScreen(),
    detail: (context) => const DetailScreen(),
  };
}
