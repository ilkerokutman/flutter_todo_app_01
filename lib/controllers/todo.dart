import 'package:flutter_todo_app_01/core/enums.dart';
import 'package:flutter_todo_app_01/data/models/todo.dart';
import 'package:flutter_todo_app_01/data/providers/db_provider.dart';
import 'package:get/get.dart';

class TodoController extends GetxController {
  final RxList<Todo> _todoList = <Todo>[].obs;
  List<Todo> get todoList => _todoList;

  final RxInt _countAll = 0.obs;
  final RxInt _countDone = 0.obs;
  final RxInt _countActive = 0.obs;

  int get countAll => _countAll.value;
  int get countDone => _countDone.value;
  int get countActive => _countActive.value;

  final Rx<TodoFilter> _currentFilter = TodoFilter.all.obs;
  TodoFilter get currentFilter => _currentFilter.value;

  void changeFilter(TodoFilter f) {
    _currentFilter.value = f;
    update();
    getList(filter: f);
  }

  Future<void> getList({TodoFilter filter = TodoFilter.all}) async {
    List<Todo> items = <Todo>[];
    String? arg;
    switch (filter) {
      case TodoFilter.active:
        arg = "${TodoStatus.active.index}";
        break;
      case TodoFilter.done:
        arg = "${TodoStatus.done.index}";
        break;
      default:
        arg = null;
        break;
    }
    var todos = await DbProvider.db.getRows(where: "status=?", args: arg);
    if (todos.isNotEmpty) {
      for (var i = 0; i < todos.length; i++) {
        Todo item = Todo.fromMap(todos[i]);
        items.add(item);
      }
    }
    _todoList.value = items;
    update();
    getCounts();
  }

  Future<void> getCounts() async {
    var all = await DbProvider.db.getRows();
    var done = await DbProvider.db.getRows(where: "status=?", args: "${TodoStatus.done.index}");
    var active = await DbProvider.db.getRows(where: "status=?", args: "${TodoStatus.active.index}");
    _countActive.value = active.length;
    _countDone.value = done.length;
    _countAll.value = all.length;
    update();
  }

  Future<void> insertTodo(Todo item) async {
    await DbProvider.db.insert(data: item.toMapForUpdate());
    getList();
  }

  Future<void> updateTodo(Todo item) async {
    await DbProvider.db.update(data: item.toMapForUpdate(), where: "id=?", args: "${item.id}");
    getList();
  }

  Future<void> deleteTodo(int id) async {
    await DbProvider.db.delete(where: "id=?", args: "$id");
    getList();
  }
}
