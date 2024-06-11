import 'package:flutter/material.dart';
import 'dashboard1.dart';
import 'dashboard2.dart';
import 'firestore_service.dart';
import 'package:intl/intl.dart';  // Added this for date formatting


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Column(
        children: [
          const GearCareHeader(), // Fixed header
          Expanded( // Added Expanded to make the SingleChildScrollView scrollable
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  // Moved the rest of the content here
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        const Text(
                          "Login to Continue",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            fontSize: 24,
                            color: Color(0xff000000),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Align(
                          alignment: Alignment.center,
                          child: Image(
                            image: AssetImage("assets/images/login3.png"),
                            height: 90,
                            width: 90,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 32),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextField(
                            controller: emailController,
                            obscureText: false,
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                              fontSize: 18,
                              color: Color(0xff000000),
                            ),
                            decoration: InputDecoration(
                              labelText: "Email Address",
                              labelStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 18,
                                color: Color(0xff7c7878),
                              ),
                              hintText: "Enter Email Address",
                              hintStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 18,
                                color: Color(0xff7c7878),
                              ),
                              filled: true,
                              fillColor: const Color.fromARGB(255, 255, 255, 255),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              contentPadding: const EdgeInsets.all(16),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        PasswordTextField(passwordController: passwordController), // Updated to pass the passwordController
                        const SizedBox(height: 16),
                        // -------------- Forget Password ---------------
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              "Forgot Password?",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xff3a57e8),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 80), // Added space for the button
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          BottomLoginButton(emailController: emailController, passwordController: passwordController,), // Updated to pass the emailController & passwordcontroller
        ],
      ),
    );
  }
}

class PasswordTextField extends StatefulWidget {
  final TextEditingController passwordController; // Added this line

  const PasswordTextField({super.key, required this.passwordController}); // Updated constructor

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    widget.passwordController.addListener(_onPasswordChange);
  }

  @override
  void dispose() {
    widget.passwordController.dispose();
    super.dispose();
  }

  void _onPasswordChange() {
    setState(() {
      // Listen for password changes
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: widget.passwordController,
        obscureText: _obscureText,
        textAlign: TextAlign.start,
        maxLines: 1,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          fontSize: 18,
          color: Color(0xff000000),
        ),
        decoration: InputDecoration(
          labelText: "Password",
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontSize: 18,
            color: Color(0xff7c7878),
          ),
          hintText: "Enter Password",
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontSize: 18,
            color: Color(0xff7c7878),
          ),
          filled: true,
          fillColor: const Color.fromARGB(255, 255, 255, 255),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          contentPadding: const EdgeInsets.all(16),
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
              color: const Color(0xff000000),
              size: 24,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
        ),
      ),
    );
  }
}

class BottomLoginButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController; // Add this line

  const BottomLoginButton({super.key, required this.emailController, required this.passwordController});

  void _login(BuildContext context) async {
    final email = emailController.text;
    final password = passwordController.text; // Add this line

    if (email.isNotEmpty && password.isNotEmpty) { // Check if both email and password are entered
      String loginTimestamp = DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());

      FirestoreService().addUserLoginInfo(email, loginTimestamp);

      if (email.endsWith('@techelecon.com')) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Dashboard()), // Admin dashboard
        );
      } else if (email.endsWith('@elecon.com')) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Dashboard2()), // Field officer dashboard
        );
      } else {
        _showCenteredSnackbar(context, 'Please Enter a Valid Email Address!');
      }
    } else {
      _showCenteredSnackbar(context, 'Email and Password cannot be empty!'); // Show error if fields are empty
    }
  }

  void _showCenteredSnackbar(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    Future.delayed(const Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 48),
      child: MaterialButton(
        onPressed: () => _login(context),
        color: const Color(0xff3a57e8),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: const BorderSide(color: Color(0xffffffff), width: 1),
        ),
        padding: const EdgeInsets.all(16),
        height: 45,
        child: const Text(
          "Login",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Color(0xffffffff),
          ),
        ),
      ),
    );
  }
}

// class BottomLoginButton extends StatelessWidget {
//   final TextEditingController emailController;

//   const BottomLoginButton({super.key, required this.emailController}); // Updated constructor

//   void _login(BuildContext context) {
//     final email = emailController.text;
//     if (email.endsWith('@techelecon.com')) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => const Dashboard()), // Admin dashboard
//       );
//     } else if (email.endsWith('@elecon.com')) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => const Dashboard2()), // Field officer dashboard
//       );
//     } else {
//       // Handle invalid email domain with centered Snackbar-like widget
//       _showCenteredSnackbar(context, 'Please Enter a Valid Email Address!');
//     }
//   }

//   void _showCenteredSnackbar(BuildContext context, String message) {
//     final overlay = Overlay.of(context);
//     final overlayEntry = OverlayEntry(
//       builder: (context) => Center(
//         child: Material(
//           color: Colors.transparent,
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 14),
//             decoration: BoxDecoration(
//               color: Colors.red,
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Text(
//               message,
//               style: const TextStyle(color: Colors.white, fontSize: 14),
//             ),
//           ),
//         ),
//       ),
//     );

//     overlay.insert(overlayEntry);
//     Future.delayed(const Duration(seconds: 2), () {
//       overlayEntry.remove();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       color: Colors.white,
//       padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 48),
//       child: MaterialButton(
//         onPressed: () => _login(context),
//         color: const Color(0xff3a57e8),
//         elevation: 0,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10.0),
//           side: const BorderSide(color: Color(0xffffffff), width: 1),
//         ),
//         padding: const EdgeInsets.all(16),
//         height: 45,
//         child: const Text(
//           "Login",
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.w500,
//             color: Color(0xffffffff),
//           ),
//         ),
//       ),
//     );
//   }
// }

// Calling gearcare header separately here to avoid the logout button which is present in the header
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
