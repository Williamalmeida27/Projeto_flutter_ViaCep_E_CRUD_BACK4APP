import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'back4_app_interpectors.dart';

class DioCustom {
  var _dio = Dio();

  get dio => _dio;

  DioCustom() {
    _dio.options.headers["Content-Type"] = "application/json";
    _dio.options.baseUrl = dotenv.get("BASEURL");
    _dio.interceptors.add(Back4AppInterceptors());
  }
}
