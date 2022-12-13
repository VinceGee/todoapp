import 'dart:async';
import 'dart:convert';

import 'package:todoapp/constants/app_defaults.dart';
import 'package:http/http.dart' as http;

class Network {
  static Future<NetworkResponse> post(String url,
      {required Map<String, String> headers, required Object body}) async {
      http.Response response = await http
          .post(Uri.parse(changeUrl(url)), headers: headers, body: body);

      return NetworkResponse(response.body, response.statusCode, baseResponse: response);
  }

  static Future<NetworkResponse> put(String url,
      {required Map<String, String> headers, required Object body}) async {
      http.Response response = await http
          .put(Uri.parse(changeUrl(url)), headers: headers, body: body);

      return NetworkResponse(response.body, response.statusCode, baseResponse: response);
  }

  static Future<NetworkResponse> delete(String url,
      {required Map<String, String> headers, required Object body}) async {
      http.Response response = await http
          .delete(Uri.parse(changeUrl(url)), headers: headers, body: body);

      return NetworkResponse(response.body, response.statusCode, baseResponse: response);
  }

  static Future<NetworkResponse> get(String url,
      {required Map<String, String> headers}) async {
      http.Response response = await http
          .get(
            Uri.parse(changeUrl(url)),
            headers: headers,
          );
      return NetworkResponse(response.body, response.statusCode,
          baseResponse: response);
  }
  //
  // static Future<NetworkResponse> delete(String url,
  //     {required Map<String, String> headers,
  //     required Object body,
  //     required Encoding encoding}) async {
  //   http.Response response = await http
  //       .delete(Uri.parse(changeUrl(url)), headers: headers);
  //
  //   return NetworkResponse(response.body, response.statusCode,
  //       baseResponse: response);
  // }

  static changeUrl(String url) {
    if (url[url.length - 1] == "/") return url.substring(0, url.length - 1);
    return url;
  }
}

class NetworkResponse {
  late String _body;
  late int _statusCode;
  late http.Response _baseResponse;

  NetworkResponse(String body, int statusCode,
      {required http.Response baseResponse}) {
    _body = body;
    _statusCode = statusCode;
    _baseResponse = baseResponse;
  }

  int get statusCode => _statusCode;

  String get body => _body;

  http.Response get baseResponse => _baseResponse;
}
