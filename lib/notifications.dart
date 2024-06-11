import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gear_care/bottnavbar.dart';
import 'package:gear_care/dashboard1.dart';
import 'package:gear_care/header.dart';
import 'package:gear_care/monitor.dart';
import 'package:gear_care/profile.dart';
import 'package:timezone/timezone.dart' as tz;
import 'dart:async';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  int _selectedIndex = 2;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  List<NotificationItem> notifications = [];
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    initializeNotifications();
    startServiceNotifier();
    // Start the auto-refresh timer
    _timer = Timer.periodic(const Duration(seconds: 0), (timer) {
      setState(() {
        updateNotificationsTimestamps();
      });
    });
  }

  @override
  void dispose() {
    // Dispose the timer when the widget is removed from the tree
    _timer.cancel();
    super.dispose();
  }

  void initializeNotifications() {
    // Initialize the plugin
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // Configure the initialization settings
    var initializationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(android: initializationSettingsAndroid);

    // Initialize the plugin with the initialization settings
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void scheduleNotification(ServiceItem service) async {
    // Schedule the notification
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Service Due',
      'Your ${service.title} service is due soon!',
      tz.TZDateTime.from(service.dueDate, tz.local).subtract(const Duration(days: 7)),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'your channel name',
          'your channel description',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  void startServiceNotifier() {
    // For demonstration purposes, let's assume we have a list of services with their due dates
    List<ServiceItem> services = [
      // List of services
      ServiceItem(title: 'Serial No. 12345', dueDate: DateTime.now().add(const Duration(days: 12))),
      ServiceItem(title: 'Serial No. 23456', dueDate: DateTime.now().add(const Duration(days: 14))),
      ServiceItem(title: 'Serial No. 34567', dueDate: DateTime.now().add(const Duration(days: 2))),
      ServiceItem(title: 'Serial No. 45678', dueDate: DateTime.now().add(const Duration(days: 14))),
      ServiceItem(title: 'Serial No. 56789', dueDate: DateTime.now().add(const Duration(days: 4))),
      ServiceItem(title: 'Serial No. 67890', dueDate: DateTime.now().add(const Duration(days: 8))),
      ServiceItem(title: 'Serial No. 78901', dueDate: DateTime.now().add(const Duration(days: 1))),
      ServiceItem(title: 'Serial No. 89012', dueDate: DateTime.now().add(const Duration(days: 16))),
      ServiceItem(title: 'Serial No. 90123', dueDate: DateTime.now().add(const Duration(days: 0, hours: 4, minutes: 10))),
    ];

    // Schedule notifications for services due within a week
    for (var service in services) {
      if (service.dueDate.isBefore(DateTime.now().add(const Duration(days: 7)))) {
        scheduleNotification(service);
        notifications.add(NotificationItem(
          message: '${service.title} - Maintenance Due!',
          timeStamp: getTimeStamp(service.dueDate),
          dueDate: service.dueDate,
        ));
      }
    }
  }

  String getTimeStamp(DateTime dueDate) {
    Duration difference = DateTime.now().difference(dueDate).abs(); // Get absolute difference
    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} secs ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} mins ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hrs ago';
    } else {
      return '${difference.inDays} days ago';
    }
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
      } else if (_selectedIndex == 1) {
        // Navigate to Monitor page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Monitor()),
        );
      } else if (_selectedIndex == 2) {
        // Currently we are in the Notification page
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
                "Notifications",
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 28),
              child: ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        leading: const Icon(Icons.notifications_active, color: Colors.blue, size: 32,),
                        title: Text(
                          notifications[index].message,
                          style: const TextStyle(fontSize: 18),
                        ),
                        subtitle: Text(
                          notifications[index].timeStamp,
                          style: const TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ),
                    ),
                  );
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

  void updateNotificationsTimestamps() {
    setState(() {
      notifications.sort((a, b) {
        // Convert the time stamps to Duration objects for comparison
        Duration aDuration = convertTimeStampToDuration(a.timeStamp);
        Duration bDuration = convertTimeStampToDuration(b.timeStamp);
        // Compare the durations to determine the order
        return aDuration.compareTo(bDuration);
      });
      for (var notification in notifications) {
        notification.timeStamp = getTimeStamp(notification.dueDate);
      }
    });
  }

  Duration convertTimeStampToDuration(String timeStamp) {
    // Extract the numeric value and unit from the time stamp
    int value = int.parse(timeStamp.split(' ')[0]);
    String unit = timeStamp.split(' ')[1];
    // Convert the unit to seconds for comparison
    switch (unit) {
      case 'secs':
        return Duration(seconds: value);
      case 'mins':
        return Duration(minutes: value);
      case 'hrs':
        return Duration(hours: value);
      case 'days':
        return Duration(days: value);
      default:
        return const Duration(seconds: 0); // Default case
    }
  }
}

class ServiceItem {
  final String title;
  final DateTime dueDate;

  ServiceItem({required this.title, required this.dueDate});
}

class NotificationItem {
  String message;
  String timeStamp;
  DateTime dueDate;

  NotificationItem({required this.message, required this.timeStamp, required this.dueDate});
}
