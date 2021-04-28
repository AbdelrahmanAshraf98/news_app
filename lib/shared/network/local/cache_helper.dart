import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper
{
  static SharedPreferences sharedPreferences;

  static init()async{
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool>setCountry({
    @required String key,
    @required int value,
  })async{
    return await sharedPreferences.setInt(key, value);
  }

  static int getCountry({
    @required String key,
  }){
    return sharedPreferences.getInt(key);
  }

  static Future<bool>setTheme({
    @required String key,
    @required bool value,
  })async{
    return await sharedPreferences.setBool(key,value);
  }

  static bool getTheme({
    @required String key,
  }){
    return sharedPreferences.getBool(key);
  }

}