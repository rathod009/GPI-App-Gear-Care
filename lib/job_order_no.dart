import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gear_care/dashboard1.dart';
import 'package:gear_care/images.dart';
import 'package:gear_care/monitor.dart';
import 'package:gear_care/header.dart';
import 'package:gear_care/bottnavbar.dart';
import 'package:gear_care/notifications.dart';
import 'package:gear_care/profile.dart';
import 'animated_dropdown.dart';

class JobOrderNo extends StatefulWidget {
  const JobOrderNo({super.key});

  @override
  _JobOrderNoState createState() => _JobOrderNoState();
}

class _JobOrderNoState extends State<JobOrderNo> {
  String dropdownValue = "Job Order No.";
  String selectedClass = "Select Class";
  String selectedJobOrder = "Select Job Order No.";
  int _selectedIndex = 0;
  final TextEditingController _jobOrderController = TextEditingController();
  final TextEditingController _assemblyDetailsController = TextEditingController();
  final TextEditingController _descriptionDetailsController = TextEditingController();
  List<String> jobOrders = ["123456", "234567", "345678"];
  String selectedSerialNo = "Select Serial No.";
  List<String> serialNumbers = ["SN123", "SN456", "SN789"]; // Random serial numbers

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 0) {
        // Navigate to home page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Dashboard()),
        );
      } else if (_selectedIndex == 1) {
        // Navigate to Monitor page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Monitor()),
        );
      } else if (_selectedIndex == 2) {
        // Navigate to Notifier page
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

  void navigateToSelectedPage() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Prepare the data to be saved
    Map<String, dynamic> jobOrderData = {
      'jobOrderNo': selectedJobOrder,
      'class': selectedClass,
      'serialNo': selectedSerialNo,
      'assemblyDetails': _assemblyDetailsController.text,
      'descriptionDetails': _descriptionDetailsController.text,
    };

    // Save the data to Firestore
    await firestore.collection('jobOrders').add(jobOrderData);

    // Navigate to Images page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Images()),
    );
  }

  bool _isAddingNewJobOrder = false;

  void _addNewJobOrder() {
    setState(() {
      _isAddingNewJobOrder = !_isAddingNewJobOrder;
    });
  }

  void _saveNewJobOrder() {
    final newJobOrder = _jobOrderController.text;
    if (newJobOrder.isNotEmpty && RegExp(r'^\d+$').hasMatch(newJobOrder)) {
      setState(() {
        jobOrders.add(newJobOrder);
        selectedJobOrder = newJobOrder;
        _isAddingNewJobOrder = false;
        _jobOrderController.clear();
      });
    } else {
      // Show an error message or handle invalid input
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid number.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildAddButton() {
    return IconButton(
      icon: Icon(_isAddingNewJobOrder ? Icons.close_sharp : Icons.add),
      onPressed: _toggleAddJobOrder,
      color: const Color(0xff212235),
      iconSize: 40,
    );
  }

  void _toggleAddJobOrder() {
    setState(() {
      _isAddingNewJobOrder = !_isAddingNewJobOrder;
      if (!_isAddingNewJobOrder) {
        _jobOrderController.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: [
          Column(
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
                        items: const ["Job Order No."],
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
                            "Select Job Order",
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
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xffffffff),
                                borderRadius: BorderRadius.circular(0),
                              ),
                              child: AnimatedDropdown(
                                value: selectedJobOrder,
                                items: jobOrders,
                                onChanged: (value) {
                                  setState(() {
                                    selectedJobOrder = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                            child: _buildAddButton(),
                          ),
                        ],
                      ),
                      if (_isAddingNewJobOrder)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 20,
                                    height: 0.4,
                                  ),
                                  controller: _jobOrderController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Job Order Number',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              IconButton(
                                icon: const Icon(Icons.check_box),
                                color: Colors.green,
                                iconSize: 44,
                                onPressed: _saveNewJobOrder,
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.zero,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Select Class",
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
                          SizedBox(width: 74),
                          const Padding(
                            padding: EdgeInsets.zero,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Select Serial No.",
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
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: AnimatedDropdown(
                              value: selectedClass,
                              items: const ["Class A", "Class B", "Class C", "Class D"],
                              onChanged: (value) {
                                setState(() {
                                  selectedClass = value!;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: AnimatedDropdown(
                              value: selectedSerialNo,
                              items: serialNumbers,
                              onChanged: (value) {
                                setState(() {
                                  selectedSerialNo = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 4),
                        child: Align(
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
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: TextField(
                          controller: _assemblyDetailsController,
                          obscureText: false,
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
                              borderSide: const BorderSide(
                                  color: Colors.blue, width: 1),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: Colors.blue, width: 1),
                            ),
                            hintText: "Enter Assembly Details",
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 20,
                            ),
                            filled: true,
                            fillColor: Colors.transparent,
                            isDense: false,
                            contentPadding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 4),
                        child: Align(
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
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: TextField(
                          controller: _descriptionDetailsController,
                          obscureText: false,
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
                              borderSide: const BorderSide(
                                  color: Colors.blue, width: 1),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: Colors.blue, width: 1),
                            ),
                            hintText: "Enter Description Details",
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 20,
                            ),
                            filled: true,
                            fillColor: Colors.transparent,
                            isDense: false,
                            contentPadding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Align(
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
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
