import 'package:shared_preferences/shared_preferences.dart';

class PrefManager {
  static getMemory() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool('memory') ?? false;
  }

  static setMemory(bool value) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('memory', value);
  }
}
