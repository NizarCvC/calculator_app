import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDatabaseServices {
  Future<void> setString(String key, String value);
  Future<String?> getString(String key);
  Future<void> setStringList(String key, List<String> values);
  Future<List<String>?> getStringList(String key);
}

class LocalDatabaseServicesImpl implements LocalDatabaseServices {
  @override
  Future<void> setString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  @override
  Future<String?> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  @override
  Future<void> setStringList(String key, List<String> values) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key, values);
  }

  @override
  Future<List<String>?> getStringList(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key);
  }
}
