import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_statetodoo/todo_app/providers/all_providers.dart';

class ToolBarWidget extends ConsumerWidget {
  ToolBarWidget({Key? key}) : super(key: key);
  var _currentFilter = TodoListFilter.all;

  Color changeBtnColor(TodoListFilter filter) {
    return _currentFilter == filter ? Colors.orange : Colors.indigo;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onCompletedTodoCount = ref.watch(unCopletedTodoCount);
    _currentFilter = ref.watch(todoListFilter);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Text(
          onCompletedTodoCount == 0
              ? 'Görev tamamlandı'
              : '${onCompletedTodoCount.toString()} Görev kaldı',
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
        )),
        Tooltip(
          message: 'All Todos',
          child: TextButton(
              style: TextButton.styleFrom(
                  primary: changeBtnColor(TodoListFilter.all)),
              onPressed: () {
                ref.read(todoListFilter.notifier).state = TodoListFilter.all;
              },
              child: const Text('All')),
        ),
        Tooltip(
          message: 'Only Uncompleted Todos',
          child: TextButton(
              style: TextButton.styleFrom(
                  primary: changeBtnColor(TodoListFilter.active)),
              onPressed: () {
                ref.read(todoListFilter.notifier).state = TodoListFilter.active;
              },
              child: const Text('Active')),
        ),
        Tooltip(
          message: 'Only Completed Todos',
          child: TextButton(
              style: TextButton.styleFrom(
                  primary: changeBtnColor(TodoListFilter.completed)),
              onPressed: () {
                ref.read(todoListFilter.notifier).state =
                    TodoListFilter.completed;
              },
              child: const Text('Completed')),
        ),
      ],
    );
  }
}
