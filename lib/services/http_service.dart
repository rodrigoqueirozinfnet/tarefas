import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class HttpService {
  late final Dio _dio;

  HttpService._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: 'https://api.open-meteo.com/',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      headers: {'Content-Type': 'application/json'},
    );

    _dio = Dio(options);

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (kDebugMode) {
            print('➡️ ${options.method} ${options.uri}');
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          if (kDebugMode) {
            print('✅ ${response.statusCode} ${response.data}');
          }
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          if (kDebugMode) {
            print('❌ ERROR[${e.response?.statusCode}]: ${e.message}');
          }
          return handler.next(e);
        },
      ),
    );
  }

  static final HttpService _instance = HttpService._internal();

  factory HttpService() => _instance;

  Future<Response> get(String path, {Map<String, dynamic>? queryParams}) async {
    try {
      return await _dio.get(path, queryParameters: queryParams);
    } catch (e) {
      rethrow;
    }
  }
}
