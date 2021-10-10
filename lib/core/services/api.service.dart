import 'package:dio/dio.dart';
import 'package:igor/core/Helpers/Cosntants.dart';

class ApiService {
  late Dio _dio;

  static final ApiService _api = ApiService._();

  factory ApiService() {
    return _api;
  }

  ApiService._() {
    _dio = Dio(
      BaseOptions(
        baseUrl: Constants.END_POINTS,
        // If Auth is needed
        headers: {"authentication": ""},
      ),
    );
  }

  Future<T?> get<T>(
      {required String url, Map<String, dynamic> headers = const {}}) async {
    return (await _dio.get<T>(url, options: Options(headers: headers))).data;
  }

  Future<T?> delete<T>(
      {required String url, Map<String, dynamic> headers = const {}}) async {
    return (await _dio.delete<T>(url, options: Options(headers: headers))).data;
  }

  Future<T?> patch<T>(
      {required String url,
      Map<String, dynamic> headers = const {},
      required Map<String, dynamic> data}) async {
    return (await _dio.patch<T>(url,
            data: data, options: Options(headers: headers)))
        .data;
  }
}
