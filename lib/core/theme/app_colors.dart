import 'package:flutter/material.dart';

/// Centralized color tokens for NabhKrishi.
/// Nature-inspired palette: warm ivory, field green, sage and earth.
class AppColors {
  AppColors._();

  // ─────────────────────────────────────────────
  // BRAND PALETTE
  // ─────────────────────────────────────────────

  /// Deep field green — primary brand colour.
  static const Color earthGreenDark = Color(0xFF355C3A);

  /// Soft sage — secondary natural accent.
  static const Color earthGreenLight = Color(0xFF78906B);

  /// Kept for compatibility with existing code.
  /// Formerly sky blue; now a muted olive/natural tone.
  static const Color skyBlueDark = Color(0xFF667A50);

  /// Kept for compatibility with existing code.
  /// Formerly bright sky blue; now warm wheat.
  static const Color skyBlueLight = Color(0xFFCDBB91);

  /// Warm wheat accent.
  static const Color amberAccent = Color(0xFFCDBB91);

  // ─────────────────────────────────────────────
  // SURFACES & TEXT
  // ─────────────────────────────────────────────

  /// Main app background — warm, natural ivory.
  static const Color ivory = Color(0xFFF7F5EE);

  /// Slightly brighter surface for cards and elevated areas.
  static const Color surface = Color(0xFFFCFBF7);

  /// Main text.
  static const Color charcoal = Color(0xFF292A25);

  /// Secondary text.
  static const Color mutedText = Color(0xFF74766D);

  /// Soft divider / border.
  static const Color divider = Color(0xFFE4E0D5);

  // ─────────────────────────────────────────────
  // EARTH ACCENTS
  // ─────────────────────────────────────────────

  /// Soil / bark brown.
  static const Color earthBrown = Color(0xFF795C43);

  /// Muted olive.
  static const Color olive = Color(0xFF667A50);

  /// Soft sand.
  static const Color sand = Color(0xFFE6DDC9);

  // ─────────────────────────────────────────────
  // STATUS
  // ─────────────────────────────────────────────

  static const Color success = Color(0xFF547A4F);
  static const Color warning = Color(0xFFB18445);
  static const Color error = Color(0xFFB85C52);

  // ─────────────────────────────────────────────
  // SPLASH
  // ─────────────────────────────────────────────

  /// Warm field-inspired gradient.
  /// Deliberately subtle — no neon/glow aesthetic.
  static const LinearGradient splashGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFF7F5EE),
      Color(0xFFECE9DD),
      Color(0xFFC9D1BD),
      Color(0xFF355C3A),
    ],
    stops: [0.0, 0.38, 0.72, 1.0],
  );
}
