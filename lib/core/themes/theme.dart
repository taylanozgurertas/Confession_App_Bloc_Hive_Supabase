import 'package:flutter/material.dart';
import 'package:itiraf/core/themes/app_pallete.dart';

class AppTheme {
  static _border([Color color = AppPallete.borderColor]) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: color,
          width: 3,
        ),
      );
  static final darkThemeMode = ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      border: _border(), 
      errorBorder: _border(AppPallete.errorColor),
      contentPadding: const EdgeInsets.all(16),
      enabledBorder: _border(),
      focusedBorder: _border(AppPallete.gradient2),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPallete.backgroundColor, 
    ), 
    chipTheme: const ChipThemeData(
      color: MaterialStatePropertyAll(AppPallete.backgroundColor,), 
      side: BorderSide.none, 
    )
  );
}
