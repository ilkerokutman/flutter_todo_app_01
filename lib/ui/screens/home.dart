import 'package:flutter/material.dart';
import 'package:flutter_todo_app_01/controllers/todo.dart';
import 'package:flutter_todo_app_01/data/models/enums.dart';
import 'package:flutter_todo_app_01/data/models/todo.dart';
import 'package:flutter_todo_app_01/routes/routes.dart';
import 'package:flutter_todo_app_01/ui/widgets/filters.dart';
import 'package:flutter_todo_app_01/ui/widgets/todo_list.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TodoController controller = Get.find();
  @override
  void initState() {
    super.initState();
    controller.getList();
    controller.getCounts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Todo App"),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.edit, arguments: [Todo(id: -1, title: '', status: TodoStatus.active)]);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          TodoFilterBoxWidget(),
          TodoListWidget(),
        ],
      ),
    );
  }
}
