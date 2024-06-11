import 'package:flutter/material.dart';
import 'package:gear_care/bottnavbar.dart';
import 'package:gear_care/dashboard2.dart';
import 'package:gear_care/header.dart';
import 'package:gear_care/monitor.dart';
import 'package:gear_care/notifications.dart';
import 'package:gear_care/profile.dart';
import 'package:gear_care/survey_form.dart';

class FieldOfficer extends StatefulWidget {
  const FieldOfficer({super.key});

  @override
  FieldOfficerState createState() => FieldOfficerState();
}

class FieldOfficerState extends State<FieldOfficer> {
  int _selectedIndex = 0;
  
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 0) {
        // Navigate to Dashboard page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Dashboard2()),
        );
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
        children: [
          const GearCareHeader(),
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 0, 28, 0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Field Officer's Services",
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
                        MaterialPageRoute(builder: (context) => const Notifications()),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(0),
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.red, Colors.pinkAccent],
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
                            margin: const EdgeInsets.all(2),
                            padding: const EdgeInsets.all(0),
                            width: 75,
                            height: 75,
                            decoration: const BoxDecoration(),
                            child: const ImageIcon(
                              AssetImage("assets/images/Pending.png"),
                              size: 75,
                              color: Colors.black,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                            child: Text(
                              "Pending Services",
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
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => const Monitor()),
                          // );
                        },
                        child: Container(
                          margin: const EdgeInsets.all(0),
                          padding: const EdgeInsets.all(0),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Colors.teal, Colors.tealAccent],
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
                                  // color: Colors.pinkAccent,
                                  // shape: BoxShape.circle,
                                ),
                                child: const ImageIcon(
                                  AssetImage("assets/images/Progress.png"),
                                  size: 80,
                                  color: Colors.black,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                                child: Text(
                                  "In Progress",
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
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => const Notifications()),
                          //   // MaterialPageRoute(builder: (context) => const Service()),
                          // );
                        },
                        child: Container(
                          margin: const EdgeInsets.all(0),
                          padding: const EdgeInsets.all(0),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Colors.lightGreen, Colors.limeAccent],
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
                                  AssetImage("assets/images/Completed.png"),
                                  size: 70,
                                  color: Colors.black,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                                child: Text(
                                  "Services Done",
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
                            MaterialPageRoute(builder: (context) => const Survey()),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.all(0),
                          padding: const EdgeInsets.all(0),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Colors.grey, Colors.white],
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
                                  AssetImage("assets/images/Survey1.png"),
                                  size: 80,
                                  color: Colors.black,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                                child: Text(
                                  "Survey",
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
