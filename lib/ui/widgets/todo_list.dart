import 'package:flutter/material.dart';
import 'package:flutter_todo_app_01/controllers/todo.dart';
import 'package:flutter_todo_app_01/data/models/enums.dart';
import 'package:flutter_todo_app_01/data/models/todo.dart';
import 'package:flutter_todo_app_01/routes/routes.dart';
import 'package:get/get.dart';

class TodoListWidget extends StatelessWidget {
  const TodoListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetBuilder<TodoController>(
        builder: (_todo) {
          if (_todo.todoList.isEmpty) {
            return const Center(child: Text("no items here"));
          } else {
            return ListView.builder(
              itemBuilder: (context, index) {
                Todo todo = _todo.todoList[index];
                return Row(
                  children: [
                    Expanded(
                      child: CheckboxListTile(
                        title: Text(todo.title),
                        subtitle: Text("${todo.description}", overflow: TextOverflow.ellipsis),
                        value: todo.status == TodoStatus.done,
                        onChanged: (val) async {
                          todo.status = val == true ? TodoStatus.done : TodoStatus.active;
                          await _todo.updateTodo(todo);
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Get.toNamed(Routes.edit, arguments: [todo]);
                        },
                      ),
                    ),
                  ],
                );
              },
              itemCount: _todo.todoList.length,
            );
          }
        },
      ),
    );
  }
}
