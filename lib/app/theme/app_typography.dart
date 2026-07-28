import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppTypography {
  static TextTheme textTheme() {
    return TextTheme(
      displayLarge: GoogleFonts.sora(
        fontSize: 40,
        height: 46 / 40,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.02 * 40,
      ),
      displayMedium: GoogleFonts.sora(
        fontSize: 34,
        height: 40 / 34,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.02 * 34,
      ),
      displaySmall: GoogleFonts.sora(
        fontSize: 28,
        height: 34 / 28,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.015 * 28,
      ),
      headlineLarge: GoogleFonts.sora(
        fontSize: 28,
        height: 34 / 28,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.015 * 28,
      ),
      headlineMedium: GoogleFonts.sora(
        fontSize: 28,
        height: 34 / 28,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.015 * 28,
      ),
      headlineSmall: GoogleFonts.sora(
        fontSize: 22,
        height: 28 / 22,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.01 * 22,
      ),
      titleLarge: GoogleFonts.sora(
        fontSize: 22,
        height: 28 / 22,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.01 * 22,
      ),
      titleMedium: GoogleFonts.sora(
        fontSize: 18,
        height: 24 / 18,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.005 * 18,
      ),
      titleSmall: GoogleFonts.sora(
        fontSize: 16,
        height: 22 / 16,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: GoogleFonts.plusJakartaSans(
        fontSize: 16,
        height: 24 / 16,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: GoogleFonts.plusJakartaSans(
        fontSize: 14,
        height: 20 / 14,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: GoogleFonts.plusJakartaSans(
        fontSize: 12,
        height: 16 / 12,
        fontWeight: FontWeight.w500,
      ),
      labelLarge: GoogleFonts.plusJakartaSans(
        fontSize: 15,
        height: 20 / 15,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.01 * 15,
      ),
      labelMedium: GoogleFonts.plusJakartaSans(
        fontSize: 13,
        height: 18 / 13,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.01 * 13,
      ),
      labelSmall: GoogleFonts.plusJakartaSans(
        fontSize: 12,
        height: 16 / 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.01 * 12,
      ),
    );
  }
}
