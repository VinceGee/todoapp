import 'dart:convert';

import 'package:todoapp/api/api_util.dart';
import 'package:todoapp/models/todo_model.dart';
import 'package:todoapp/services/network.dart';
import 'package:todoapp/utilities/global_functions.dart';
import 'package:todoapp/utilities/internet_utilities.dart';
import 'package:todoapp/utilities/my_response.dart';

class TodoController {

  static Future<MyResponse> getAllTodos() async {
    String url = ApiUtil.MAIN_API_URL + ApiUtil.GET_TODOS;

    //Check Internet
    bool isConnected = await InternetUtils.checkConnection();
    if (!isConnected) {
      return MyResponse.makeInternetConnectionError();
    }

    return GlobalFunctions.serverGetWithNoAuth(url).then((value) {
      if(value.runtimeType == NetworkResponse){
        value = value as NetworkResponse;
        MyResponse myResponse = MyResponse(value.statusCode);

        Map<String, dynamic> dataResponse = json.decode(value.body);
        if (dataResponse[ApiUtil.SERVER_RESPONSE] == ApiUtil.RESPONSE_BOOL_TRUE) {
          List<Todo> list = Todo.getListFromJson(json.decode(value.body)["data"]["todos"]);

          myResponse.success = true;
          myResponse.data = list;
        } else {
          myResponse.success = false;
          myResponse.data = dataResponse["message"];
        }
        return myResponse;
      } else {
        return value as MyResponse;
      }
    });
  }

  static Future<MyResponse> addNewTask(String _title, String _description,String _dueWhen, String _status) async {
    //URL
    String loginUrl = ApiUtil.MAIN_API_URL + ApiUtil.ADD_TASK;

    Map data = {
      "title": _title,
      "description": _description,
      "due_date_time": _dueWhen,
      "status": _status,
    };

    //Encode
    String body = json.encode(data);

    //Check Internet
    bool isConnected = await InternetUtils.checkConnection();
    if (!isConnected) {
      return MyResponse.makeInternetConnectionError();
    }

    return GlobalFunctions.serverPostWithNoAuth(loginUrl, body).then((value) {
      if(value.runtimeType == NetworkResponse){
        value = value as NetworkResponse;
        MyResponse myResponse = MyResponse(value.statusCode);

        Map<String, dynamic> dataResponse = json.decode(value.body);
        if (dataResponse[ApiUtil.SERVER_RESPONSE] == ApiUtil.RESPONSE_BOOL_TRUE) {
          myResponse.success = true;
          myResponse.data = dataResponse;
        } else {
          myResponse.success = false;
          myResponse.data = dataResponse["message"];
        }
        return myResponse;
      } else {
        return value as MyResponse;
      }
    });
  }

  static Future<MyResponse> updateATask(String _id,String _title, String _description,String _dueWhen, String _status) async {
    //URL
    String loginUrl = ApiUtil.MAIN_API_URL + ApiUtil.UPDATE_TASK + _id;

    Map data = {
      "id": _id,
      "title": _title,
      "description": _description,
      "due_date_time": _dueWhen,
      "status": _status,
    };

    //Encode
    String body = json.encode(data);

    //Check Internet
    bool isConnected = await InternetUtils.checkConnection();
    if (!isConnected) {
      return MyResponse.makeInternetConnectionError();
    }

    return GlobalFunctions.serverPutWithNoAuth(loginUrl, body).then((value) {
      if(value.runtimeType == NetworkResponse){
        value = value as NetworkResponse;
        MyResponse myResponse = MyResponse(value.statusCode);

        Map<String, dynamic> dataResponse = json.decode(value.body);
        if (dataResponse[ApiUtil.SERVER_RESPONSE] == ApiUtil.RESPONSE_BOOL_TRUE) {
          myResponse.success = true;
          myResponse.data = dataResponse;
        } else {
          myResponse.success = false;
          myResponse.data = dataResponse["message"];
        }
        return myResponse;
      } else {
        return value as MyResponse;
      }
    });
  }

  static Future<MyResponse> deleteATask(String _id) async {
    //URL
    String loginUrl = ApiUtil.MAIN_API_URL + ApiUtil.DELETE_TASK + _id;

    Map data = {
      "id": _id,
    };

    //Encode
    String body = json.encode(data);

    //Check Internet
    bool isConnected = await InternetUtils.checkConnection();
    if (!isConnected) {
      return MyResponse.makeInternetConnectionError();
    }

    return GlobalFunctions.serverDeleteWithNoAuth(loginUrl, body).then((value) {
      if(value.runtimeType == NetworkResponse){
        value = value as NetworkResponse;
        MyResponse myResponse = MyResponse(value.statusCode);

        Map<String, dynamic> dataResponse = json.decode(value.body);
        if (dataResponse[ApiUtil.SERVER_RESPONSE] == ApiUtil.RESPONSE_BOOL_TRUE) {
          myResponse.success = true;
          myResponse.data = dataResponse;
        } else {
          myResponse.success = false;
          myResponse.data = dataResponse["message"];
        }
        return myResponse;
      } else {
        return value as MyResponse;
      }
    });
  }

}