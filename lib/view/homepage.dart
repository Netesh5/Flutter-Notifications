import 'package:flutter/material.dart';
import 'package:notificationdemo/services/notification_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NotificationServices _services = NotificationServices();
  @override
  void initState() {
    super.initState();
    _services.requestNotification();
    _services.firebaseInit(context);
    _services.interactMessage(context);
    // _services.refreshToken();
    _services.getDeviceToken().then((value) => debugPrint(value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Notification"),
      ),
    );
  }
}
