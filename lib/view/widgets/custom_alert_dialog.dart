import 'package:flutter/material.dart';
import 'package:task_manager/utils/app_color.dart';

Future<dynamic> customAlertDialog(
  BuildContext context,
  String title,
  VoidCallback noButton,
  VoidCallback yesButton,
) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: AppColor.white,
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: AppColor.textColorPrimary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              noButton();
            },
            child: const Text(
              'No',
              style: TextStyle(color: AppColor.themeColor),
            ),
          ),
          TextButton(
            onPressed: () {
              yesButton();
            },
            child: const Text(
              'Yes',
              style: TextStyle(color: AppColor.themeColor),
            ),
          ),
        ],
      );
    },
  );
}
