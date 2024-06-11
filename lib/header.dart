import 'package:flutter/material.dart';
import 'login.dart'; // You need to import the LoginScreen

class GearCareHeader extends StatelessWidget {
  const GearCareHeader({super.key}); // Corrected super.key to key

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(30, 50, 30, 16),
      child: Row( // Removed const from Row
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            "Gear",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 30,
              color: Color(0xfff94e02),
            ),
          ),
          const Text(
            "Care",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 30,
              color: Color(0xff3a57e8),
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
            ),
            icon: const Icon(Icons.logout),
            color: Colors.black,
            iconSize: 26,
          ),
          // IconButton(
          //   onPressed: () => Scaffold.of(context).openDrawer(),
          //   icon: const Icon(Icons.menu),
          //   color: Colors.black,
          //   iconSize: 28,
          // ),
        ],
      ),
    );
  }
}