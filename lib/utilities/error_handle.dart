import 'dart:async';
import 'dart:io';

import 'package:todoapp/utilities/my_response.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';

class ErrorHandle {
  static MyResponse<dynamic> errorHandler(Object e) {
    if (e is SocketException){
      return MyResponse.makeAppConnectionError("No Connection to server found.");
    } else if( e is TimeoutException){
      return MyResponse.makeAppConnectionError("Connection to server timed out");
    } else if (e is FormatException) {
      return MyResponse.makeAppConnectionError("Something wrong on our part. Let us know about this and we will sort it out.");
    } else if (e is UnAuthorizedException){
      return MyResponse.makeAppConnectionError(e.cause);
    } else if (e is BadRequestException){
      return MyResponse.makeAppConnectionError(e.cause);
    } else if (e is ForbiddenException){
      return MyResponse.makeAppConnectionError(e.cause);
    } else if (e is ServerException){
      return MyResponse.makeAppConnectionError(e.cause);
    } else {
      return MyResponse.makeAppConnectionError(e.toString());
    }

  }


}

class UnAuthorizedException implements Exception {
  String cause;
  UnAuthorizedException(this.cause);
}

class BadRequestException implements Exception {
  String cause;
  BadRequestException(this.cause);
}

class ForbiddenException implements Exception {
  String cause;
  ForbiddenException(this.cause);
}

class ServerException implements Exception {
  String cause;
  ServerException(this.cause);
}