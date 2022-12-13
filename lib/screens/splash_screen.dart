import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:todoapp/constants/app_colors.dart';
import 'package:todoapp/constants/app_defaults.dart';
import 'package:todoapp/screens/home/home.dart';

class SplashScreenpage extends StatefulWidget {
  const SplashScreenpage({Key? key}) : super(key: key);

  @override
  _SplashScreenpageState createState() => _SplashScreenpageState();
}

class _SplashScreenpageState extends State<SplashScreenpage> {
  Timer? _timer;
  int _second = 3; // set timer for 3 second and then direct to next page

  void _startTimer() {

    const period = Duration(seconds: 1);
    _timer = Timer.periodic(period, (timer) async {
      setState(() {
        _second--;
      });
      if (_second == 0) {
        _cancelFlashsaleTimer();
        Get.offAllNamed<dynamic>(ToDoRoutes.home);
      }
    });
  }

  void _cancelFlashsaleTimer() {
    if (_timer != null) {
      _timer?.cancel();
      _timer = null;
    }
  }

  @override
  void initState() {
    // set status bar color to transparent and navigation bottom color to black21
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    if(_second != 0){
      _startTimer();
    }
    super.initState();
  }

  @override
  void dispose() {
    _cancelFlashsaleTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primary,
        body: Center(
          child: Container(child:
          const Text("ToDoApp ", style: TextStyle(color: Colors.white, fontSize: 30),)
          ),
        )
    );
  }
}

