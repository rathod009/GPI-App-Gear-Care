import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gear_care/bottnavbar.dart';
import 'package:gear_care/dashboard1.dart';
import 'package:gear_care/header.dart';
import 'package:gear_care/notifications.dart';
import 'package:gear_care/profile.dart';

class Vibration extends StatefulWidget {
  const Vibration({super.key});

  @override
  VibrationState createState() => VibrationState();
}

class VibrationState extends State<Vibration> {
  int _selectedIndex = 1;
  List<double> vibrationData = [0.00]; // Initialize an empty list for vibration data
  Timer? timer;

  @override
  void initState() {
    super.initState();
    // Start fetching and updating vibration data periodically
    timer = Timer.periodic(const Duration(seconds: 2), (Timer t) {
      fetchVibrationData();
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void fetchVibrationData() {
    // Simulate fetching vibration data here
    // Replace this with your actual data-fetching mechanism
    double newVibration = _generateRandomVibration();
    setState(() {
      vibrationData.add(newVibration);
      if (vibrationData.length > 9) {
        vibrationData.removeAt(0);
      }
    });
  }

  double _generateRandomVibration() {
    // Simulate generating random vibration data
    return (1 + (DateTime.now().second % 3)) * (1 + DateTime.now().millisecond % 100) / 100;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 0) {
        // Navigate to Dashboard page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Dashboard()),
        );
      } else if (_selectedIndex == 2) {
        // Navigate to Notification page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Notifications()),
        );
      } else if (_selectedIndex == 3) {
        // Navigate to Profile page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Profile()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const GearCareHeader(),
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 0, 28, 0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Vibrations",
                textAlign: TextAlign.start,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  fontSize: 28,
                  color: Color(0xff000000),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 10, 32, 0), // Added top padding for the legend
            child: Row(
              children: [
                _legendItem(Colors.green, "Good"),
                const SizedBox(width: 16),
                _legendItem(Colors.lightGreen, "Low"),
                const SizedBox(width: 16),
                _legendItem(Colors.yellow, "Medium"),
                const SizedBox(width: 16),
                _legendItem(Colors.orange, "High"),
                const SizedBox(width: 16),
                _legendItem(Colors.red, "Extreme"),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: ListView.builder(
                itemCount: vibrationData.length,
                itemBuilder: (BuildContext context, int index) {
                  return VibrationTile(value: vibrationData[index]);
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  Widget _legendItem(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 15,
          height: 15,
          color: color,
        ),
        const SizedBox(width: 5),
        Text(text),
      ],
    );
  }
}

class VibrationTile extends StatelessWidget {
  final double value;

  const VibrationTile({super.key, required this.value});

  Color _getColor(double value) {
    if (value < 1.00) {
      return Colors.green;
    } else if (value >= 1.00 && value < 2.00) {
      return Colors.lightGreen;
    } else if (value >= 2.00 && value < 2.50) {
      return Colors.yellow;
    }else if (value >= 2.00 && value < 2.50) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        decoration: BoxDecoration(
          color: _getColor(value),
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Vibration - ${value.toStringAsFixed(2)}'),
              const Icon(Icons.graphic_eq_sharp),
            ],
          ),
        ),
      ),
    );
  }
}
