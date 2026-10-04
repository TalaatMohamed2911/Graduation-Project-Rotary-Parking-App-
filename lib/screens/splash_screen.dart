import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:rotary_parking/screens/map_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  get splash => null;
  // @override
  // void initState() {
  //   super.initState();
  //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
  //       overlays: SystemUiOverlay.values);
  // }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splashTransition: SplashTransition.slideTransition,
      animationDuration: const Duration(milliseconds: 600),
      duration: 4350,
      splash: Column(
        children: [
          Center(
            child: LottieBuilder.asset(
              "assets/Lottie/Animation - 1721219640283.json",
              width: double.infinity,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            "Welocme to Parking App",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
      nextScreen: const MapScreen(),
      splashIconSize: 500,
      backgroundColor: const Color(0xFF002448),
    );
  }
}
