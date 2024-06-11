import 'package:flutter/material.dart';
import 'package:gear_care/bottnavbar.dart';
import 'package:gear_care/field_officer.dart';
import 'package:gear_care/header.dart';
import 'package:gear_care/monitor.dart';
import 'package:gear_care/notifications.dart';
import 'package:gear_care/profile.dart';

class Dashboard2 extends StatefulWidget {
  const Dashboard2({super.key});

  @override
  Dashboard2State createState() => Dashboard2State();
}

class Dashboard2State extends State<Dashboard2> {
  int _selectedIndex = 0;
  
  String getGreeting() {
    final now = DateTime.now().toUtc().add(const Duration(hours: 5, minutes: 30));
    final hour = now.hour;

    if (hour < 12) {
      return "Good Morning";
    } else if (hour < 17) {
      return "Good Afternoon";
    } else if (hour < 20) {
      return "Good Evening";
    } else {
      return "Good Night";
    }
  }
  
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 0) {
        // We are Already in the Dashboard2 page
      } else if (_selectedIndex == 1) {
        // Navigate to Monitor page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Monitor()),
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const GearCareHeader(),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        getGreeting(),
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 16,
                          color: Color(0xff8c8989),
                        ),
                      ),
                      const Text(
                        "Bhumik Rathod",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          fontSize: 18,
                          color: Color(0xff000000),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: 50,
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 0),
                        ),
                        child: Image.asset("assets/images/Bhumik.jpg", 
                        fit: BoxFit.cover),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 0, 28, 0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Dashboard",
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 28),
              child: GridView(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const ClampingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 2,
                ),
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const FieldOfficer()),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(0),
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.orangeAccent, Colors.yellow],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.all(1),
                            padding: const EdgeInsets.all(0),
                            width: 80,
                            height: 80,
                            decoration: const BoxDecoration(
                              // color: Colors.amberAccent,
                              // shape: BoxShape.circle,
                            ),
                            child: const ImageIcon(
                              AssetImage("assets/images/Field_Officer2.png"),
                              size: 80,
                              color: Colors.black,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                            child: Text(
                              "Field Officer",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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
