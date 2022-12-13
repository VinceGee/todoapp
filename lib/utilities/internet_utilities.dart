import 'package:nb_utils/nb_utils.dart';

class InternetUtils{

  static Future<bool> checkConnection() async{
    ConnectivityResult connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }
}