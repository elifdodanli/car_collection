import 'package:shared_preferences/shared_preferences.dart';

class CacheManager {
  // Constant keys to prevent typos
  static const String _isFirstTimeKey = 'isFirstTime';
  static const String _isLoggedInKey = 'isLoggedIn';

  // Check if it's the user's first time opening the app
  static Future<bool> isFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isFirstTimeKey) ?? true;
  }

  // Check if the user has successfully registered
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  // Set the login status to true after successful registration
  static Future<void> setLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, true);
    await prefs.setBool(
      _isFirstTimeKey,
      false,
    ); // If logged in, they've passed onboarding
  }
}
