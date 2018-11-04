import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  // 保存
  static save(String key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  // 查询
  static get(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.get(key);
  }

  // 删除
  static remove(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}