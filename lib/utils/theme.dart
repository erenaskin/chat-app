import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Uygulamanın renk şeması
class AppColors {
  static const Color primaryLight = Color(0xFF6200EE); // Deep Purple
  static const Color primaryDark = Color(0xFFBB86FC); // Light Purple for dark mode
  static const Color secondaryLight = Color(0xFF03DAC6); // Teal
  static const Color secondaryDark = Color(0xFF03DAC6); // Teal
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF121212);
  static const Color backgroundLight = Color(0xFFF0F2F5);
  static const Color backgroundDark = Color(0xFF1F1F1F);
  static const Color errorLight = Color(0xFFB00020);
  static const Color errorDark = Color(0xFFCF6679);

  static const Color onPrimaryLight = Color(0xFFFFFFFF);
  static const Color onPrimaryDark = Color(0xFF000000);
  static const Color onSecondaryLight = Color(0xFF000000);
  static const Color onSecondaryDark = Color(0xFF000000);
  static const Color onSurfaceLight = Color(0xFF000000);
  static const Color onSurfaceDark = Color(0xFFFFFFFF);
  static const Color onBackgroundLight = Color(0xFF000000);
  static const Color onBackgroundDark = Color(0xFFFFFFFF);
  static const Color onErrorLight = Color(0xFFFFFFFF);
  static const Color onErrorDark = Color(0xFF000000);

  static const Color grey = Color(0xFF8E8E93);
  static const Color lightGrey = Color(0xFFE0E0E0);
  static const Color darkGrey = Color(0xFF333333);
  static const Color chatBubbleLight = Color(0xFFE0E0E0); // Gönderilen mesaj balonu
  static const Color chatBubbleDark = Color(0xFF3A3A3C); // Gönderilen mesaj balonu (dark)
  static const Color receiverChatBubbleLight = Color(0xFF6200EE); // Alınan mesaj balonu
  static const Color receiverChatBubbleDark = Color(0xFFBB86FC); // Alınan mesaj balonu (dark)
}

// Uygulamanın tema verileri
class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryLight,
    hintColor: AppColors.secondaryLight,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    colorScheme: ColorScheme.light(
      primary: AppColors.primaryLight,
      secondary: AppColors.secondaryLight,
      surface: AppColors.surfaceLight,
      error: AppColors.errorLight,
      onPrimary: AppColors.onPrimaryLight,
      onSecondary: AppColors.onSecondaryLight,
      onSurface: AppColors.onSurfaceLight,
      onBackground: AppColors.onBackgroundLight,
      onError: AppColors.onErrorLight,
      surfaceVariant: AppColors.chatBubbleLight, // Mesaj balonu için
    ),
    textTheme: GoogleFonts.urbanistTextTheme(ThemeData.light().textTheme).copyWith(
      displayLarge: GoogleFonts.urbanist(fontSize: 57, fontWeight: FontWeight.w700, letterSpacing: -0.25),
      displayMedium: GoogleFonts.urbanist(fontSize: 45, fontWeight: FontWeight.w700),
      displaySmall: GoogleFonts.urbanist(fontSize: 36, fontWeight: FontWeight.w600),
      headlineLarge: GoogleFonts.urbanist(fontSize: 32, fontWeight: FontWeight.w600),
      headlineMedium: GoogleFonts.urbanist(fontSize: 28, fontWeight: FontWeight.w600),
      headlineSmall: GoogleFonts.urbanist(fontSize: 24, fontWeight: FontWeight.w500),
      titleLarge: GoogleFonts.urbanist(fontSize: 22, fontWeight: FontWeight.w500, letterSpacing: 0.15),
      titleMedium: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 0.15),
      titleSmall: GoogleFonts.urbanist(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
      bodyLarge: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
      bodyMedium: GoogleFonts.urbanist(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
      bodySmall: GoogleFonts.urbanist(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
      labelLarge: GoogleFonts.urbanist(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
      labelMedium: GoogleFonts.urbanist(fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 0.5),
      labelSmall: GoogleFonts.urbanist(fontSize: 11, fontWeight: FontWeight.w500, letterSpacing: 1.5),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.backgroundLight,
      foregroundColor: AppColors.onBackgroundLight,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.urbanist(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.onBackgroundLight),
      iconTheme: const IconThemeData(color: AppColors.onBackgroundLight),
    ),
    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ), // CardThemeData olarak değiştirildi
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryLight,
        foregroundColor: AppColors.onPrimaryLight,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 3,
        textStyle: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryLight,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        side: const BorderSide(color: AppColors.primaryLight, width: 1),
        textStyle: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.lightGrey.withOpacity(0.2),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primaryLight, width: 2),
      ),
      labelStyle: GoogleFonts.urbanist(color: AppColors.grey, fontSize: 16),
      hintStyle: GoogleFonts.urbanist(color: AppColors.grey, fontSize: 16),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: AppColors.primaryLight,
      unselectedItemColor: AppColors.grey,
      backgroundColor: AppColors.surfaceLight,
      elevation: 8,
      selectedIconTheme: IconThemeData(size: 28),
      unselectedIconTheme: IconThemeData(size: 24),
      showUnselectedLabels: true,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryDark,
    hintColor: AppColors.secondaryDark,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    colorScheme: ColorScheme.dark(
      primary: AppColors.primaryDark,
      secondary: AppColors.secondaryDark,
      surface: AppColors.surfaceDark,
      error: AppColors.errorDark,
      onPrimary: AppColors.onPrimaryDark,
      onSecondary: AppColors.onSecondaryDark,
      onSurface: AppColors.onSurfaceDark,
      onBackground: AppColors.onBackgroundDark,
      onError: AppColors.onErrorDark,
      surfaceVariant: AppColors.chatBubbleDark, // Mesaj balonu için
    ),
    textTheme: GoogleFonts.urbanistTextTheme(ThemeData.dark().textTheme).copyWith(
      displayLarge: GoogleFonts.urbanist(fontSize: 57, fontWeight: FontWeight.w700, letterSpacing: -0.25, color: AppColors.onBackgroundDark),
      displayMedium: GoogleFonts.urbanist(fontSize: 45, fontWeight: FontWeight.w700, color: AppColors.onBackgroundDark),
      displaySmall: GoogleFonts.urbanist(fontSize: 36, fontWeight: FontWeight.w600, color: AppColors.onBackgroundDark),
      headlineLarge: GoogleFonts.urbanist(fontSize: 32, fontWeight: FontWeight.w600, color: AppColors.onBackgroundDark),
      headlineMedium: GoogleFonts.urbanist(fontSize: 28, fontWeight: FontWeight.w600, color: AppColors.onBackgroundDark),
      headlineSmall: GoogleFonts.urbanist(fontSize: 24, fontWeight: FontWeight.w500, color: AppColors.onBackgroundDark),
      titleLarge: GoogleFonts.urbanist(fontSize: 22, fontWeight: FontWeight.w500, letterSpacing: 0.15, color: AppColors.onBackgroundDark),
      titleMedium: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 0.15, color: AppColors.onBackgroundDark),
      titleSmall: GoogleFonts.urbanist(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1, color: AppColors.onBackgroundDark),
      bodyLarge: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5, color: AppColors.onBackgroundDark),
      bodyMedium: GoogleFonts.urbanist(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25, color: AppColors.onBackgroundDark),
      bodySmall: GoogleFonts.urbanist(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4, color: AppColors.onBackgroundDark),
      labelLarge: GoogleFonts.urbanist(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25, color: AppColors.onBackgroundDark),
      labelMedium: GoogleFonts.urbanist(fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 0.5, color: AppColors.onBackgroundDark),
      labelSmall: GoogleFonts.urbanist(fontSize: 11, fontWeight: FontWeight.w500, letterSpacing: 1.5, color: AppColors.onBackgroundDark),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.backgroundDark,
      foregroundColor: AppColors.onBackgroundDark,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.urbanist(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.onBackgroundDark),
      iconTheme: const IconThemeData(color: AppColors.onBackgroundDark),
    ),
    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ), // CardThemeData olarak değiştirildi
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryDark,
        foregroundColor: AppColors.onPrimaryDark,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 3,
        textStyle: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryDark,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        side: const BorderSide(color: AppColors.primaryDark, width: 1),
        textStyle: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkGrey,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primaryDark, width: 2),
      ),
      labelStyle: GoogleFonts.urbanist(color: AppColors.lightGrey, fontSize: 16),
      hintStyle: GoogleFonts.urbanist(color: AppColors.lightGrey, fontSize: 16),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: AppColors.primaryDark,
      unselectedItemColor: AppColors.lightGrey,
      backgroundColor: AppColors.surfaceDark,
      elevation: 8,
      selectedIconTheme: IconThemeData(size: 28),
      unselectedIconTheme: IconThemeData(size: 24),
      showUnselectedLabels: true,
    ),
  );
}
