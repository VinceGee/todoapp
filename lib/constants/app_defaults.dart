import 'package:flutter/material.dart';

const IS_ONBOARDING_LAUNCHED = 'IS_ONBOARDING_LAUNCHED';
const IS_LOGGED_IN = 'IS_LOGGED_IN';
const OTP_VERIFIED = 'OTP_VERIFIED';
const SERVER_TIMEOUT_SECONDS = 30;
const SESSION_TIMEOUT = 5;
const REFRESH_TOKEN_TIMER = 270;

class AppDefaults {
  static const double radius = 16.00;
  static const double margin = 16.00;
  static const double padding = 16.00;

  static BorderRadius borderRadius = BorderRadius.circular(radius);

  /// Many Parts of the UI uses this same box shadows
  static List<BoxShadow> boxShadows = [
    BoxShadow(
      blurRadius: 15,
      offset: const Offset(5, 4),
      color: const Color(0x0ff33333).withOpacity(0.05),
    )
  ];

}

class ToDoRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/home';
  static const String singleTodo = '/to-do-item';
  static const String maintainance = '/maintain-screen';
}
