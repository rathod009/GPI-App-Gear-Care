import 'package:flutter/material.dart';
import 'package:gear_care/login.dart'; // Import the header

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xffffffff),
      body: Column(
        children: [
          GearCareHeader(), // Reuse the header
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 90, horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Image(
                        image: AssetImage("assets/images/welcome3.png"),
                        height: 230,
                        width: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 40, 0, 8),
                      child: Text(
                        "Welcome to GearCare!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 19,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                    Text(
                      "Gear Registration, Condition Monitoring, ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        color: Color(0xff746f6f),
                      ),
                    ),
                    Text(
                      "Service Notifier, Field Service Survey.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        color: Color(0xff746f6f),
                      ),
                    ),
                    // SizedBox(height: 0),
                  ],
                ),
              ),
            ),
          ),
          BottomLoginButton(),
        ],
      ),
    );
  }
}

class BottomLoginButton extends StatelessWidget {
  const BottomLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 54),
      child: MaterialButton(
        onPressed: () {
          // Navigate to the Login screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        },
        color: const Color(0xff3a57e8),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: const BorderSide(color: Color(0xffffffff), width: 1),
        ),
        padding: const EdgeInsets.all(16),
        height: 45,
        child: const Text(
          "Sign In",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xffffffff),
          ),
        ),
      ),
    );
  }
}

//Calling gearcare header seprately here to avoid the logout button which is present in the header
class GearCareHeader extends StatelessWidget {
  const GearCareHeader({super.key}); // Corrected super.key to key

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(30, 50, 30, 16),
      child: const Row( // Removed const from Row
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Gear",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 30,
              color: Color(0xfff94e02),
            ),
          ),
          Text(
            "Care",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 30,
              color: Color(0xff3a57e8),
            ),
          ),
        ],
      ),
    );
  }
}