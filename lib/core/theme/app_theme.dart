import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'app_colors.dart';

/// Material 3 theme for NabhKrishi.
/// Designed around a restrained, premium nature-inspired visual system.
class AppTheme {
  AppTheme._();

  static ThemeData get light {
    const scheme = ColorScheme(
      brightness: Brightness.light,

      // Primary
      primary: AppColors.earthGreenDark,
      onPrimary: Colors.white,
      primaryContainer: Color(0xFFDCE6D8),
      onPrimaryContainer: Color(0xFF213D27),

      // Secondary
      secondary: AppColors.earthGreenLight,
      onSecondary: Colors.white,
      secondaryContainer: Color(0xFFE1E8DC),
      onSecondaryContainer: Color(0xFF34432F),

      // Tertiary / earth
      tertiary: AppColors.earthBrown,
      onTertiary: Colors.white,
      tertiaryContainer: Color(0xFFE9DDCF),
      onTertiaryContainer: Color(0xFF493728),

      // Surfaces
      surface: AppColors.surface,
      onSurface: AppColors.charcoal,
      surfaceContainerHighest: Color(0xFFECE9E0),

      // Outlines
      outline: Color(0xFFAAA99F),
      outlineVariant: AppColors.divider,

      // Errors
      error: AppColors.error,
      onError: Colors.white,
      errorContainer: Color(0xFFF0DDD8),
      onErrorContainer: Color(0xFF5C201A),

      // Compatibility
      inverseSurface: AppColors.charcoal,
      onInverseSurface: Colors.white,
      inversePrimary: Color(0xFFB5D0B5),
      scrim: Colors.black,
      shadow: Colors.black,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,

      scaffoldBackgroundColor: AppColors.ivory,

      fontFamily: 'Roboto',

      appBarTheme: const AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.charcoal,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.earthGreenDark,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(52),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: FadeForwardsPageTransitionsBuilder(),
        },
      ),
    );
  }
}
