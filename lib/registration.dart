import 'package:flutter/material.dart';
import 'package:gear_care/dashboard1.dart';
import 'package:gear_care/job_order_no.dart';
import 'package:gear_care/notifications.dart';
import 'package:gear_care/profile.dart';
import 'package:gear_care/serial_no.dart';
import 'package:gear_care/header.dart';
import 'package:gear_care/monitor.dart';
import 'package:gear_care/bottnavbar.dart';
import 'animated_dropdown.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});
  
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  String dropdownValue = "Job Order No.";
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Dashboard()),
        );
      } else if (_selectedIndex == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Monitor()),
        );
      } else if (_selectedIndex == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Notifications()),
        );
      } else if (_selectedIndex == 3) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Profile()),
        );
      }
    });
  }

  void navigateToSelectedPage() {
    if (dropdownValue == "Job Order No.") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const JobOrderNo()),
      );
    } else if (dropdownValue == "Serial No.") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SerialNo()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Column(
        children: [
          const GearCareHeader(),
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 0, 28, 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Select Your Type",
                textAlign: TextAlign.start,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  fontSize: 22,
                  color: Color(0xff000000),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 0, 28, 0),
            child: AnimatedDropdown(
              value: dropdownValue,
              items: const ["Job Order No.", "Serial No."],
              onChanged: (value) {
                setState(() {
                  dropdownValue = value!;
                });
              },
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(28, 0, 28, 10),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.indigo, Colors.indigoAccent],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: MaterialButton(
                    onPressed: navigateToSelectedPage,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    textColor: const Color(0xffffffff),
                    child: const Text(
                      "Next",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                ),
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
}
