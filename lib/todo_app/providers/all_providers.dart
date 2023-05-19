import 'package:flutter_statetodoo/todo_app/providers/todo_list_manager.dart';
import 'package:riverpod/riverpod.dart';
import '../Model/todoModel.dart';
import 'package:uuid/uuid.dart';

enum TodoListFilter { all, active, completed }

final todoListFilter = StateProvider((ref) => TodoListFilter.all);

final todoListProvider =
    StateNotifierProvider<TodoListManager, List<TodoModel>>((ref) {
  return TodoListManager([
    TodoModel(id: const Uuid().v4(), description: 'Spora git'),
    TodoModel(id: const Uuid().v4(), description: 'Okul ödevi'),
    TodoModel(id: const Uuid().v4(), description: 'Proje yap'),
  ]);
});

final filteredTodoList = Provider<List<TodoModel>>((ref) {
  final filter = ref.watch(todoListFilter);
  final todoList = ref.watch(todoListProvider);

  switch (filter) {
    case TodoListFilter.all:
      return todoList;
    case TodoListFilter.completed:
      return todoList.where((element) => element.completed).toList();
    case TodoListFilter.active:
      return todoList.where((element) => !element.completed).toList();
  }
});

final unCopletedTodoCount = Provider<int>((ref) {
  final allTodo = ref.watch(todoListProvider);
  final count = allTodo.where((element) => !element.completed).length;
  return count;
});

final currentTodo = Provider<TodoModel>((ref) {
  throw UnimplementedError();
});
