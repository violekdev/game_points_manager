import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

// Color(0xFFEF5350),
// Color(0xFFFFCDD2),
// Color(0xFFFFEBEE),

class AppTheme {
  static Color lightBackgroundColor = const Color(0xFFFFFFFF);
  static Color lightSideMenuBackgroundColor = const Color(0xFFF44336);
  static Color lightPrimaryColor = const Color(0xFFEF5350);
  static Color lightAccentColor = const Color(0xFFFFCDD2);
  static Color lightButtonColor = const Color(0xFFEF5350);
  static Color lightDisabledColor = const Color(0xFFFFCDD2);
  static Color lightCardColor = const Color(0xFFFFEBEE);
  static Color lightParticlesColor = const Color(0x44948282);

  static Color darkBackgroundColor = Colors.blueGrey.shade900;
  static Color darkSideMenuBackgroundColor = const Color(0xFF1F2127);
  static Color darkPrimaryColor = const Color(0xFF1A2127);
  static Color darkAccentColor = Colors.blueGrey.shade600;
  static Color darkButtonColor = Colors.blueGrey.shade600;
  static Color darkDisabledColor = const Color(0xFF1A2127);
  static Color darkCardColor = const Color(0xFF1F2127);
  static Color darkParticlesColor = const Color(0x441C2A3D);

  const AppTheme._();

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: lightPrimaryColor,
    accentColor: lightAccentColor,
    backgroundColor: lightBackgroundColor,
    cardColor: lightCardColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    buttonColor: lightButtonColor,
    disabledColor: lightDisabledColor,
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: darkPrimaryColor,
    accentColor: darkAccentColor,
    cardColor: darkCardColor,
    backgroundColor: darkBackgroundColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    buttonColor: darkButtonColor,
    disabledColor: darkDisabledColor,
  );

  static Brightness get currentSystemBrightness =>
      SchedulerBinding.instance.window.platformBrightness;

  static setStatusBarAndNavigationBarColors(ThemeMode themeMode) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:
          themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
      systemNavigationBarIconBrightness:
          themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: themeMode == ThemeMode.light
          ? lightBackgroundColor
          : darkBackgroundColor,
      systemNavigationBarDividerColor: Colors.transparent,
    ));
  }
}

extension ThemeExtras on ThemeData {
  Color get particlesColor => this.brightness == Brightness.light
      ? AppTheme.lightParticlesColor
      : AppTheme.darkParticlesColor;
}
