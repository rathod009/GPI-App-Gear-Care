import 'package:flutter/material.dart';
import 'package:gear_care/dashboard1.dart';
import 'package:gear_care/monitor.dart';
import 'package:gear_care/header.dart';
import 'package:gear_care/images.dart';
import 'package:gear_care/bottnavbar.dart';
import 'package:gear_care/notifications.dart';
import 'package:gear_care/profile.dart';
import 'animated_dropdown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SerialNo extends StatefulWidget {
  const SerialNo({super.key});

  @override
  _SerialNoState createState() => _SerialNoState();
}

class _SerialNoState extends State<SerialNo> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String dropdownValue = "Serial No.";
  String serialNumberValue = "Select Serial No.";
  int _selectedIndex = 0;
  List<String> serialNumbers = ["SN123","SN456","SN789"];

  final TextEditingController _classController = TextEditingController();
  final TextEditingController _assemblyDetailsController = TextEditingController();
  final TextEditingController _descriptionDetailsController = TextEditingController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 0) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Dashboard()),
        );
      } else if (_selectedIndex == 1) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Monitor()),
        );
      } else if (_selectedIndex == 2) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Notifications()),
        );
      } else if (_selectedIndex == 3) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Profile()),
        );
      }
    });
  }

  void navigateToSelectedPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Images()),
    );
  }

  Future<void> _fetchJobOrders(String serialNumber) async {
    QuerySnapshot querySnapshot = await _firestore.collection('jobOrders').where('serialNo', isEqualTo: serialNumber).get();
    setState(() {
      if (querySnapshot.docs.isNotEmpty) {
        Map<String, dynamic> data = querySnapshot.docs.first.data() as Map<String, dynamic>;
        _classController.text = data['class'] ?? '';
        _assemblyDetailsController.text = data['assemblyDetails'] ?? '';
        _descriptionDetailsController.text = data['descriptionDetails'] ?? '';
      } else {
        _classController.clear();
        _assemblyDetailsController.clear();
        _descriptionDetailsController.clear();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // Fetch job orders for the default serial number
    _fetchJobOrders(serialNumberValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Column(
        children: [
          const GearCareHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(28, 0, 28, 0),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Select Your Type",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 22,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                  ),
                  AnimatedDropdown(
                    value: dropdownValue,
                    items: const ["Serial No."],
                    onChanged: (value) {
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.zero,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Select Serial Number",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 22,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
                    decoration: BoxDecoration(
                      color: const Color(0xffffffff),
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: AnimatedDropdown(
                      value: serialNumberValue,
                      items: serialNumbers,
                      onChanged: (value) {
                        setState(() {
                          serialNumberValue = value!;
                          // Fetch job orders when dropdown value changes
                          _fetchJobOrders(serialNumberValue);
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Class",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 22,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                  TextField(
                    controller: _classController,
                    obscureText: false,
                    readOnly: true,
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 20,
                      color: Color(0xff000000),
                    ),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.green, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.green, width: 1),
                      ),
                      hintText: "Fetching Class...",
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 20,
                      ),
                      filled: true,
                      fillColor: Colors.transparent,
                      isDense: false,
                      contentPadding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Assembly Details",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 22,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
                    child: TextField(
                      controller: _assemblyDetailsController,
                      obscureText: false,
                      readOnly: true,
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 20,
                        color: Color(0xff000000),
                      ),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.green, width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.green, width: 1),
                        ),
                        hintText: "Fetch Assembly Details",
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 20,
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                        isDense: false,
                        contentPadding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Description Details",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 22,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
                    child: TextField(
                      controller: _descriptionDetailsController,
                      obscureText: false,
                      readOnly: true,
                      textAlign: TextAlign.start,
                      maxLines: 5,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 20,
                        color: Color(0xff000000),
                      ),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.green, width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.green, width: 1),
                        ),
                        hintText: "Fetch Description Details",
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 20,
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                        isDense: false,
                        contentPadding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(28, 0, 28, 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  gradient: const LinearGradient(
                    colors: [Colors.indigo, Colors.indigoAccent],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: MaterialButton(
                  onPressed: navigateToSelectedPage,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  textColor: const Color(0xffffffff),
                  height: 50,
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
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
