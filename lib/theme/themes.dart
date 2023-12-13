import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:passwordmanager/theme/colors.dart';

ThemeData lightTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: LightThemeColors.backgroundColor,
    cardColor: LightThemeColors.white,
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: LightThemeColors.white,
      constraints: const BoxConstraints(
        maxHeight: 350,
        maxWidth: double.infinity,
      ),
    ),
    iconTheme: IconThemeData(color: LightThemeColors.captionAndIconFontColor),
    fontFamily: 'Rubik',
    appBarTheme: AppBarTheme(
      backgroundColor: LightThemeColors.backgroundColor,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: LightThemeColors.backgroundColor,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: LightThemeColors.backgroundColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: LightThemeColors.sideMenuBackgroundColor,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: LightThemeColors.primaryButtonColor,
    ),
    dialogBackgroundColor: LightThemeColors.backgroundColor,
    primaryTextTheme: TextTheme(
      bodyMedium: TextStyle(
        color: LightThemeColors.headlineFontColor,
      ),
      headlineMedium: TextStyle(
        color: LightThemeColors.headlineFontColor.withAlpha(180),
        fontWeight: FontWeight.w700,
        fontSize: 32,
      ),
      titleLarge: TextStyle(
        color: LightThemeColors.headlineFontColor.withAlpha(170),
        fontWeight: FontWeight.w600,
        fontSize: 22,
      ),
      bodySmall: TextStyle(
        color: LightThemeColors.captionAndIconFontColor,
        fontSize: 16,
        letterSpacing: 1.5,
      ),
    ),
  );
}

ThemeData darkTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: DarkThemeColors.backgroundColor,
    cardColor: DarkThemeColors.cardColor.withOpacity(0.3),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: DarkThemeColors.backgroundColor,
      constraints: const BoxConstraints(
        maxHeight: 350,
        maxWidth: double.infinity,
      ),
    ),
    timePickerTheme: TimePickerThemeData(backgroundColor: DarkThemeColors.backgroundColor),
    dialogBackgroundColor: DarkThemeColors.backgroundColor,
    iconTheme: IconThemeData(color: LightThemeColors.captionAndIconFontColor),
    fontFamily: 'Rubik',
    appBarTheme: AppBarTheme(
      backgroundColor: DarkThemeColors.backgroundColor,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: DarkThemeColors.backgroundColor,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: DarkThemeColors.backgroundColor,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: DarkThemeColors.cardColor,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: DarkThemeColors.primaryButtonColor,
    ),
    primaryTextTheme: TextTheme(
      bodyMedium: TextStyle(
        color: DarkThemeColors.headlineFontColor,
      ),
      headlineMedium: TextStyle(
        color: DarkThemeColors.headlineFontColor.withAlpha(180),
        fontWeight: FontWeight.w700,
        fontSize: 32,
      ),
      titleLarge: TextStyle(
        color: DarkThemeColors.headlineFontColor.withAlpha(170),
        fontWeight: FontWeight.w600,
        fontSize: 22,
      ),
      bodySmall: TextStyle(
        color: DarkThemeColors.captionAndIconFontColor,
        fontSize: 16,
        letterSpacing: 1.5,
      ),
    ),
  );
}
