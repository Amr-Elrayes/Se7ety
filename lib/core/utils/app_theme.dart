import 'package:flutter/material.dart';
import 'package:sa7ety/core/constants/app_fonts.dart';
import 'package:sa7ety/core/utils/colors.dart';
import 'package:sa7ety/core/utils/text_styles.dart';

class AppTheme {
  static get lightTheme => ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
      onSurface: AppColors.darkColor,
    ),
    fontFamily: AppFonts.cairo,
    scaffoldBackgroundColor: AppColors.whiteColor,
    appBarTheme: AppBarTheme(
      surfaceTintColor: Colors.transparent,
      backgroundColor: AppColors.whiteColor,
      centerTitle: true,
    ),
    dividerTheme: DividerThemeData(color: AppColors.borderColor, thickness: 1),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyles.textSize15.copyWith(color: AppColors.grayColor),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(22),
        borderSide: BorderSide(color: AppColors.borderColor, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(22),
        borderSide: BorderSide(color: AppColors.borderColor, width: 1),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(22),
        borderSide: BorderSide(color: AppColors.redColor, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(22),
        borderSide: BorderSide(color: AppColors.redColor, width: 1),
      ),
    ),
  );
}
