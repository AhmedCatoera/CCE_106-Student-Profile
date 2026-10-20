import 'package:flutter/material.dart';

/// Shared light and dark themes for the whole app.
///
/// Colors are defined once here instead of being repeated inside widgets,
/// which makes restyling the app much easier.
class AppTheme {
  const AppTheme._();

  /// Accent color used to generate both themes.
  static const seedColor = Color(0xFF3949AB);

  static ThemeData light() {
    return _base(
      colorScheme: ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: Brightness.light,
      ),
      scaffoldBackground: const Color(0xFFF5F6FA),
      cardColor: Colors.white,
      cardBorder: const Color(0xFFE7E9F0),
    );
  }

  static ThemeData dark() {
    return _base(
      colorScheme: ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: Brightness.dark,
      ),
      scaffoldBackground: const Color(0xFF14151A),
      cardColor: const Color(0xFF1E2029),
      cardBorder: const Color(0xFF2E3140),
    );
  }

  static ThemeData _base({
    required ColorScheme colorScheme,
    required Color scaffoldBackground,
    required Color cardColor,
    required Color cardBorder,
  }) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: scaffoldBackground,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: scaffoldBackground,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
      ),
      // Compatibility note: this Flutter version (3.10) uses CardTheme.
      // Newer SDKs renamed it to CardThemeData.
      cardTheme: CardTheme(
        color: cardColor,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: cardBorder),
        ),
      ),
    );
  }
}
