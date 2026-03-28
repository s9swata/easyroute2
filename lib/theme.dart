import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Brand Colors
  static const Color primary = Color(0xFF0F6DF0);
  static const Color backgroundLight = Color(0xFFF5F7F8);
  static const Color backgroundDark = Color(0xFF101822);
  static const Color blue400 = Color(0xFF60A5FA);
  
  // Slate Colors (Tailwind defaults)
  static const Color slate100 = Color(0xFFF1F5F9);
  static const Color slate200 = Color(0xFFE2E8F0);
  static const Color slate300 = Color(0xFFCBD5E1);
  static const Color slate400 = Color(0xFF94A3B8);
  static const Color red400 = Color(0xFFF87171);
  static const Color green100 = Color(0xFFDCFCE7);
  static const Color green700 = Color(0xFF15803D);
  static const Color yellow100 = Color(0xFFFEF08A);
  static const Color yellow700 = Color(0xFFA16207);
  static const Color slate500 = Color(0xFF64748B);
  static const Color slate700 = Color(0xFF334155);
  static const Color slate800 = Color(0xFF1E293B);
  static const Color slate900 = Color(0xFF0F172A);

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: backgroundLight,
    primaryColor: primary,
    colorScheme: const ColorScheme.light(
      primary: primary,
      surface: backgroundLight,
      onSurface: slate900,
    ),
    textTheme: GoogleFonts.interTextTheme(
      ThemeData.light().textTheme,
    ),
  );
}
