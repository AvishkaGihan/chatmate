// lib/core/theme/app_theme.dart
import 'package:flutter/material.dart';

class AppTheme {
  // Light Theme Colors (from PRD)
  static const Color _lightPrimary = Color(0xFF6200EE);
  static const Color _lightSecondary = Color(0xFF03DAC6);
  static const Color _lightBackground = Color(0xFFFFFFFF);
  static const Color _lightSurface = Color(0xFFF5F5F5);
  static const Color _lightError = Color(0xFFB00020);

  // Dark Theme Colors (from PRD)
  static const Color _darkPrimary = Color(0xFFBB86FC);
  static const Color _darkSecondary = Color(0xFF03DAC6);
  static const Color _darkBackground = Color(0xFF121212);
  static const Color _darkSurface = Color(0xFF1E1E1E);
  static const Color _darkError = Color(0xFFCF6679);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true, // Enable Material Design 3
      colorScheme: const ColorScheme.light(
        primary: _lightPrimary,
        secondary: _lightSecondary,
        surface: _lightSurface,
        error: _lightError,
      ),
      scaffoldBackgroundColor: _lightBackground,
      textTheme: _textTheme,
      inputDecorationTheme: _inputDecorationTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.dark(
        primary: _darkPrimary,
        secondary: _darkSecondary,
        surface: _darkSurface,
        error: _darkError,
      ),
      scaffoldBackgroundColor: _darkBackground,
      textTheme: _textTheme,
      inputDecorationTheme: _inputDecorationTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
    );
  }

  // Consistent text styling across both themes
  static const TextTheme _textTheme = TextTheme(
    headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
    titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
    bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  );

  // Input field styling
  static const InputDecorationTheme _inputDecorationTheme =
      InputDecorationTheme(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      );

  // Button styling
  static final ElevatedButtonThemeData _elevatedButtonTheme =
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          textStyle: _textTheme.labelLarge,
        ),
      );
}
