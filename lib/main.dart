import 'package:flutter/material.dart';
import 'package:flutter_todo_app_01/bindings/await_bindings.dart';
import 'package:flutter_todo_app_01/routes/pages.dart';
import 'package:get/route_manager.dart';

import 'routes/routes.dart';

Future<void> main() async {
  await AwaitBindings().dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Todo App',
      getPages: getPages,
      initialRoute: Routes.home,
      defaultTransition: Transition.native,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.green,
        ),
      ),
    );
  }
}
