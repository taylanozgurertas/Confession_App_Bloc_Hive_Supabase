import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itiraf/core/themes/app_pallete.dart';

class AuthGradientButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  const AuthGradientButton({super.key, required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      color: Colors.black,
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppPallete.whiteColor,
        ),
      ),
    );
  }
}
