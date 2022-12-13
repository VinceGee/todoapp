

enum RequestType { Post, Get, PostWithAuth, GetWithAuth, PostUrlEncoded }

class ApiUtil {

  static const String BASE_URL = "http://todoapp.vokers.co.zw/";
  static const String MAIN_API_URL_PRODUCTION = "${BASE_URL}api/";

  //Main Url for production and testing
  static const String MAIN_API_URL = MAIN_API_URL_PRODUCTION;

  //------------------ Header ------------------------------//

  static Map<String, String> getHeader({RequestType requestType = RequestType.Get, String token = ""}) {
    switch (requestType) {
      case RequestType.Post:
        return {
          "Accept": "application/json",
          "Content-type": "application/json; charset=UTF-8",
        };
      case RequestType.Get:
        return {
          "Accept": "application/json",
        };
      case RequestType.PostWithAuth:
        return {
          "Accept": "application/json",
          "Content-type": "application/json; charset=UTF-8",
          "Authorization": "Bearer $token",
        };
      case RequestType.GetWithAuth:
        return {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        };
      case RequestType.PostUrlEncoded:
        return {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        };
    }
    //Not reachable
    return {"Accept": "application/json"};
  }

  // ----------------------  Body --------------------------//
  static Map<String, dynamic> getPatchRequestBody() {
    return {'_method': 'PATCH'};
  }

  //------------------- API LINKS ------------------------//

  static const String LOGIN = "login";
  static const String REGISTER = "register";

  static const String GET_TODOS = "todos/";
  static const String ADD_TASK = "todos";
  static const String UPDATE_TASK = "todos/";
  static const String DELETE_TASK = "todos/";


  //----------------- Redirects ----------------------------------//
  static void processException(int responseCode) {
    switch (responseCode) {
      case 400:
        throw Exception("Bad Request");
      case 401:
        throw Exception("Unauthorized Access!");
      case 403:
        throw Exception("Forbidden Access!");
      case 500:
      default:
        throw Exception(
            'Error occurred while communicating with the server with StatusCode : ${responseCode}');
    }
  }

  static const String SERVER_RESPONSE = "status";
  static const bool RESPONSE_BOOL_TRUE = true;
  static const bool RESPONSE_BOOL_FALSE = false;
  static const String SERVER_DEFAULT_ERROR = "Something went wrong";
  static const int BAD_REQUEST_CODE = 400;
  static const int INTERNET_NOT_AVAILABLE_CODE = 500;
  static const int SERVER_ERROR_CODE = 501;
  static const int MAINTENANCE_CODE = 503;
  static const int SUCCESS_CODE = 200;
  static const int ERROR_CODE = 400;
  static const int UNAUTHORIZED_CODE = 401;

}
