import 'package:todoapp/constants/app_defaults.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:todoapp/screens/home/home.dart';
import 'package:todoapp/screens/splash_screen.dart';
import 'package:todoapp/screens/tasks/update_task.dart';

List<GetPage> todoRoutes = [

  GetPage<dynamic>(
    name: ToDoRoutes.splash,
    page: () => const SplashScreenpage(),
  ),

  GetPage<dynamic>(
    name: ToDoRoutes.home,
    page: () => const HomeScreen(),
  ),

];
