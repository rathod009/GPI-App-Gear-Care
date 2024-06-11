import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'dashboard1.dart';
import 'header.dart';
import 'bottnavbar.dart';
import 'notifications.dart';
import 'profile.dart';
import 'vibration.dart';

class Monitor extends StatefulWidget {
  const Monitor({super.key, superKey, Key? Key});

  @override
  _MonitorState createState() => _MonitorState();
}

class _MonitorState extends State<Monitor> {
  int _selectedIndex = 1; // Set the initial index to 1 for Monitor page
  List<double> temperatureData = [0]; // Initialize an empty list for temperature data
  List<double> vibrationData = [0]; // Initialize an empty list for vibration data
  Timer? timer;

  @override
  void initState() {
    super.initState();
    // Start fetching and updating dummy temperature and vibration data
    timer = Timer.periodic(const Duration(seconds: 5), (Timer t) {
      fetchRealTimeData();
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void fetchRealTimeData() {
  // Generate random temperature data between 40 to 60 degrees Celsius
  double newTemperature = Random().nextDouble() * 20 + 30;
  newTemperature = double.parse(newTemperature.toStringAsFixed(2));

  setState(() {
    // Add new temperature data and keep only the latest 10 data points
    temperatureData.add(newTemperature);
    if (temperatureData.length > 10) {
      temperatureData.removeAt(0);
    }

    // Calculate vibration based on temperature
    double newVibration = mapTemperatureToVibration(newTemperature);
    newVibration = double.parse(newVibration.toStringAsFixed(2));

    // Add new vibration data and keep only the latest 10 data points
    vibrationData.add(newVibration);
    if (vibrationData.length > 10) {
      vibrationData.removeAt(0);
    }
  });
}


  // Function to map temperature to vibration level
  double mapTemperatureToVibration(double temperature) {
    // Define vibration range
    double minVibration = 1.0; // Minimum vibration level
    double maxVibration = 3.0; // Maximum vibration level

    // Map temperature range (40-60) to vibration range (1-10)
    return ((temperature - 40) / (60 - 40)) * (maxVibration - minVibration) + minVibration;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 0) {
        // Navigate to home page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Dashboard()),
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
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 0, 28, 16),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Gear Monitoring",
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
                    controller: TextEditingController(),
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
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 8, 28, 4),
            child: Container(
              decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.white, Colors.white, Colors.red],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(),
            ),
              width: double.infinity,
              // color: Colors.pink[200], // Grey background color
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  const Icon(Icons.thermostat), // Temperature icon
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Temperature',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Text(
                    '${temperatureData.last.toStringAsFixed(2)}°C',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(28, 8, 28, 4),
                    child: SizedBox(
                      height: 180, // Specify a fixed height for the temperature chart
                      width: double.infinity,
                      child: LineChart(
                        LineChartData(
                          lineBarsData: [
                            LineChartBarData(
                              spots: temperatureData
                                  .asMap()
                                  .entries
                                  .where((entry) => entry.value.isFinite) // Filter out infinite values
                                  .map((entry) => FlSpot(entry.key.toDouble(), entry.value))
                                  .toList(),
                              isCurved: true,
                              colors: [Colors.pink],
                              barWidth: 3,
                              isStrokeCapRound: true,
                              dotData: FlDotData(show: true),
                              belowBarData: BarAreaData(show: true, colors: [Colors.pink.withOpacity(0.4)]),
                              show: true,
                              // belowSpotsLine: BelowSpotsLine(show: false),
                            ),
                          ],
                          maxY: 65,
                          minY: 0,
                          titlesData: FlTitlesData(
                            leftTitles: SideTitles(
                              showTitles: true,
                              getTextStyles: (value) => const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              margin: 8,
                              reservedSize: 20,
                              interval: 10,
                            ),
                            bottomTitles: SideTitles(
                              showTitles: true,
                              getTextStyles: (value) => const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              margin: 8,
                              reservedSize: 20,
                              interval: 1,
                              // Ensure numbers appear on the x-axis for the latest 10 data points
                              getTitles: (value) {
                                if (temperatureData.length <= 10) {
                                  return value.toInt().toString();
                                } else {
                                  if (value.toInt() == temperatureData.length - 1) {
                                    return value.toInt().toString();
                                  }
                                  return '';
                                }
                              },
                            ),
                          ),
                          gridData: FlGridData(show: true, drawVerticalLine: true), // Remove grid lines
                          borderData: FlBorderData(
                            show: true,
                            border: Border.all(color: const Color(0xff37434d), width: 1.5),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(28, 8, 28, 4),
                    child: Container(
                      decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.white, Colors.white, Colors.cyan],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(),
            ),
                      width: double.infinity,
                      // color: Colors.cyan[200], // Grey background color
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          const Icon(Icons.graphic_eq_sharp), // Vibration icon
                          const SizedBox(width: 8),
                          const Expanded(
                            child: Text(
                              'Vibration',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Text(
                            vibrationData.last.toStringAsFixed(2),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(28, 8, 28, 4),
                    child: SizedBox(
                      height: 180, // Specify a fixed height for the vibration chart
                      width: double.infinity,
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY: 3.5,
                          barTouchData: BarTouchData(enabled: true),
                          titlesData: FlTitlesData(
                            leftTitles: SideTitles(
                              showTitles: true,
                              getTextStyles: (value) => const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              margin: 8,
                              reservedSize: 20,
                              interval: 1,
                              // Customize the titles on the y-axis as per your requirement
                              getTitles: (value) {
                                switch (value.toInt()) {
                                  case 0:
                                    return '0';
                                  case 1:
                                    return 'Low';
                                  case 2:
                                    return 'Med';
                                  case 3:
                                    return 'High';
                                  case 4:
                                    return '';
                                  default:
                                    return '';
                                }
                              },
                            ),
                            bottomTitles: SideTitles(
                              showTitles: true,
                              getTextStyles: (value) => const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              margin: 8,
                              reservedSize: 20,
                              interval: 2,
                              // Ensure numbers appear on the x-axis for the latest 10 data points
                              getTitles: (value) {
                                if (vibrationData.length <= 10) {
                                  return value.toInt().toString();
                                } else {
                                  if (value.toInt() == vibrationData.length - 1) {
                                    return value.toInt().toString();
                                  }
                                  return '';
                                }
                              },
                            ),
                          ),
                          gridData: FlGridData(show: true, drawHorizontalLine: true),
                          borderData: FlBorderData(
                            show: true,
                            border: Border.all(color: const Color(0xff37434d), width: 1.5),
                          ),
                          barGroups: vibrationData
                              .asMap()
                              .entries
                              .where((entry) => entry.value.isFinite) // Filter out infinite values
                              .map((entry) {
                            return BarChartGroupData(
                              x: entry.key,
                              barRods: [
                                BarChartRodData(
                                  y: entry.value,
                                  colors: [Colors.cyan],
                                ),
                              ],
                              showingTooltipIndicators: [],
                            );
                          }).toList(),
                        ),
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
        gradient: const LinearGradient(
          colors: [Colors.indigo, Colors.indigoAccent],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Vibration()),
            );
          },
          borderRadius: BorderRadius.circular(10.0),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Center(
              child: Text(
                "Check Vibrations",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  color: Colors.white,
                ),
              ),
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


// import 'dart:math';
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:gear_care/dashboard.dart';
// import 'package:gear_care/header.dart';
// import 'package:gear_care/bottnavbar.dart';
// import 'package:gear_care/notifications.dart';
// import 'package:gear_care/profile.dart';

// class Monitor extends StatefulWidget {
//   const Monitor({Key? key});

//   @override
//   _MonitorState createState() => _MonitorState();
// }

// class _MonitorState extends State<Monitor> {
//   int _selectedIndex = 1; // Set the initial index to 1 for Monitor page
//   List<double> temperatureData = [0]; // Initialize an empty list for temperature data
//   List<double> vibrationData = [0]; // Initialize an empty list for vibration data
//   Timer? timer;

//   @override
//   void initState() {
//     super.initState();
//     // Start fetching and updating dummy temperature and vibration data
//     timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
//       fetchRealTimeData();
//     });
//   }

//   @override
//   void dispose() {
//     timer?.cancel();
//     super.dispose();
//   }

//   void fetchRealTimeData() {
//     // Generate random temperature data between 40 to 60 degrees Celsius
//     double newTemperature = Random().nextDouble() * 20 + 40;

//     setState(() {
//       // Add new temperature data and keep only the latest 10 data points
//       temperatureData.add(newTemperature);
//       if (temperatureData.length > 10) {
//         temperatureData.removeAt(0);
//       }

//       // Calculate vibration based on temperature
//       double newVibration = mapTemperatureToVibration(newTemperature);

//       // Add new vibration data and keep only the latest 10 data points
//       vibrationData.add(newVibration);
//       if (vibrationData.length > 10) {
//         vibrationData.removeAt(0);
//       }
//     });
//   }

//   // Function to map temperature to vibration level
//   double mapTemperatureToVibration(double temperature) {
//     // Define vibration range
//     double minVibration = 1.0; // Minimum vibration level
//     double maxVibration = 5.0; // Maximum vibration level

//     // Map temperature range (40-60) to vibration range (1-10)
//     return ((temperature - 40) / (60 - 40)) * (maxVibration - minVibration) + minVibration;
//   }

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//       if (_selectedIndex == 0) {
//         // Navigate to home page
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const Dashboard()),
//         );
//       } else if (_selectedIndex == 2) {
//         // Navigate to Notifier page
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const Notifications()),
//         );
//       } else if (_selectedIndex == 3) {
//         // Navigate to Profile page
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const Profile()),
//         );
//       }
//     });
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
//           const Padding(
//             padding: EdgeInsets.fromLTRB(28, 0, 28, 16),
//             child: Align(
//               alignment: Alignment.center,
//               child: Text(
//                 "Gear Monitoring",
//                 textAlign: TextAlign.start,
//                 overflow: TextOverflow.clip,
//                 style: TextStyle(
//                   fontWeight: FontWeight.w500,
//                   fontStyle: FontStyle.normal,
//                   fontSize: 26,
//                   color: Color(0xff000000),
//                 ),
//               ),
//             ),
//           ),
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
//                     controller: TextEditingController(),
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
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.fromLTRB(28, 8, 28, 4),
//             child: Container(
//               width: double.infinity,
//               color: Colors.grey[200], // Grey background color
//               padding: const EdgeInsets.all(8),
//               child: Row(
//                 children: [
//                   Icon(Icons.thermostat), // Temperature icon
//                   const SizedBox(width: 8),
//                   Expanded(
//                     child: Text(
//                       'Temperature',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18,
//                       ),
//                     ),
//                   ),
//                   Text(
//                     '${temperatureData.last.toStringAsFixed(2)}°C',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisSize: MainAxisSize.max,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(28, 8, 28, 4),
//                     child: SizedBox(
//                       height: 180, // Specify a fixed height for the temperature chart
//                       width: double.infinity,
//                       child: LineChart(
//                         LineChartData(
//                           lineBarsData: [
//                             LineChartBarData(
//                               spots: temperatureData
//                                   .asMap()
//                                   .entries
//                                   .where((entry) => entry.value.isFinite) // Filter out infinite values
//                                   .map((entry) => FlSpot(entry.key.toDouble(), entry.value))
//                                   .toList(),
//                               isCurved: true,
//                               colors: [Colors.pink],
//                               barWidth: 3,
//                               isStrokeCapRound: true,
//                               dotData: FlDotData(show: true),
//                               belowBarData: BarAreaData(show: true, colors: [Colors.pink.withOpacity(0.4)]),
//                               show: true,
//                               // belowSpotsLine: BelowSpotsLine(show: false),
//                             ),
//                           ],
//                           minY: 0,
//                           titlesData: FlTitlesData(
//                             leftTitles: SideTitles(
//                               showTitles: true,
//                               getTextStyles: (value) => const TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 14,
//                               ),
//                               margin: 8,
//                               reservedSize: 20,
//                               interval: 10,
//                             ),
//                             bottomTitles: SideTitles(
//                               showTitles: true,
//                               getTextStyles: (value) => const TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 14,
//                               ),
//                               margin: 8,
//                               reservedSize: 20,
//                               interval: 2,
//                               // Ensure numbers appear on the x-axis for the latest 10 data points
//                               getTitles: (value) {
//                                 if (temperatureData.length <= 10) {
//                                   return value.toInt().toString();
//                                 } else {
//                                   if (value.toInt() == temperatureData.length - 1) {
//                                     return value.toInt().toString();
//                                   }
//                                   return '';
//                                 }
//                               },
//                             ),
//                           ),
//                           gridData: FlGridData(show: true), // Remove grid lines
//                           borderData: FlBorderData(
//                             show: true,
//                             border: Border.all(color: const Color(0xff37434d), width: 1.5),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(28, 8, 28, 4),
//                     child: Container(
//                       width: double.infinity,
//                       color: Colors.grey[200], // Grey background color
//                       padding: const EdgeInsets.all(8),
//                       child: Row(
//                         children: [
//                           Icon(Icons.vibration), // Vibration icon
//                           const SizedBox(width: 8),
//                           Expanded(
//                             child: Text(
//                               'Vibration',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 18,
//                               ),
//                             ),
//                           ),
//                           Text(
//                             '${vibrationData.last.toStringAsFixed(2)}',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 18,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(28, 8, 28, 4),
//                     child: SizedBox(
//                       height: 180, // Specify a fixed height for the vibration chart
//                       width: double.infinity,
//                       child: LineChart(
//                         LineChartData(
//                           lineBarsData: [
//                             LineChartBarData(
//                               spots: vibrationData
//                                   .asMap()
//                                   .entries
//                                   .where((entry) => entry.value.isFinite) // Filter out infinite values
//                                   .map((entry) => FlSpot(entry.key.toDouble(), entry.value))
//                                   .toList(),
//                               isCurved: true,
//                               colors: [Colors.cyan],
//                               barWidth: 3,
//                               isStrokeCapRound: true,
//                               dotData: FlDotData(show: true),
//                               belowBarData: BarAreaData(show: true, colors: [Colors.blue.withOpacity(0.4)]),
//                               show: true,
//                               // belowSpotsLine: BelowSpotsLine(show: false),
//                             ),
//                           ],
//                           minY: 0,
//                           titlesData: FlTitlesData(
//                             leftTitles: SideTitles(
//                               showTitles: true,
//                               getTextStyles: (value) => const TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 14,
//                               ),
//                               margin: 8,
//                               reservedSize: 20,
//                               interval: 2,
//                             ),
//                             bottomTitles: SideTitles(
//                               showTitles: true,
//                               getTextStyles: (value) => const TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 14,
//                               ),
//                               margin: 8,
//                               reservedSize: 20,
//                               interval: 2,
//                               // Ensure numbers appear on the x-axis for the latest 10 data points
//                               getTitles: (value) {
//                                 if (vibrationData.length <= 10) {
//                                   return value.toInt().toString();
//                                 } else {
//                                   if (value.toInt() == vibrationData.length - 1) {
//                                     return value.toInt().toString();
//                                   }
//                                   return '';
//                                 }
//                               },
//                             ),
//                           ),
//                           gridData: FlGridData(show: true), // Remove grid lines
//                           borderData: FlBorderData(
//                             show: true,
//                             border: Border.all(color: const Color(0xff37434d), width: 1.5),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
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


// ======================================================================

// import 'package:flutter/material.dart';
// import 'package:gear_care/dashboard.dart';
// // import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:gear_care/header.dart';
// import 'package:gear_care/bottnavbar.dart';
// import 'package:gear_care/notifications.dart';
// import 'package:gear_care/profile.dart';

// class Monitor extends StatefulWidget {
//   const Monitor({super.key});

//   @override
//   _MonitorState createState() => _MonitorState();
// }

// class _MonitorState extends State<Monitor> {
//   int _selectedIndex = 1; // Set the initial index to 1 for Monitor page

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//       if (_selectedIndex == 0) {
//         // Navigate to home page
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const Dashboard()),
//         );
//       } 
//       else if (_selectedIndex == 1) {
//         // We are currently in the Monitor page
//       }
//       else if (_selectedIndex == 2) {
//         // Navigate to Notifier page
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const Notifications()),
//         );
//       }
//       else if (_selectedIndex == 3) {
//         // Navigate to Profile page
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const Profile()),
//         );
//       }
//     });
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
//           const Padding(
//             padding: EdgeInsets.fromLTRB(28, 0, 28, 16),
//             child: Align(
//               alignment: Alignment.center,
//               child: Text(
//                 "Gear Monitoring",
//                 textAlign: TextAlign.start,
//                 overflow: TextOverflow.clip,
//                 style: TextStyle(
//                   fontWeight: FontWeight.w500,
//                   fontStyle: FontStyle.normal,
//                   fontSize: 26,
//                   color: Color(0xff000000),
//                 ),
//               ),
//             ),
//           ),
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
//                     controller: TextEditingController(),
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
//                     crossAxisCount: 1,
//                     crossAxisSpacing: 16,
//                     mainAxisSpacing: 16,
//                     childAspectRatio: 2.0, // Make images square
//                     children: List.generate(1, (index) {
//                       // Generate your sample images here
//                       return Container(
//                         decoration: BoxDecoration(
//                           color: Colors.lightBlueAccent,
//                           borderRadius: BorderRadius.circular(8), // Round edges
//                           ),
//                           child: Center(
//                             child: Text(
//                               "Image $index",
//                               style: const TextStyle(fontSize: 20),
//                             ),
//                           ),
//                         );
//                       }
//                     ),
//                   ),
//                   const SizedBox(height: 80,),
                  
//                   // NewWidget(), // Add new.dart here

//                 ],
//               ),
//             ),
//           ),
//           // SizedBox(
//           //   width: double.infinity,
//           //   child: Padding(
//           //     padding: const EdgeInsets.fromLTRB(28, 0, 28, 10),
//           //     child: MaterialButton(
//           //       onPressed: () {
//           //         // Navigate to the Notification screen
//           //         Navigator.push(
//           //           context,
//           //           MaterialPageRoute(builder: (context) => Notifier()),
//           //         );
//           //       },
//           //       color: const Color(0xff3a57e8),
//           //       elevation: 0,
//           //       shape: RoundedRectangleBorder(
//           //         borderRadius: BorderRadius.circular(10.0),
//           //       ),
//           //       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           //       textColor: const Color(0xffffffff),
//           //       height: 50,
//           //       // Width is auto (responsive) due to Expanded widget
//           //       child: const Text(
//           //         "Next",
//           //         style: TextStyle(
//           //           fontSize: 16,
//           //           fontWeight: FontWeight.w700,
//           //           fontStyle: FontStyle.normal,
//           //         ),
//           //       ),
//           //     ),
//           //   ),
//           // ),
//         ],
//       ),
//       bottomNavigationBar: BottomNavBar(
//         selectedIndex: _selectedIndex,
//         onItemTapped: _onItemTapped,
//       ),
//     );
//   }
// }

// // class NewWidget extends StatefulWidget {
// //   @override
// //   _NewWidgetState createState() => _NewWidgetState();
// // }

// // class _NewWidgetState extends State<NewWidget> {
// //   List<double> temperatureData = [];
// //   List<double> vibrationData = [];

//   // @override
//   // Widget build(BuildContext context) {
//   //   return Column(
//   //     crossAxisAlignment: CrossAxisAlignment.stretch,
//   //     children: [
//   //       Expanded(
//   //         child: LineChart(
//   //           data: temperatureData.map((temp) => [temp]).toList(),
//   //           legend: ['Temperature'],
//   //           chartType: ChartType.rtl,
//   //         ),
//   //       ),
//   //       Expanded(
//   //         child: LineChart(
//   //           data: vibrationData.map((vib) => [vib]).toList(),
//   //           legend: ['Vibration'],
//   //           chartType: ChartType.rtl,
//   //         ),
//   //       ),
//   //       Expanded(
//   //         child: ListView.builder(
//   //           itemCount: temperatureData.length,
//   //           itemBuilder: (context, index) {
//   //             return ListTile(
//   //               title: Text('Temperature: ${temperatureData[index]}, Vibration: ${vibrationData[index]}'),
//   //             );
//   //           },
//   //         ),
//   //       ),
//   //     ],
//   //   );
//   // }

// //   @override
// //   void initState() {
// //     super.initState();
// //     fetchRealTimeData();
// //   }

// //   void fetchRealTimeData() {
// //     const int dataFetchInterval = 1000;
// //     const int dataPoints = 100;
// //     for (int i = 0; i < dataPoints; i++) {
// //       double temperature = 20 + (i / 10);
// //       double vibration = (i % 10) / 10;
// //       setState(() {
// //         temperatureData.add(temperature);
// //         vibrationData.add(vibration);
// //       });
// //       Future.delayed(Duration(milliseconds: dataFetchInterval * (i + 1)), () {});
// //     }
// //   }
// // }

// class BottNavBar {
//   final IconData icon;
//   final String label;

//   BottNavBar({required this.icon, required this.label});
// }

// // // ======================================EXTRA - 1(Imp.)===============================================

// // import 'package:flutter/material.dart';
// // // import 'package:syncfusion_flutter_charts/charts.dart';
// // import 'header.dart';
// // import 'images.dart';
// // import 'dart:convert';
// // import 'dart:io';
// // import 'dart:async';

// // class Monitor extends StatefulWidget {
// //   Monitor({Key? key}) : super(key: key);

// //   @override
// //   _MonitorState createState() => _MonitorState();
// // }

// // class _MonitorState extends State<Monitor> {
// //   // Define bottom navigation items
// //   final List<BottNavBar> bottomNavigationBarItems = [
// //     BottNavBar(icon: Icons.home, label: "Home"),
// //     BottNavBar(icon: Icons.add_chart, label: "Graph"),
// //     BottNavBar(icon: Icons.notifications, label: "Notification"),
// //     BottNavBar(icon: Icons.account_circle, label: "Profile")
// //   ];

// //   late List<double> temperatureData;
// //   late List<double> vibrationData;
// //   late WebSocket _socket;

// //   @override
// //   void initState() {
// //     super.initState();
// //     temperatureData = [];
// //     vibrationData = [];
// //     _initSocketConnection();
// //   }

// //   void _initSocketConnection() async {
// //     try {
// //       _socket = await WebSocket.connect('ws://your_socket_url_here');
// //       _socket.listen((message) {
// //         var data = jsonDecode(message);
// //         setState(() {
// //           temperatureData.add(data['temperature']);
// //           vibrationData.add(data['vibration']);
// //         });
// //       });
// //     } catch (e) {
// //       print('Error: $e');
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: const Color(0xffffffff),
// //       body: Column(
// //         mainAxisAlignment: MainAxisAlignment.start,
// //         crossAxisAlignment: CrossAxisAlignment.center,
// //         mainAxisSize: MainAxisSize.max,
// //         children: [
// //           const GearCareHeader(),
// //           Expanded(
// //             child: SingleChildScrollView(
// //               child: Column(
// //                 mainAxisAlignment: MainAxisAlignment.start,
// //                 crossAxisAlignment: CrossAxisAlignment.center,
// //                 mainAxisSize: MainAxisSize.max,
// //                 children: [
// //                   Padding(
// //                     padding: EdgeInsets.fromLTRB(28, 0, 28, 8),
// //                     child: Row(
// //                       mainAxisAlignment: MainAxisAlignment.start,
// //                       crossAxisAlignment: CrossAxisAlignment.center,
// //                       mainAxisSize: MainAxisSize.max,
// //                       children: [
// //                         Text(
// //                           "Gear Number: ",
// //                           textAlign: TextAlign.start,
// //                           overflow: TextOverflow.clip,
// //                           style: TextStyle(
// //                             fontWeight: FontWeight.w400,
// //                             fontStyle: FontStyle.normal,
// //                             fontSize: 24,
// //                             color: Color(0xff000000),
// //                           ),
// //                         ),
// //                         Expanded(
// //                           flex: 1,
// //                           child: TextField(
// //                             controller: TextEditingController(),
// //                             readOnly: true,
// //                             obscureText: false,
// //                             textAlign: TextAlign.start,
// //                             maxLines: 1,
// //                             style: TextStyle(
// //                               fontWeight: FontWeight.w400,
// //                               fontStyle: FontStyle.normal,
// //                               fontSize: 20,
// //                               color: Color(0xff000000),
// //                             ),
// //                             decoration: InputDecoration(
// //                               disabledBorder: OutlineInputBorder(
// //                                 borderRadius: BorderRadius.circular(8.0),
// //                                 borderSide: BorderSide(color: Colors.blue, width: 1),
// //                               ),
// //                               focusedBorder: OutlineInputBorder(
// //                                 borderRadius: BorderRadius.circular(8.0),
// //                                 borderSide: BorderSide(color: Colors.blue, width: 1),
// //                               ),
// //                               enabledBorder: OutlineInputBorder(
// //                                 borderRadius: BorderRadius.circular(8.0),
// //                                 borderSide: BorderSide(color: Colors.blue, width: 1),
// //                               ),
// //                               filled: true,
// //                               fillColor: Colors.white,
// //                               isDense: true,
// //                               contentPadding: EdgeInsets.fromLTRB(12, 8, 12, 8),
// //                             ),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                   Expanded(
// //                     child: SingleChildScrollView(
// //                       child: Column(
// //                         mainAxisAlignment: MainAxisAlignment.start,
// //                         crossAxisAlignment: CrossAxisAlignment.center,
// //                         mainAxisSize: MainAxisSize.max,
// //                         children: [
// //                           GridView.count(
// //                             padding: EdgeInsets.fromLTRB(28, 8, 28, 8),
// //                             shrinkWrap: true,
// //                             crossAxisCount: 1,
// //                             crossAxisSpacing: 16,
// //                             mainAxisSpacing: 16,
// //                             childAspectRatio: 2.0, // Make image rectangular
// //                             children: List.generate(1, (index) {
// //                               // Generate your sample images here
// //                               return Container(
// //                                 decoration: BoxDecoration(
// //                                   color: Colors.lightBlueAccent,
// //                                   borderRadius: BorderRadius.circular(8), // Round edges
// //                                 ),
// //                                 child: Center(
// //                                   child: Text(
// //                                     "Image $index",
// //                                     style: TextStyle(fontSize: 20),
// //                                   ),
// //                                 ),
// //                               );
// //                             }),
// //                           ),
// //                           SizedBox(height: 80,),
// //                           NewWidget(), // Add new.dart here
// //                         ],
// //                       ),
// //                     ),
// //                   ),
// //                   SizedBox(
// //                     width: double.infinity,
// //                     child: Padding(
// //                       padding: const EdgeInsets.fromLTRB(28, 0, 28, 10),
// //                       child: MaterialButton(
// //                         onPressed: () {
// //                           // Navigate to the Images screen
// //                           Navigator.push(
// //                             context,
// //                             MaterialPageRoute(builder: (context) => Images()),
// //                           );
// //                         },
// //                         color: const Color(0xff3a57e8),
// //                         elevation: 0,
// //                         shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(10.0),
// //                         ),
// //                         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
// //                         textColor: const Color(0xffffffff),
// //                         height: 50,
// //                         // Width is auto (responsive) due to Expanded widget
// //                         child: const Text(
// //                           "Next",
// //                           style: TextStyle(
// //                             fontSize: 16,
// //                             fontWeight: FontWeight.w700,
// //                             fontStyle: FontStyle.normal,
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //       bottomNavigationBar: BottomNavigationBar(
// //         items: bottomNavigationBarItems
// //             .map((item) => BottomNavigationBarItem(
// //           icon: Icon(item.icon),
// //           label: item.label,
// //         ))
// //             .toList(),
// //         backgroundColor: const Color(0xffffffff),
// //         currentIndex: 0,
// //         elevation: 8,
// //         iconSize: 24,
// //         selectedItemColor: const Color(0xff3a57e8),
// //         unselectedItemColor: const Color(0xff9e9e9e),
// //         selectedFontSize: 14,
// //         unselectedFontSize: 14,
// //         showSelectedLabels: true,
// //         showUnselectedLabels: true,
// //         onTap: (value) {},
// //       ),
// //     );
// //   }
// // }

// // class NewWidget extends StatefulWidget {
// //   @override
// //   _NewWidgetState createState() => _NewWidgetState();
// // }

// // class _NewWidgetState extends State<NewWidget> {
// //   List<double> temperatureData = [];
// //   List<double> vibrationData = [];

// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.stretch,
// //       children: [
// //         // Expanded(
// //         //   child: LineChart(
// //         //     data: temperatureData.map((temp) => [temp]).toList(),
// //         //     legend: ['Temperature'],
// //         //     chartType: ChartType.rtl,
// //         //   ),
// //         // ),
// //         // Expanded(
// //         //   child: LineChart(
// //         //     data: vibrationData.map((vib) => [vib]).toList(),
// //         //     legend: ['Vibration'],
// //         //     chartType: ChartType.rtl,
// //         //   ),
// //         // ),
// //         // Expanded(
// //         //   child: ListView.builder(
// //         //     itemCount: temperatureData.length,
// //         //     itemBuilder: (context, index) {
// //         //       return ListTile(
// //         //         title: Text('Temperature: ${temperatureData[index]}, Vibration: ${vibrationData[index]}'),
// //         //       );
// //         //     },
// //         //   ),
// //         // ),
// //       ],
// //     );
// //   }

// //   @override
// //   void initState() {
// //     super.initState();
// //     fetchRealTimeData();
// //   }

// //   void fetchRealTimeData() {
// //     const int dataFetchInterval = 1000;
// //     const int dataPoints = 100;
// //     for (int i = 0; i < dataPoints; i++) {
// //       double temperature = 20 + (i / 10);
// //       double vibration = (i % 10) / 10;
// //       setState(() {
// //         temperatureData.add(temperature);
// //         vibrationData.add(vibration);
// //       });
// //       Future.delayed(Duration(milliseconds: dataFetchInterval * (i + 1)), () {});
// //     }
// //   }
// // }

// // class BottNavBar {
// //   final IconData icon;
// //   final String label;

// //   BottNavBar({required this.icon, required this.label});
// // }


// // // ======================================EXTRA - 2===============================================

// // // import 'package:flutter/material.dart';
// // // import 'package:syncfusion_flutter_charts/charts.dart';
// // // import 'header.dart';
// // // import 'images.dart';
// // // import 'dart:convert';
// // // import 'dart:io';
// // // import 'dart:async';

// // // class Monitor extends StatefulWidget {
// // //   Monitor({Key? key}) : super(key: key);

// // //   @override
// // //   _MonitorState createState() => _MonitorState();
// // // }

// // // class _MonitorState extends State<Monitor> {
// // //   // Define bottom navigation items
// // //   final List<BottNavBar> bottomNavigationBarItems = [
// // //     BottNavBar(icon: Icons.home, label: "Home"),
// // //     BottNavBar(icon: Icons.add_chart, label: "Graph"),
// // //     BottNavBar(icon: Icons.notifications, label: "Notification"),
// // //     BottNavBar(icon: Icons.account_circle, label: "Profile")
// // //   ];

// // //   late List<double> temperatureData;
// // //   late List<double> vibrationData;
// // //   late WebSocket _socket;

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     temperatureData = [];
// // //     vibrationData = [];
// // //     _initSocketConnection();
// // //   }

// // //   void _initSocketConnection() async {
// // //     try {
// // //       _socket = await WebSocket.connect('ws://your_socket_url_here');
// // //       _socket.listen((message) {
// // //         var data = jsonDecode(message);
// // //         setState(() {
// // //           temperatureData.add(data['temperature']);
// // //           vibrationData.add(data['vibration']);
// // //         });
// // //       });
// // //     } catch (e) {
// // //       print('Error: $e');
// // //     }
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       backgroundColor: const Color(0xffffffff),
// // //       body: Column(
// // //         mainAxisAlignment: MainAxisAlignment.start,
// // //         crossAxisAlignment: CrossAxisAlignment.center,
// // //         mainAxisSize: MainAxisSize.max,
// // //         children: [
// // //           const GearCareHeader(),
// // //           Expanded(
// // //             child: ListView.builder(
// // //               itemCount: temperatureData.length,
// // //               itemBuilder: (context, index) {
// // //                 return ListTile(
// // //                   title: Text(
// // //                       'Temperature: ${temperatureData[index]}, Vibration: ${vibrationData[index]}'),
// // //                 );
// // //               },
// // //             ),
// // //           ),
// // //           SizedBox(
// // //             width: double.infinity,
// // //             child: Padding(
// // //               padding: const EdgeInsets.fromLTRB(28, 0, 28, 10),
// // //               child: MaterialButton(
// // //                 onPressed: () {
// // //                   // Navigate to the Images screen
// // //                   Navigator.push(
// // //                     context,
// // //                     MaterialPageRoute(builder: (context) => Images()),
// // //                   );
// // //                 },
// // //                 color: const Color(0xff3a57e8),
// // //                 elevation: 0,
// // //                 shape: RoundedRectangleBorder(
// // //                   borderRadius: BorderRadius.circular(10.0),
// // //                 ),
// // //                 padding:
// // //                     const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
// // //                 textColor: const Color(0xffffffff),
// // //                 height: 50,
// // //                 // Width is auto (responsive) due to Expanded widget
// // //                 child: const Text(
// // //                   "Next",
// // //                   style: TextStyle(
// // //                     fontSize: 16,
// // //                     fontWeight: FontWeight.w700,
// // //                     fontStyle: FontStyle.normal,
// // //                   ),
// // //                 ),
// // //               ),
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //       bottomNavigationBar: BottomNavigationBar(
// // //         items: bottomNavigationBarItems
// // //             .map((item) => BottomNavigationBarItem(
// // //                   icon: Icon(item.icon),
// // //                   label: item.label,
// // //                 ))
// // //             .toList(),
// // //         backgroundColor: const Color(0xffffffff),
// // //         currentIndex: 0,
// // //         elevation: 8,
// // //         iconSize: 24,
// // //         selectedItemColor: const Color(0xff3a57e8),
// // //         unselectedItemColor: const Color(0xff9e9e9e),
// // //         selectedFontSize: 14,
// // //         unselectedFontSize: 14,
// // //         showSelectedLabels: true,
// // //         showUnselectedLabels: true,
// // //         onTap: (value) {},
// // //       ),
// // //     );
// // //   }
// // // }

// // // class BottNavBar {
// // //   final IconData icon;
// // //   final String label;

// // //   BottNavBar({required this.icon, required this.label});
// // // }
