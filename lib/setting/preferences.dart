import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static SharedPreferences _preferences = _preferences;

  // key for the user id
  static const _keyUserId = "";

  // chec if time in or out
  static const _keyTimeInOut = ".";

  // create an instance
  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // set userId
  static Future saveUserId(String userId) async =>
      await _preferences.setString(_keyUserId, userId);

  // get the userId
  static String? getUserId() => _preferences.getString(_keyUserId);

  // set time in/out
  static Future setInOut(bool status) async =>
      await _preferences.setBool(_keyTimeInOut, status);

  // get the time in/out
  static bool? getInOut() => _preferences.getBool(_keyTimeInOut);
}
