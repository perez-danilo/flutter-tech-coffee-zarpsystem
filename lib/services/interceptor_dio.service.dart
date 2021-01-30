import 'package:dio/dio.dart';
import 'package:techapp/utils/app_settings.dart';

class ApiInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) {
    options.headers["app-id"] = AppSettings.APIKEY;
    return super.onRequest(options);
  }

  @override
  onResponse(Response response) {
    print("response");
    return super.onResponse(response);
  }

  @override
  onError(DioError error) {
    return super.onError(error);
  }
}
