// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notificationdemo/view/message_screen.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void requestNotification() async {
    NotificationSettings settings = await messaging.requestPermission(
        criticalAlert: true, provisional: true, announcement: true);
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint("User granted permission");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint("User granted provisional permission");
    } else {
      debugPrint("User denied permission");
    }
  }

  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  void initLocalNotification(BuildContext context, RemoteMessage message) {
    FirebaseMessaging.onMessage.listen((event) async {
      var androidIntializationSetting =
          const AndroidInitializationSettings('@mipmap/ic_launcher');
      var iosIntializationSetting = const DarwinInitializationSettings();

      var initializationSettings = InitializationSettings(
          android: androidIntializationSetting, iOS: iosIntializationSetting);
      await localNotificationsPlugin.initialize(initializationSettings,
          onDidReceiveNotificationResponse: (payload) {
        handleMessage(context, message);
      });
    });
  }

  Future<void> firebaseInit(BuildContext context) async {
    FirebaseMessaging.onMessage.listen((event) {
      if (Platform.isAndroid) {
        initLocalNotification(context, event);
        showNotification(event);
      } else {
        showNotification(event);
      }
    });
  }

  void showNotification(RemoteMessage message) {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        Random.secure().nextInt(1000).toString(), "High Importance",
        importance: Importance.max);

    AndroidNotificationDetails details = AndroidNotificationDetails(
        channel.id, channel.name,
        channelDescription: "Channel Description",
        importance: Importance.high,
        priority: Priority.high,
        ticker: 'ticker');

    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
            presentSound: true, presentAlert: true, presentBadge: true);

    NotificationDetails notificationDetails =
        NotificationDetails(android: details, iOS: darwinNotificationDetails);

    Future.delayed(Duration.zero, () {
      localNotificationsPlugin.show(0, message.notification!.title.toString(),
          message.notification!.body.toString(), notificationDetails);
    });
  }

  void refreshToken() {
    messaging.onTokenRefresh.listen((event) {
      debugPrint("Refresh");
    });
  }

  void handleMessage(BuildContext context, RemoteMessage message) {
    if (message.data["type"] == "test") {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const MessageScreen()));
    }
  }

  Future<void> interactMessage(BuildContext context) async {
    //Background and terminate state
    //when app is terminated
    RemoteMessage? message =
        await FirebaseMessaging.instance.getInitialMessage();
    if (message != null) {
      handleMessage(context, message);
    }

    //when app is in background state
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessage(context, event);
    });
  }
}
