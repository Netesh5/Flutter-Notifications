import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioInstance {
  final Dio _dio = Dio(BaseOptions(
      baseUrl: "https://fcm.googleapis.com/fcm",
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization':
            'key=AAAAgSnV2HA:APA91bG9kKTYuiUEq9adWqQPCHrTo4uTBOjwN5v4Jee6H0d_2zNlp-2Xmlp5oByDEK12D5hUTPprB9prQzFkhFzwbEbLO_Pn-F03LObXMITW7GpClJ_z_La5VmdGbAQj_8wmyCEFhYV-'
      }));

  DioInstance() {
    _dio.interceptors.add(PrettyDioLogger(requestHeader: true));
  }

  Dio get getDio => _dio;
}
