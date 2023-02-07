import 'package:flutter/services.dart';

import '../../general_exports.dart';

ThemeData themeLight = ThemeData(
  primarySwatch: generateMaterialColor(color: AppColors.primary),
  primaryColor: AppColors.primary,
  primaryColorLight: AppColors.primary,
  fontFamily: 'Laila',
  //textTheme: const TextTheme(),
  primaryColorDark: AppColors.primary,
  appBarTheme: const AppBarTheme(
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontFamily: 'Laila',
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    systemOverlayStyle: SystemUiOverlayStyle.light,
  ),
);
