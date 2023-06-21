import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences prefs;
  static Future<SharedPreferences> inti() async {
  return prefs = await SharedPreferences.getInstance();
  }

  Future<bool> saveTheme(String theme) async {
   return await prefs.setString('theme', theme);
  }

  String? readTheme()  {
    return  prefs.getString('theme') ?? "ThemeMode.light";
  }

}