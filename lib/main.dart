import 'package:flutter/material.dart';
import 'package:gear_care/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gear_care/splash.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

// void main() {
//   runApp(MyApp()); // Removed const keyword from here
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key, Key? Key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GearCare - GPI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(), // Removed const keyword from here
    );
  }
}

// class MyHomePage extends StatelessWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//       ),
//       body: const Center(
//         child: Text('Welcome to the GPI App!'),
//       ),
//     );
//   }
// }
