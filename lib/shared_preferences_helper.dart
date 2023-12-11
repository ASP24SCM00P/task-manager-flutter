import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static SharedPreferences? _sharedPreferences;

  static Future<void> initialize() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static SharedPreferences? get sharedPreferences => _sharedPreferences;

  // Add more methods here based on your needs

  // Example method to save a String value
  static Future<void> saveString(String key, String value) async {
    await _sharedPreferences?.setString(key, value);
  }

  // Example method to get a String value
  static String? getString(String key) {
    return _sharedPreferences?.getString(key);
  }
}
