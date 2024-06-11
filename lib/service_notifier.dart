import 'package:flutter/material.dart';
import 'package:gear_care/bottnavbar.dart';
import 'package:gear_care/header.dart';
import 'package:gear_care/monitor.dart';
import 'package:gear_care/notifications.dart';
import 'package:gear_care/profile.dart';

class Service extends StatefulWidget {
  const Service({super.key});

  @override
  ServiceState createState() => ServiceState();
}

class ServiceState extends State<Service> {
  int _selectedIndex = 0;
  
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 0) {
        // Currently we are in the Dashboard page
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
      body: const Column(
        children: [
          GearCareHeader(),
          Padding(
            padding: EdgeInsets.fromLTRB(28, 0, 28, 0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Service Notifier",
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
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 28),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 16,
                    width: 16,
                  ),
                  // Display notifications here
                  // for (String notification in notifications)
                  //   ListTile(
                  //     title: Text(
                  //       notification,
                  //       style: TextStyle(fontSize: 18),
                  //     ),
                  //   ),
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

class ServiceItem {
  final String title;
  final DateTime dueDate;

  ServiceItem({required this.title, required this.dueDate});
}


// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:gear_care/bottnavbar.dart';
// import 'package:gear_care/header.dart';
// import 'package:gear_care/monitor.dart';
// import 'package:gear_care/notifications.dart';
// import 'package:gear_care/profile.dart';
// import 'package:timezone/timezone.dart' as tz;

// class Service extends StatefulWidget {
//   const Service({super.key});

//   @override
//   ServiceState createState() => ServiceState();
// }

// class ServiceState extends State<Service> {
//   int _selectedIndex = 0;
//   late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

//   @override
//   void initState() {
//     super.initState();
//     initializeNotifications();
//     startServiceNotifier();
//   }

//   void initializeNotifications() {
//     // Initialize the plugin
//     flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//     // Configure the initialization settings
//     var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
//     // var initializationSettingsIOS = IOSInitializationSettings(); // Corrected
//     var initializationSettings = InitializationSettings(
//     android: initializationSettingsAndroid,
//     // iOS: initializationSettingsIOS,
//   );

//     // Initialize the plugin with the initialization settings
//     flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }

//   void scheduleNotification(ServiceItem service) async {
//   // Create the notification details
//   var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//     // 'your channel id', // Update with your channel id
//     'your channel name',
//     'your channel description',
//     importance: Importance.max,
//     priority: Priority.high,
//   );

//     // Correct the usage of IOSNotificationDetails
//     // var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//     var platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//       // iOS: iOSPlatformChannelSpecifics,
//     );

//     // Schedule the notification
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       0,
//       'Service Due',
//       'Your ${service.title} service is due soon!',
//       tz.TZDateTime.from(service.dueDate, tz.local).subtract(const Duration(days: 7)), // Convert DateTime to TZDateTime
//       platformChannelSpecifics,
//       androidAllowWhileIdle: true,
//       uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
//       matchDateTimeComponents: DateTimeComponents.time,
//     );
//   }

//   void startServiceNotifier() {
//     // You can implement your logic here to fetch services and schedule notifications
//     // For demonstration purposes, let's assume we have a list of services with their due dates
//     List<ServiceItem> services = [
//       ServiceItem(title: 'Service 1', dueDate: DateTime.now().add(const Duration(days: 5))),
//       ServiceItem(title: 'Service 2', dueDate: DateTime.now().add(const Duration(days: 8))),
//       ServiceItem(title: 'Service 3', dueDate: DateTime.now().add(const Duration(days: 6))),
//     ];

//     // Schedule notifications for services due within a week
//     for (var service in services) {
//       if (service.dueDate.isBefore(DateTime.now().add(const Duration(days: 7)))) {
//         scheduleNotification(service);
//       }
//     }
//   }

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//       if (_selectedIndex == 0) {
//         // Currently we are in the Dashboard page
//       } else if (_selectedIndex == 1) {
//         // Navigate to Monitor page
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const Monitor()),
//         );
//       } else if (_selectedIndex == 2) {
//         // Navigate to Notification page
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
//         children: [
//           GearCareHeader(),
//           Padding(
//             padding: const EdgeInsets.fromLTRB(28, 0, 28, 0),
//             child: Align(
//               alignment: Alignment.center,
//               child: Text(
//                 "Service Notifier",
//                 textAlign: TextAlign.start,
//                 overflow: TextOverflow.clip,
//                 style: TextStyle(
//                   fontWeight: FontWeight.w500,
//                   fontStyle: FontStyle.normal,
//                   fontSize: 28,
//                   color: const Color(0xff000000),
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 28),
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisSize: MainAxisSize.max,
//                 children: [
//                   SizedBox(
//                     height: 16,
//                     width: 16,
//                   ),
//                   // Display notifications here
//                   // for (String notification in widget.notifications)
//                   //   ListTile(
//                   //     title: Text(
//                   //       notification,
//                   //       style: TextStyle(fontSize: 18),
//                   //     ),
//                   //   ),
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

// class ServiceItem {
//   final String title;
//   final DateTime dueDate;

//   ServiceItem({required this.title, required this.dueDate});
// }

// =====================================================================

// import 'package:flutter/material.dart';
// import 'package:gear_care/bottnavbar.dart';
// import 'package:gear_care/header.dart';
// import 'package:gear_care/monitor.dart';
// import 'package:gear_care/notifications.dart';
// import 'package:gear_care/profile.dart';

// class Service extends StatefulWidget {
//   const Service({super.key});


//   @override
//   ServiceState createState() => ServiceState();
// }

// class ServiceState extends State<Service> {
//   int _selectedIndex = 0;

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//       if (_selectedIndex == 0) {
//         // Currently we are in the Dashboard page
//       } else if (_selectedIndex == 1) {
//         // Navigate to Monitor page
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const Monitor()),
//         );
//       } else if (_selectedIndex == 2) {
//         // Navigate to Notification page
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) =>const Notifications()),
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
//       body: const Column(
//         children: [
//           GearCareHeader(),
//           Padding(
//             padding: EdgeInsets.fromLTRB(28, 0, 28, 0),
//             child: Align(
//               alignment: Alignment.center,
//               child: Text(
//                 "Service Notifier",
//                 textAlign: TextAlign.start,
//                 overflow: TextOverflow.clip,
//                 style: TextStyle(
//                   fontWeight: FontWeight.w500,
//                   fontStyle: FontStyle.normal,
//                   fontSize: 28,
//                   color: Color(0xff000000),
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(vertical: 0, horizontal: 28),
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisSize: MainAxisSize.max,
//                 children: [
//                   SizedBox(
//                     height: 16,
//                     width: 16,
//                   ),
//                   // Display notifications here
//                   // for (String notification in widget.notifications)
//                   //   ListTile(
//                   //     title: Text(
//                   //       notification,
//                   //       style: TextStyle(fontSize: 18),
//                   //     ),
//                   //   ),
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
