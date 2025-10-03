import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData.light().copyWith(primaryColor: Colors.blue);
  }

  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(primaryColor: Colors.blue);
  }
}
