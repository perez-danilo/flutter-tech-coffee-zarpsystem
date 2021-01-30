import 'package:dio/dio.dart';
import '../utils/app_settings.dart';
import 'interceptor_dio.service.dart';

class ApiDio {
  Dio dio;
  ApiDio() {
    dio = Dio();
    dio.options.baseUrl = AppSettings.URL;
    dio.interceptors.add(ApiInterceptor());
  }
}
