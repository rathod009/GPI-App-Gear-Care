import 'package:flutter/material.dart';
import 'package:gear_care/bottnavbar.dart';
import 'package:gear_care/header.dart';
import 'package:gear_care/monitor.dart';
import 'package:gear_care/notifications.dart';
import 'package:gear_care/profile.dart';
import 'package:gear_care/registration.dart';
// import 'package:gear_care/service_notifier.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
        // Currently we are in the main dashboard page
      } else if (_selectedIndex == 1) {
        // Navigate to monitor page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Monitor()),
        );
      } else if (_selectedIndex == 2) {
        // Navigate to notification page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Notifications()),
        );
      } else if (_selectedIndex == 3) {
        // Navigate to profile page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Profile()),
        );
      }
      // Add similar navigation logic for other icons if needed
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
          const GearCareHeader(), // Moved GearCareHeader here
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
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
                                  border: Border.all(
                                      color: Colors.black, width: 0),
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
                    padding: EdgeInsets.fromLTRB(28, 0, 28, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "Dashboard",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            fontSize: 26,
                            color: Color(0xff000000),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GridView(
                    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const ClampingScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1,
                    ),
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Registration()),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.all(0),
                          padding: const EdgeInsets.all(0),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Colors.blue, Colors.cyanAccent],
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
                                margin: const EdgeInsets.all(4),
                                padding: const EdgeInsets.all(0),
                                width: 70,
                                height: 70,
                                decoration: const BoxDecoration(
                                  // color: Colors.lightBlue,
                                  // shape: BoxShape.circle,
                                ),
                                child: const ImageIcon(
                                  AssetImage("assets/images/Registration.png"),
                                  size: 70,
                                  color: Colors.black,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                                child: Text(
                                  "Gear Registration",
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
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Monitor()),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.all(0),
                          padding: const EdgeInsets.all(0),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Colors.pinkAccent, Color.fromARGB(255, 255, 145, 220)],
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
                                margin: const EdgeInsets.all(4),
                                padding: const EdgeInsets.all(0),
                                width: 70,
                                height: 70,
                                decoration: const BoxDecoration(
                                  // color: Colors.pinkAccent,
                                  // shape: BoxShape.circle,
                                ),
                                child: const ImageIcon(
                                  AssetImage("assets/images/Monitoring.png"),
                                  size: 70,
                                  color: Colors.black,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                                child: Text(
                                  "Gear Monitoring",
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
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Notifications()),
                            // MaterialPageRoute(builder: (context) => const Service()),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.all(0),
                          padding: const EdgeInsets.all(0),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Colors.green, Colors.lightGreenAccent,],
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
                                margin: const EdgeInsets.all(4),
                                padding: const EdgeInsets.all(0),
                                width: 70,
                                height: 70,
                                decoration: const BoxDecoration(
                                  // color: Colors.lightGreenAccent,
                                  // shape: BoxShape.circle,
                                ),
                                child: const ImageIcon(
                                  AssetImage("assets/images/Notification.png"),
                                  size: 65,
                                  color: Colors.black,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                                child: Text(
                                  "Service Notifier",
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
