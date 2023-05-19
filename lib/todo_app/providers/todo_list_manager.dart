import 'package:flutter_statetodoo/todo_app/Model/todoModel.dart';
import 'package:riverpod/riverpod.dart';
import 'package:uuid/uuid.dart';

class TodoListManager extends StateNotifier<List<TodoModel>> {
  TodoListManager([List<TodoModel>? initalTodas]) : super(initalTodas ?? []);

  void addTodo(String description) {
    var ekleneceTodo =
        TodoModel(id: const Uuid().v4(), description: description);
    state = [...state, ekleneceTodo];
  }

  void toggle(String id) {
    state = [
      for (var todo in state)
        if (todo.id == id)
          TodoModel(
              id: todo.id,
              description: todo.description,
              completed: !todo.completed)
        else
          todo
    ];
  }

  void edit({required String id, required String newDescrpition}) {
    state = [
      for (var todo in state)
        if (todo.id == id)
          TodoModel(
              id: todo.id,
              description: newDescrpition,
              completed: todo.completed)
        else
          todo
    ];
  }

  void remove(TodoModel deleteTodo) {
    state = state.where((element) => element.id != deleteTodo.id).toList();
  }

  int onCompletedCount() {
    return state.where((element) => !element.completed).length;
  }
}
