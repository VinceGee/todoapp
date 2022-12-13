import 'dart:convert';

import 'package:todoapp/api/api_util.dart';
import 'package:todoapp/services/network.dart';
import 'package:todoapp/utilities/error_handle.dart';

class GlobalFunctions {
  static Future<Object> serverPostWithNoAuth(String _url, String _requestBody) async {
    try {
    NetworkResponse response = await Network.post(_url,
        headers: ApiUtil.getHeader(requestType: RequestType.Post),
        body: _requestBody);
print(response.body);
      switch (response.statusCode) {
        case 200:
          return response;
        case 400:
          throw BadRequestException("Bad Request");
        case 401:
          throw UnAuthorizedException("Unauthorized Access!");
        case 403:
          throw ForbiddenException("Forbidden Access!");
        case 500:
          throw ServerException("Please wait a few minutes before you try again.");
        default:
          throw Exception('Error occurred while Communication with Server.');
      }
    } catch (e) {
      return ErrorHandle.errorHandler(e);
    }
  }

  static Future<Object> serverPutWithNoAuth(String _url, String _requestBody) async {
    try {
    NetworkResponse response = await Network.put(_url,
        headers: ApiUtil.getHeader(requestType: RequestType.Post),
        body: _requestBody);

      switch (response.statusCode) {
        case 200:
          return response;
        case 400:
          throw BadRequestException("Bad Request");
        case 401:
          throw UnAuthorizedException("Unauthorized Access!");
        case 403:
          throw ForbiddenException("Forbidden Access!");
        case 500:
          throw ServerException("Please wait a few minutes before you try again.");
        default:
          throw Exception('Error occurred while Communication with Server.');
      }
    } catch (e) {
      return ErrorHandle.errorHandler(e);
    }
  }

  static Future<Object> serverDeleteWithNoAuth(String _url, String _requestBody) async {
    try {
    NetworkResponse response = await Network.delete(_url,
        headers: ApiUtil.getHeader(requestType: RequestType.Post),
        body: _requestBody);

      switch (response.statusCode) {
        case 200:
          return response;
        case 400:
          throw BadRequestException("Bad Request");
        case 401:
          throw UnAuthorizedException("Unauthorized Access!");
        case 403:
          throw ForbiddenException("Forbidden Access!");
        case 500:
          throw ServerException("Please wait a few minutes before you try again.");
        default:
          throw Exception('Error occurred while Communication with Server.');
      }
    } catch (e) {
      return ErrorHandle.errorHandler(e);
    }
  }

  static Future<Object> serverPostWithUrlEncode(String _url, Map _requestBody) async {
    try {
    NetworkResponse response = await Network.post(_url,
        headers: ApiUtil.getHeader(requestType: RequestType.PostUrlEncoded),
        body: _requestBody);

      switch (response.statusCode) {
        case 200:
          return response;
        case 400:
          throw BadRequestException("Bad Request");
        case 401:
          throw UnAuthorizedException(json.decode(response.body)["error_description"]);
        case 403:
          throw ForbiddenException("Forbidden Access!");
        case 500:
          throw ServerException("Please wait a few minutes before you try again.");
        default:
          throw Exception('Error occurred while Communication with Server.');
      }
    } catch (e) {
      return ErrorHandle.errorHandler(e);
    }
  }

  static Future<Object> serverGetWithNoAuth(String _url) async {
    try {
    NetworkResponse response = await Network.get(_url,
        headers: ApiUtil.getHeader(requestType: RequestType.Get));

      switch (response.statusCode) {
        case 200:
          return response;
        case 400:
          throw BadRequestException("Bad Request");
        case 401:
          throw UnAuthorizedException("Unauthorized Access!");
        case 403:
          throw ForbiddenException("Forbidden Access!");
        case 500:
          throw ServerException("Please wait a few minutes before you try again.");
        default:
          throw Exception('Error occurred while Communication with Server.');
      }
    } catch (e) {
      return ErrorHandle.errorHandler(e);
    }
  }
}
