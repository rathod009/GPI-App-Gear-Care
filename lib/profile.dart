import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gear_care/header.dart';
import 'package:gear_care/dashboard1.dart';
import 'package:gear_care/monitor.dart';
import 'package:gear_care/notifications.dart';
import 'package:gear_care/bottnavbar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<Profile> {
  int _selectedIndex = 3; // Set the initial index to 3 for Profile page

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
        // Currently we are in the Profile page
      }
    });
  }

  late Future<User> _userFuture;
  bool contactExpanded = true;
  bool addressExpanded = true;

  @override
  void initState() {
    super.initState();
    _userFuture = fetchUser();
  }

  Future<User> fetchUser() async {
    final response = await http.get(Uri.parse('https://randomuser.me/api/'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return User.fromJson(data['results'][0]);
    } else {
      throw Exception('Failed to load user');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const GearCareHeader(), // Gear Care header loaded first
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 0, 28, 0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Profile",
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
          Container(
            margin: const EdgeInsets.fromLTRB(28, 8, 28, 8),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.deepOrange, Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(),
            ),
            child: Expanded(
              child: FutureBuilder<User>(
                future: _userFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(28),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipOval(
                                  child: SizedBox(
                                    width: 85,
                                    height: 100,
                                    child: Image.network(
                                      snapshot.data!.imageUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data!.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                        ),
                                      ),
                                      Text(
                                        'Age: ${snapshot.data!.age}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'Gender: ${snapshot.data!.gender}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(16,8,16,8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      contactExpanded = !contactExpanded;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [Colors.indigo, Colors.indigoAccent],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                      // border: Border.all(),
                                    ),
                                    padding: const EdgeInsets.all(0),
                                    // color: Colors.blue,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            child: const Text(
                                              'Contact Details',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          child: Icon(
                                            contactExpanded ? Icons.expand_less : Icons.expand_more,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (contactExpanded)
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(10, 6, 0, 0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Phone No.: ${snapshot.data!.phone}',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'Email: ${snapshot.data!.email}',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                const SizedBox(height: 16),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      addressExpanded = !addressExpanded;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [Colors.indigo, Colors.indigoAccent],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                      // border: Border.all(),
                                    ),
                                    padding: const EdgeInsets.all(0),
                                    // color: Colors.blue,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            child: const Text(
                                              'Address Information',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          child: Icon(
                                            addressExpanded ? Icons.expand_less : Icons.expand_more,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (addressExpanded)
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(10, 6, 0, 0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Address: ${snapshot.data!.address}',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'State: ${snapshot.data!.state}',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'Country: ${snapshot.data!.country}',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'Postcode: ${snapshot.data!.postcode}',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
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
}

class User {
  final String imageUrl;
  final String name;
  final String email;
  final String phone;
  final String age;
  final String gender;
  final String address;
  final String state;
  final String country;
  final String postcode;

  User({
    required this.imageUrl,
    required this.name,
    required this.email,
    required this.phone,
    required this.age,
    required this.gender,
    required this.address,
    required this.state,
    required this.country,
    required this.postcode,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      imageUrl: json['picture']['large'] ?? '',
      name: '${json['name']['first']} ${json['name']['last']}',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      age: json['dob']['age'].toString(),
      gender: json['gender'] ?? '',
      address: json['location']['street']['name'] ?? '',
      state: json['location']['state'] ?? '',
      country: json['location']['country'] ?? '',
      postcode: json['location']['postcode'].toString(),
    );
  }
}
