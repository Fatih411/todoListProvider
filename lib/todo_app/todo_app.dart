import 'package:flutter/material.dart';
import 'package:flutter_statetodoo/todo_app/providers/all_providers.dart';
import 'package:flutter_statetodoo/todo_app/widgets/title_widget.dart';
import 'package:flutter_statetodoo/todo_app/widgets/todo_list_item.dart';
import 'package:flutter_statetodoo/todo_app/widgets/toolbar_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'Model/todoModel.dart';
import 'package:uuid/uuid.dart';

class TodoApp extends ConsumerWidget {
  TodoApp({Key? key}) : super(key: key);

  final newTodoController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var allTodos = ref.watch(filteredTodoList);
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        children: [
          const TitleWidget(),
          TextField(
            controller: newTodoController,
            decoration: const InputDecoration(
                labelText: 'Neler Yapacaksın Bugün ?',
                border: OutlineInputBorder()),
            onSubmitted: (newTodo) {
              if (newTodoController.text.isNotEmpty) {
                ref.read(todoListProvider.notifier).addTodo(newTodo);
                newTodoController.text = "";
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          ToolBarWidget(),
          for (var i = 0; i < allTodos.length; i++)
            Dismissible(
                key: ValueKey(allTodos[i].id),
                onDismissed: (_) {
                  ref.read(todoListProvider.notifier).remove(allTodos[i]);
                },
                child: ProviderScope(overrides: [
                  currentTodo.overrideWithValue(allTodos[i]),
                ], child: const TodoListItemWidget()))
        ],
      ),
    );
  }
}
