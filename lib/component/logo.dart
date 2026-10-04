import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        alignment: Alignment.center,
        width: 85,
        height: 85,
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(45)),
        child: Image.asset(
          "images/login.png",
        ),
      ),
    );
  }
}
