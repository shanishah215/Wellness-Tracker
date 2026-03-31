import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Manages the application's light and dark theme configurations.
/// Tailored for Neomorphic and Glassmorphic UI designs.
class AppTheme {
  static const Color lightScaffoldColor = Color(0xFFE0E5EC);
  static const Color lightPrimaryColor = Color(0xFF2E5EAA);

  static const Color darkScaffoldColor = Color(0xFF25292F);
  static const Color darkPrimaryColor = Color(0xFF5CCAD4);

  /// Returns the light theme configuration.
  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: lightPrimaryColor,
      scaffoldBackgroundColor: lightScaffoldColor,
      textTheme: GoogleFonts.outfitTextTheme().apply(
        bodyColor: Colors.black87,
        displayColor: Colors.black87,
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: lightPrimaryColor,
        brightness: Brightness.light,
        surface: lightScaffoldColor,
      ),
    );
  }

  /// Returns the dark theme configuration.
  static ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: darkPrimaryColor,
      scaffoldBackgroundColor: darkScaffoldColor,
      textTheme: GoogleFonts.outfitTextTheme().apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: darkPrimaryColor,
        brightness: Brightness.dark,
        surface: darkScaffoldColor,
      ),
    );
  }
}
