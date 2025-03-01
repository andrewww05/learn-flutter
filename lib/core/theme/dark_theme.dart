import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  appBarTheme: AppBarTheme(
    backgroundColor: Color.fromARGB(255, 31, 31, 31),
    surfaceTintColor: Color.fromARGB(255, 31, 31, 31),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w700,
    ),
  ),
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.yellow),
  scaffoldBackgroundColor: const Color.fromARGB(255, 31, 31, 31),
  dividerTheme: DividerThemeData(color: Colors.white24),
  listTileTheme: ListTileThemeData(iconColor: Colors.white),
  textTheme: const TextTheme(
    bodySmall: TextStyle(
      // withValues(alpha: ...) = withOpacity
      color: Color.fromARGB(153, 255, 255, 255),
      fontWeight: FontWeight.w700,
      fontSize: 14,
    ),
    bodyMedium: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontSize: 20,
    ),
  ),
);
