import 'package:flutter/material.dart';

import '../utils/app_color.dart';

ElevatedButtonThemeData getElevatedButtonThemeData() => ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.themeColor,
        foregroundColor: AppColor.white,
        padding: const EdgeInsets.symmetric(vertical: 13),
        fixedSize: const Size.fromWidth(double.maxFinite),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
