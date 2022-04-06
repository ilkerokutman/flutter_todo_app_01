import 'package:flutter/material.dart';
import 'package:flutter_todo_app_01/controllers/todo.dart';
import 'package:flutter_todo_app_01/core/enums.dart';
import 'package:get/get.dart';

class TodoFilterBoxWidget extends StatelessWidget {
  const TodoFilterBoxWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const themeNumber = TextStyle(fontSize: 48, color: Colors.white, fontWeight: FontWeight.w500);
    const themeText = TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22);
    return GetBuilder<TodoController>(builder: (controller) {
      return SizedBox(
        height: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  controller.changeFilter(TodoFilter.all);
                },
                child: Container(
                  color: controller.currentFilter == TodoFilter.all
                      ? Theme.of(context).colorScheme.secondary
                      : Colors.black54,
                  margin: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${controller.countAll}", style: themeNumber),
                      const Text("All", style: themeText),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  controller.changeFilter(TodoFilter.active);
                },
                child: Container(
                  color: controller.currentFilter == TodoFilter.active
                      ? Theme.of(context).colorScheme.secondary
                      : Colors.black54,
                  margin: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${controller.countActive}", style: themeNumber),
                      const Text("Active", style: themeText),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  controller.changeFilter(TodoFilter.done);
                },
                child: Container(
                  color: controller.currentFilter == TodoFilter.done
                      ? Theme.of(context).colorScheme.secondary
                      : Colors.black54,
                  margin: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${controller.countDone}", style: themeNumber),
                      const Text("Done", style: themeText),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
