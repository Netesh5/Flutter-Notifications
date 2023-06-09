import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:notificationdemo/network/dio_instance.dart';
import 'package:notificationdemo/utils/snackbar.dart';

class NotificationRepo {
  DioInstance dioInstance = DioInstance();

  Future<void> sendNotification(
      BuildContext context, String title, String body) async {
    try {
      await dioInstance.getDio.post(
        "/send",
        data: {
          'to':
              "cJiniL0qReu9OROHRs5Gaf:APA91bHGXTB9pM6xEvDZHnQ34hKm6CfNgKs1X-zUC3FzEi4OnlDg3ePWkckDD5hpf1HW_3NL7kobyc9D-8PDJH27hPcuamSGr5BnntinMrKLIOtjTFvqMLIj6vxbQwGdtYo1TMKympOy",
          'priority': 'high',
          'notification': {'title': title, 'body': body},
          'data': {'type': 'test', 'id': 1}
        },
      ).then((value) {
        debugPrint("Notification sent");
      });
    } on DioError catch (e) {
      showSnackBar(context, e.message!);
    }
  }
}
