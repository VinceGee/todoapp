import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:todoapp/screens/splash_screen.dart';
import 'package:provider/provider.dart';

import 'api/routes.dart';
import 'providers/tasks_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialize();

  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodosProvider()),
      ],
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'ToDoApp',
          defaultTransition: Transition.native,
          navigatorKey: navigatorKey,
          getPages: todoRoutes,
          home: const SplashScreenpage(),
        ),
      );
  }
}
