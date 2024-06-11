import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:gear_care/bottnavbar.dart';
import 'package:gear_care/dashboard1.dart';
import 'package:gear_care/header.dart';
import 'package:gear_care/monitor.dart';
import 'package:gear_care/notifications.dart';
import 'package:gear_care/profile.dart';

class Images extends StatefulWidget {
  const Images({super.key});
  
  @override
  _ImagesState createState() => _ImagesState();
}

class _ImagesState extends State<Images> {
  int _selectedIndex = 0;
  final TextEditingController _serialNumberController = TextEditingController();
  final List<XFile> _images = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 0) {
        // Navigate to home page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Dashboard()),
        );
      } 
      else if (_selectedIndex == 1) {
        // Navigate to Monitor page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Monitor()),
        );
      }
      else if (_selectedIndex == 2) {
        // Navigate to Notifier page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Notifications()),
        );
      }
      else if (_selectedIndex == 3) {
        // Navigate to Profile page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Profile()),
        );
      }
    });
  }

  Future<void> _fetchImages() async {
    // Simulate fetching images for the given serial number.
    // Replace this with actual logic to fetch images from a server or database.
    String serialNumber = _serialNumberController.text;
    print('Fetching images for serial number: $serialNumber');
  }

  Future<void> _pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> pickedImages = await picker.pickMultiImage();
    if (pickedImages.isNotEmpty) {
      setState(() {
        _images.addAll(pickedImages);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const GearCareHeader(),
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
                    fontSize: 24,
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
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _fetchImages,
                  color: const Color(0xff212435),
                  iconSize: 30,
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  GridView.count(
                    padding: const EdgeInsets.fromLTRB(28, 8, 28, 8),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.0,
                    children: List.generate(_images.length, (index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.lightBlueAccent,
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: FileImage(File(_images[index].path)),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }),
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.fromLTRB(28, 8, 28, 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.green, width: 1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.add_a_photo),
                          onPressed: _pickImages,
                          color: const Color(0xff212435),
                          iconSize: 44,
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          child: const Text(
                            "Add New Images",
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
                      ],
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
              child: MaterialButton(
                onPressed: () {
                  // Save the data to database
                },
                color: const Color(0xff3a57e8),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                textColor: const Color(0xffffffff),
                height: 50,
                child: const Text(
                  "Save",
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
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:gear_care/bottnavbar.dart';
// import 'package:gear_care/dashboard1.dart';
// import 'package:gear_care/header.dart';
// import 'package:gear_care/monitor.dart';
// import 'package:gear_care/notifications.dart';
// import 'package:gear_care/profile.dart';

// class Images extends StatefulWidget {
//   const Images({super.key});

//   @override
//   _ImagesState createState() => _ImagesState();
// }

// class _ImagesState extends State<Images> {
//   int _selectedIndex = 0;
//   final TextEditingController _serialNumberController = TextEditingController();
//   final List<XFile> _images = [];
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseStorage _storage = FirebaseStorage.instance;

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//       if (_selectedIndex == 0) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const Dashboard()),
//         );
//       } else if (_selectedIndex == 1) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const Monitor()),
//         );
//       } else if (_selectedIndex == 2) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const Notifications()),
//         );
//       } else if (_selectedIndex == 3) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const Profile()),
//         );
//       }
//     });
//   }

//   Future<void> _fetchImages() async {
//     String serialNumber = _serialNumberController.text;
//     QuerySnapshot querySnapshot = await _firestore
//         .collection('images')
//         .where('serialNo', isEqualTo: serialNumber)
//         .get();

//     List<String> imageUrls = [];
//     for (var doc in querySnapshot.docs) {
//       imageUrls.add(doc['url']);
//     }

//     setState(() {
//       _images.clear();
//       for (var url in imageUrls) {
//         _images.add(XFile(url));
//       }
//     });

//     print('Fetching images for serial number: $serialNumber');
//   }

//   Future<void> _pickImages() async {
//     final ImagePicker picker = ImagePicker();
//     final List<XFile> pickedImages = await picker.pickMultiImage();
//     if (pickedImages.isNotEmpty) {
//       setState(() {
//         _images.addAll(pickedImages);
//       });
//     }
//   }

//   Future<void> _saveImages() async {
//     String serialNumber = _serialNumberController.text;
//     for (var image in _images) {
//       File file = File(image.path);
//       String fileName = image.name;
//       try {
//         // Upload image to Firebase Storage
//         TaskSnapshot snapshot = await _storage
//             .ref()
//             .child('images/$serialNumber/$fileName')
//             .putFile(file);
//         String downloadUrl = await snapshot.ref.getDownloadURL();

//         // Save image URL to Firestore
//         await _firestore.collection('images').add({
//           'serialNo': serialNumber,
//           'url': downloadUrl,
//         });
//       } catch (e) {
//         print('Error uploading image: $e');
//       }
//     }
//     print('Images saved successfully');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffffffff),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisSize: MainAxisSize.max,
//         children: [
//           const GearCareHeader(),
//           Padding(
//             padding: const EdgeInsets.fromLTRB(28, 0, 28, 8),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 const Text(
//                   "Serial Number: ",
//                   textAlign: TextAlign.start,
//                   overflow: TextOverflow.clip,
//                   style: TextStyle(
//                     fontWeight: FontWeight.w400,
//                     fontStyle: FontStyle.normal,
//                     fontSize: 24,
//                     color: Color(0xff000000),
//                   ),
//                 ),
//                 Expanded(
//                   flex: 1,
//                   child: TextField(
//                     controller: _serialNumberController,
//                     readOnly: false,
//                     obscureText: false,
//                     textAlign: TextAlign.start,
//                     maxLines: 1,
//                     style: const TextStyle(
//                       fontWeight: FontWeight.w400,
//                       fontStyle: FontStyle.normal,
//                       fontSize: 20,
//                       color: Color(0xff000000),
//                     ),
//                     decoration: InputDecoration(
//                       disabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                         borderSide: const BorderSide(color: Colors.blue, width: 1),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                         borderSide: const BorderSide(color: Colors.blue, width: 1),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                         borderSide: const BorderSide(color: Colors.blue, width: 1),
//                       ),
//                       filled: true,
//                       fillColor: Colors.white,
//                       isDense: true,
//                       contentPadding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.search),
//                   onPressed: _fetchImages,
//                   color: const Color(0xff212435),
//                   iconSize: 30,
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisSize: MainAxisSize.max,
//                 children: [
//                   GridView.count(
//                     padding: const EdgeInsets.fromLTRB(28, 8, 28, 8),
//                     shrinkWrap: true,
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 16,
//                     mainAxisSpacing: 16,
//                     childAspectRatio: 1.0,
//                     children: List.generate(_images.length, (index) {
//                       return Container(
//                         decoration: BoxDecoration(
//                           color: Colors.lightBlueAccent,
//                           borderRadius: BorderRadius.circular(8),
//                           image: DecorationImage(
//                             image: FileImage(File(_images[index].path)),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       );
//                     }),
//                   ),
//                   Container(
//                     width: double.infinity,
//                     margin: const EdgeInsets.fromLTRB(28, 8, 28, 8),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10),
//                       border: Border.all(color: Colors.green, width: 1),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisSize: MainAxisSize.max,
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.add_a_photo),
//                           onPressed: _pickImages,
//                           color: const Color(0xff212435),
//                           iconSize: 44,
//                         ),
//                         Container(
//                           padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
//                           child: const Text(
//                             "Add New Images",
//                             textAlign: TextAlign.start,
//                             overflow: TextOverflow.clip,
//                             style: TextStyle(
//                               fontWeight: FontWeight.w400,
//                               fontStyle: FontStyle.normal,
//                               fontSize: 22,
//                               color: Color(0xff000000),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(
//             width: double.infinity,
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(28, 0, 28, 10),
//               child: MaterialButton(
//                 onPressed: _saveImages,
//                 color: const Color(0xff3a57e8),
//                 elevation: 0,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 textColor: const Color(0xffffffff),
//                 height: 50,
//                 child: const Text(
//                   "Save",
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.w500,
//                     fontStyle: FontStyle.normal,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomNavBar(
//         selectedIndex: _selectedIndex,
//         onItemTapped: _onItemTapped,
//       ),
//     );
//   }
// }
