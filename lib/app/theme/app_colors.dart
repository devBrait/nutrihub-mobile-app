import 'package:flutter/material.dart';

abstract final class AppColors {
  // Jungle (Brand Green)
  static const Color jungle50 = Color(0xFFEAF3EE);
  static const Color jungle100 = Color(0xFFCFE4D8);
  static const Color jungle200 = Color(0xFF9FC7B0);
  static const Color jungle300 = Color(0xFF6BA588);
  static const Color jungle400 = Color(0xFF3E8862);
  static const Color jungle500 = Color(0xFF2E6B4C);
  static const Color jungle600 = Color(0xFF245C41);
  static const Color jungle700 = Color(0xFF1A4731);
  static const Color jungle800 = Color(0xFF123424);
  static const Color jungle900 = Color(0xFF0D2619);

  // Cream Soda
  static const Color cream100 = Color(0xFFFFF4CC);
  static const Color cream200 = Color(0xFFF7E8AD);
  static const Color cream300 = Color(0xFFEBD88C);

  // Neutral (warm, green undertone)
  static const Color neutral0 = Color(0xFFFFFEFA);
  static const Color neutral50 = Color(0xFFF5F4EE);
  static const Color neutral100 = Color(0xFFECEBE1);
  static const Color neutral150 = Color(0xFFE5E3D6);
  static const Color neutral200 = Color(0xFFD6D4C4);
  static const Color neutral300 = Color(0xFFB3B1A0);
  static const Color neutral400 = Color(0xFF8A9288);
  static const Color neutral500 = Color(0xFF6F7B71);
  static const Color neutral600 = Color(0xFF4B584F);
  static const Color neutral700 = Color(0xFF364139);
  static const Color neutral800 = Color(0xFF24322A);
  static const Color neutral850 = Color(0xFF1F2E25);
  static const Color neutral900 = Color(0xFF16221B);
  static const Color neutral950 = Color(0xFF0E1712);

  // Semantic
  static const Color success = Color(0xFF3E9464);
  static const Color warning = Color(0xFFD9A93F);
  static const Color danger = Color(0xFFC7635C);
  static const Color info = Color(0xFF4A81A6);

  // Semantic surfaces (light)
  static const Color successBg = Color(0xFFEAF6EF);
  static const Color warningBg = Color(0xFFFDF3DC);
  static const Color dangerBg = Color(0xFFFAECEB);
  static const Color infoBg = Color(0xFFE8F1F7);

  // Text (light theme)
  static const Color textPrimary = Color(0xFF16251D);
  static const Color textSecondary = neutral600;
  static const Color textTertiary = neutral500;
  static const Color textDisabled = Color(0xFFB5B7A9);

  // Icon (light theme)
  static const Color iconPrimary = Color(0xFF1D2E24);
  static const Color iconSecondary = neutral500;

  static ColorScheme lightColorScheme() => ColorScheme.light(
        primary: jungle700,
        onPrimary: cream100,
        primaryContainer: jungle100,
        onPrimaryContainer: jungle800,
        secondary: jungle500,
        onSecondary: neutral0,
        secondaryContainer: jungle50,
        onSecondaryContainer: jungle700,
        tertiary: cream100,
        onTertiary: jungle700,
        error: danger,
        onError: neutral0,
        surface: neutral0,
        onSurface: textPrimary,
        surfaceContainerLowest: neutral0,
        surfaceContainerLow: neutral50,
        surfaceContainer: neutral100,
        surfaceContainerHigh: neutral150,
        surfaceContainerHighest: neutral200,
        onSurfaceVariant: textSecondary,
        outline: neutral200,
        outlineVariant: neutral150,
        shadow: Color(0xFF0B0D08),
        scrim: Color(0x801F2E25),
        inverseSurface: neutral900,
        onInverseSurface: neutral50,
        inversePrimary: jungle400,
      );
}
