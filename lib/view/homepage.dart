import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notificationdemo/data/respository/notification_repo.dart';
import 'package:notificationdemo/services/notification_services.dart';
import 'package:notificationdemo/utils/snackbar.dart';
import 'package:notificationdemo/view/widgets/textform_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NotificationServices _services = NotificationServices();

  late final TextEditingController titleController;
  late final TextEditingController bodyController;

  final titleFormKey = GlobalKey<FormState>();
  final bodyFormKey = GlobalKey<FormState>();
  final NotificationRepo _notificationRepo = NotificationRepo();
  @override
  void initState() {
    super.initState();
    _services.requestNotification();
    _services.firebaseInit(context);
    _services.interactMessage(context);
    // _services.refreshToken();
    _services.getDeviceToken().then((value) => debugPrint(value));

    titleController = TextEditingController();
    bodyController = TextEditingController();
  }

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Notification"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextFormField(
                controller: titleController,
                formkey: titleFormKey,
                hintText: "Enter the Title",
              ),
              const SizedBox(
                height: 25,
              ),
              CustomTextFormField(
                controller: bodyController,
                formkey: bodyFormKey,
                hintText: "Enter the Body",
              ),
              const SizedBox(
                height: 25,
              ),
              CupertinoButton(
                  color: Colors.deepPurpleAccent,
                  child: const Text("Send Notifications"),
                  onPressed: () {
                    _notificationRepo
                        .sendNotification(
                            titleController.text, bodyController.text)
                        .then((value) => showSnackBar(
                            context, "Notification sent successfully"));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
