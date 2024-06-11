import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gear_care/dashboard2.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gear_care/bottnavbar.dart';
import 'package:gear_care/header.dart';
import 'package:gear_care/monitor.dart';
import 'package:gear_care/notifications.dart';
import 'package:gear_care/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Survey extends StatefulWidget {
  const Survey({super.key});

  @override
  SurveyState createState() => SurveyState();
}

class SurveyState extends State<Survey> {
  int _selectedIndex = 0;
  XFile? _selectedImage;

  final Map<String, String> _answers = {
    'temperature': 'na',
    'vibrations': 'na',
    'sound': 'na',
    'rotations': 'na',
    'condition': 'na',
  };

  final TextEditingController _serialNumberController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 0) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Dashboard2()),
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

  void _updateAnswer(String key, String value) {
    setState(() {
      _answers[key] = value;
    });
  }

  void _openImagePicker() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _selectedImage = pickedFile;
      });
    }
  }

  Future<void> _submitForm() async {
    try {
      // Add survey data to Firestore
      final surveyData = {
        'serial_number': _serialNumberController.text,
        'answers': _answers,
        'notes': _notesController.text,
        'timestamp': FieldValue.serverTimestamp(),
      };

      final docRef = await FirebaseFirestore.instance.collection('survey_forms').add(surveyData);

      // Upload the selected image to Firebase Storage (if any)
      if (_selectedImage != null) {
        final storageRef = FirebaseStorage.instance.ref().child('survey_images/${docRef.id}');
        await storageRef.putFile(File(_selectedImage!.path));
        final imageUrl = await storageRef.getDownloadURL();

        // Update the Firestore document with the image URL
        await docRef.update({'image_url': imageUrl});
      }

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Form submitted successfully!')));
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to submit form: $e')));
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
            padding: EdgeInsets.fromLTRB(28, 0, 28, 0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Survey Form",
                textAlign: TextAlign.start,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  fontSize: 26,
                  color: Color(0xff000000),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
            child: Text(
              "Make Sure Before Taking the Survey, You have Serviced All the Parts.\n"
              "Legends:  *'YES' - Serviced/Not Serviced and Working Fine. \n*'NO' - Serviced But, Not Working Fine.   *'N/A' - Not Applicable.",
              style: TextStyle(
                fontSize: 13,
                color: Colors.red,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 0, 28, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text(
                  "Serial Number: ",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 22,
                    color: Color(0xff000000),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: _serialNumberController,
                    readOnly: false,
                    obscureText: false,
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 20,
                      color: Color(0xff000000),
                    ),
                    decoration: InputDecoration(
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(color: Colors.blue, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(color: Colors.blue, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(color: Colors.blue, width: 1),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      isDense: true,
                      contentPadding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 28),
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(),
                            ),
                            _buildHeaderCell("Yes"),
                            _buildHeaderCell("No"),
                            _buildHeaderCell("N/A"),
                          ],
                        ),
                        _buildSurveyRow('Temperature', 'temperature'),
                        _buildSurveyRow('Vibrations', 'vibrations'),
                        _buildSurveyRow('Sound', 'sound'),
                        _buildSurveyRow('Rotations', 'rotations'),
                        _buildSurveyRow('Condition', 'condition'),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 2),
                    child: TextField(
                      controller: _notesController,
                      obscureText: false,
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
                          borderSide: const BorderSide(color: Colors.grey, width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(color: Colors.grey, width: 1),
                        ),
                        hintText: "Add Details/Notes If Any Related to Service.",
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 18,
                          color: Color(0xff7c7878),
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                        isDense: false,
                        contentPadding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.fromLTRB(28, 8, 28, 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.add_a_photo),
                              highlightColor: Colors.greenAccent,
                              onPressed: _openImagePicker,
                              color: const Color(0xff212435),
                              iconSize: 50,
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                              child: const Text(
                                "Add New Images",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 18,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (_selectedImage != null)
                          Container(
                            width: 80,
                            height: 80,
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Image.file(
                              File(_selectedImage!.path),
                              fit: BoxFit.cover,
                            ),
                          ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
                          colors: [Colors.indigo, Colors.indigoAccent],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                      child: MaterialButton(
                        onPressed: _submitForm,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        textColor: const Color(0xffffffff),
                        height: 50,
                        minWidth: double.infinity,
                        child: const Text(
                          "Submit",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
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

  Widget _buildHeaderCell(String label) {
    return Expanded(
      flex: 1,
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.normal,
            fontSize: 20,
            color: Color(0xff000000),
          ),
        ),
      ),
    );
  }

  Widget _buildSurveyRow(String label, String key) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                fontSize: 20,
                color: Color(0xff000000),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: Checkbox(
              value: _answers[key] == 'yes',
              onChanged: (bool? value) {
                if (value == true) {
                  _updateAnswer(key, 'yes');
                }
              },
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: Checkbox(
              value: _answers[key] == 'no',
              onChanged: (bool? value) {
                if (value == true) {
                  _updateAnswer(key, 'no');
                }
              },
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: Checkbox(
              value: _answers[key] == 'na',
              onChanged: (bool? value) {
                if (value == true) {
                  _updateAnswer(key, 'na');
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
