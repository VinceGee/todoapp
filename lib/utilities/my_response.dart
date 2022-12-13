
import 'package:todoapp/api/api_util.dart';
import 'package:nb_utils/nb_utils.dart';

class MyResponse<T> {
  bool success = false;
  T? data;
  List<dynamic> errors = [];
  String errorText = "";
  int responseCode;

  MyResponse(this.responseCode);

  setError(Map<String, dynamic> jsonObject) {
    String error = jsonObject['narrative'];
    if (error != null) {
      this.errors = [error];
      this.errorText = getFormattedError(this.errors);
      return;
    }
    List<dynamic> errors = jsonObject['errors'];
    if (errors != null) {
      this.errors = errors;
      this.errorText = getFormattedError(errors);
      return;
    }
    this.errorText = "Something wrong";
  }

  static String getFormattedError(List<dynamic> errors) {
    String errorText = "";
    for (int i = 0; i < errors.length; i++) {
      errorText += " " + errors[i] + (i + 1 < errors.length ? "\n" : "");
    }
    return errorText;
  }

  static MyResponse<T> makeBadRequestError<T>() {
    MyResponse<T> myResponse = MyResponse(ApiUtil.BAD_REQUEST_CODE);
    myResponse.errorText = "Please turn on internet";
    return myResponse;
  }

  static MyResponse<T> makeInternetConnectionError<T>() {
    Fluttertoast.showToast(msg: 'No connection to server found.', toastLength: Toast.LENGTH_LONG);
    MyResponse<T> myResponse = MyResponse(ApiUtil.INTERNET_NOT_AVAILABLE_CODE);
    myResponse.data = "No connection to server found." as T?;
    //myResponse.errorText = "Please turn on internet";
    return myResponse;
  }

  static MyResponse<T> makeServerProblemError<T>() {
    MyResponse<T> myResponse = MyResponse(ApiUtil.SERVER_ERROR_CODE);
    myResponse.errorText = "There was an error on our end! Please try again later";
    return myResponse;
  }

  static MyResponse<T> makeCredentialsError<T>() {
    MyResponse<T> myResponse = MyResponse(ApiUtil.ERROR_CODE);
    myResponse.errorText = "These credentials do not match our records.";
    return myResponse;
  }

  static MyResponse<T> makeAppConnectionError<T>(String _errorMessage) {
    MyResponse<T> myResponse = MyResponse(ApiUtil.INTERNET_NOT_AVAILABLE_CODE);
    myResponse.data = _errorMessage as T?;
    return myResponse;
  }
}
