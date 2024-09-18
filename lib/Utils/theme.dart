import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData appTheme = ThemeData(
  colorScheme:
      ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 220, 46, 46)),
  useMaterial3: true,
  textTheme: GoogleFonts.varelaRoundTextTheme(
    const TextTheme(
      bodyLarge: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 20,
          color: Color(0xFF141914)), // Example for body text
      bodyMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color(0xFF141914)), // Example for secondary body text
      titleLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color(0xFF005799)), // Example for headlines
      titleSmall: TextStyle(fontSize: 20),
      bodySmall:
          TextStyle(fontSize: 12, color: Color.fromARGB(255, 100, 99, 99)),
    ),
  ),
);
