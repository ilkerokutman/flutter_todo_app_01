import 'package:flutter_todo_app_01/core/enums.dart';

class Todo {
  int id;
  String title;
  String? description;
  TodoStatus status;
  Todo({
    required this.id,
    required this.title,
    this.description,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status.index,
    };
  }

  Map<String, dynamic> toMapForUpdate() {
    return {
      'title': title,
      'description': description,
      'status': status.index,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      description: map['description'],
      status: TodoStatus.values[map['status']],
    );
  }
}
