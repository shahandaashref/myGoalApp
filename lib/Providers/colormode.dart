import 'package:flutter/material.dart';
import 'package:goal_app/Core/theme.dart';

class Colormode extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;
  ThemeMode get themeMode => _themeMode;
  bool get isdark => themeMode == ThemeMode.light;

  thememode(bool isOn) {
    // isOn? themeMode:;
    notifyListeners();
  }
}
