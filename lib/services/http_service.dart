

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class HttpService {
  late final Dio _dio;

  HttpService._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: 'https://api.open-meteo.com/',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      headers: {
        'Content-Type': 'application/json',
      },
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
        onError: (DioError e, handler) {
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

  Future<Response> post(String path, {dynamic data}) async {
    try {
      return await _dio.post(path, data: data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> put(String path, {dynamic data}) async {
    try {
      return await _dio.put(path, data: data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete(String path, {dynamic data}) async {
    try {
      return await _dio.delete(path, data: data);
    } catch (e) {
      rethrow;
    }
  }

  // Caso precise alterar o token dinamicamente
  void setToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }
}
