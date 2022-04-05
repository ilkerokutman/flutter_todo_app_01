import 'package:flutter/material.dart';
import 'package:flutter_todo_app_01/controllers/todo.dart';
import 'package:flutter_todo_app_01/data/models/enums.dart';
import 'package:flutter_todo_app_01/data/models/todo.dart';
import 'package:flutter_todo_app_01/routes/routes.dart';
import 'package:get/get.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({Key? key}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Todo? todo = Get.arguments[0];
  TodoController controller = Get.find();

  @override
  void initState() {
    super.initState();
    todo ??= Todo(id: -1, title: '', status: TodoStatus.active);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(todo!.id > 0 ? "Edit Note" : "Add Note"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              Get.defaultDialog(
                  title: "Deleting Item",
                  middleText: "Are you sure you want to delete this item?",
                  textConfirm: "Delete",
                  textCancel: "Cancel",
                  barrierDismissible: false,
                  onConfirm: () async {
                    await controller.deleteTodo(todo!.id);
                    Get.offAllNamed(Routes.home);
                  },
                  onCancel: () {
                    //...
                  });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: TextEditingController(text: todo!.title),
                  onSaved: (val) {
                    setState(() {
                      todo!.title = val!;
                    });
                  },
                  validator: (val) {
                    if (val == null || val.isEmpty) return "this field is required";
                    return null;
                  },
                  decoration: const InputDecoration(
                    label: Text("Title"),
                    hintText: 'Type title here',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: TextEditingController(text: todo!.description),
                  decoration: const InputDecoration(
                    label: Text("Description"),
                    hintText: "Type description here",
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (val) {
                    setState(() {
                      todo!.description = val;
                    });
                  },
                ),
              ),
              todo!.id > 0
                  ? Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: CheckboxListTile(
                        title: Text(todo!.status == TodoStatus.done ? 'Done' : 'Active'),
                        value: todo!.status == TodoStatus.done,
                        onChanged: (val) {
                          setState(() {
                            todo!.status = val == true ? TodoStatus.done : TodoStatus.active;
                          });
                        },
                      ),
                    )
                  : Container(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: MaterialButton(
                    onPressed: _submit,
                    child: const Text(
                      "SAVE",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    if (todo!.id > 0) {
      await controller.updateTodo(todo!);
    } else {
      await controller.insertTodo(todo!);
    }

    Get.offAllNamed(Routes.home);
  }
}
