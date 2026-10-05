import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  const Button({super.key, required this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.blue,
      textColor: Colors.white,
      height: 48,
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      onPressed: onPressed,
      child: Text(
        title,
        style: const TextStyle(fontSize: 23),
      ),
    );
  }
}
