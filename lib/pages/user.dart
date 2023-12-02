import 'package:shared_preferences/shared_preferences.dart';

class User{
  static Future<bool?> getsignin() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool("Sign-in");
  }
  static Future setsignin(bool signin) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool("Sign-in", signin);
  }
    // เพิ่มฟังก์ชันเพื่อเก็บและดึงข้อมูล email
  static Future<String?> getUserEmail() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("user-email");
  }

  static Future setUserEmail(String userEmail) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("user-email", userEmail);
  }

}