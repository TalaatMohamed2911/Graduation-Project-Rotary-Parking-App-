import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:rotary_parking/screens/map_screen.dart';

class SplashScreen1 extends StatefulWidget {
  const SplashScreen1({super.key});

  @override
  State<SplashScreen1> createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1> {
  get splash => null;

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      animationDuration: const Duration(milliseconds: 500),
      duration: 4350,
      splash: Column(
        children: [
          Center(
            child: LottieBuilder.asset(
                "assets/Lottie/Animation - 1721219640283.json"),
          ),
          const Text("data"),
        ],
      ),
      nextScreen: const MapScreen(),
      splashIconSize: 400,
      backgroundColor: const Color(0xFF002448),
    );
  }
}
