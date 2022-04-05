import 'package:flutter_todo_app_01/routes/routes.dart';
import 'package:flutter_todo_app_01/ui/screens/edit.dart';
import 'package:flutter_todo_app_01/ui/screens/home.dart';
import 'package:get/get.dart';

List<GetPage> getPages = [
  GetPage(name: Routes.home, page: () => const HomeScreen()),
  GetPage(name: Routes.edit, page: () => const EditScreen()),
];
