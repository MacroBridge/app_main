import 'package:flutter/material.dart';

class AppMaterialTheme {
  static ThemeData getThemeDataFromColorScheme({
    ColorScheme? colorScheme,
    required Brightness brightness,
  }) {
    return ThemeData(
      colorScheme:
      colorScheme ??
          ((brightness == Brightness.light)
              ? lightFallbackTheme
              : darkFallbackTheme),
    );
  }

  static final ColorScheme lightFallbackTheme = ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: const Color(0xFF1D275C),
  );

  static final ColorScheme darkFallbackTheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color(0xFF1D275C),
  );
}