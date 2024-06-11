import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gear_care/welcome.dart'; // Importing welcome.dart

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Navigate to the welcome screen after 4 seconds delay
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const WelcomeScreen(),
      ));
    });

    return const Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 100,
            child: Image(
              image: AssetImage("assets/images/gif2.gif"),
              height: 520,
              width: 320,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 60,
            child: Image(
              image: AssetImage("assets/images/TechElecon.png"),
              height: 100,
              width: 240,
              fit: BoxFit.scaleDown,
            ),
          ),
        ],
      ),
    );
  }
}
