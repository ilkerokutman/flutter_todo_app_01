import 'package:flutter_todo_app_01/controllers/todo.dart';
import 'package:get/get.dart';

class AwaitBindings extends Bindings {
  @override
  Future<void> dependencies() async {
    await Get.putAsync<TodoController>(() async {
      return TodoController();
    }, permanent: true);
  }
}
