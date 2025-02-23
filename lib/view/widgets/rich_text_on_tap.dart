import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/utils/app_color.dart';

class RichTextOnTap extends StatelessWidget {
  const RichTextOnTap({
    super.key,
    required this.text01,
    required this.text02,
    required this.onTap,
  });

  final String? text01;
  final String? text02;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text01,
        style: TextStyle(
          color: AppColor.textColorPrimary.withOpacity(0.8),
          fontWeight: FontWeight.w600,
          letterSpacing: 0.4,
          fontSize: 15,
        ),
        children: [
          TextSpan(
            text: text02,
            style: const TextStyle(
              color: AppColor.themeColor,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}
