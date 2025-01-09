import 'package:shared_preferences/shared_preferences.dart';

class ShrHelper {
  Future<void> setThemeMode(bool isDark) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isDark", isDark);
  }

  Future<bool> getThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isDark") ?? false;
  }
}
