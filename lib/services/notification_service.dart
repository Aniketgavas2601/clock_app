import 'dart:developer';

import 'package:clock_app/main.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
class NotificationService{
  static void showNotification() async {
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        "Notifications-alarm",
        "Alarm Notification",
      priority: Priority.max,
      importance: Importance.max
    );

    DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,

    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosDetails
    );
    
    //await flutterLocalNotificationsPlugin.show(0, "sampleNotification", "Alarm is set", notificationDetails);
    DateTime scheduleDate = DateTime.now().add(Duration(seconds: 5));
    //await flutterLocalNotificationsPlugin.schedule(0, "sampleNotification",  "Alarm is set", scheduleDate, notificationDetails);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0, 
        "sampleNotification", 
        "Alarm is set", 
        tz.TZDateTime.from(scheduleDate, tz.local),
        notificationDetails,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.wallClockTime,
        androidAllowWhileIdle: true,
      payload: "notification-payload"
    );
  }

  void checkForNotification() async {
    NotificationAppLaunchDetails? details = await notificationsPlugin.getNotificationAppLaunchDetails();

    if(details != null){
      if(details.didNotificationLaunchApp){
        NotificationResponse? response = details.notificationResponse;

        if(response != null){
          String? payload = response.payload;
          
          log("Notification payload: $payload");

        }
      }
    }
  }
}