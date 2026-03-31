import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Neomorphic color palette (Light)
  static const Color lightScaffoldColor = Color(0xFFE0E5EC);
  static const Color lightPrimaryColor = Color(0xFF2E5EAA);

  // Neomorphic color palette (Dark)
  static const Color darkScaffoldColor = Color(0xFF25292F);
  static const Color darkPrimaryColor = Color(0xFF5CCAD4);

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
