import 'package:flutter/material.dart';
import 'package:flutter_statetodoo/todo_app/providers/all_providers.dart';
import '../Model/todoModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoListItemWidget extends ConsumerStatefulWidget {
  const TodoListItemWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TodoListItemWidgetState();
}

class _TodoListItemWidgetState extends ConsumerState<TodoListItemWidget> {
  late FocusNode _textfocusNode;
  late TextEditingController _textController;
  bool _hasFocus = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textfocusNode = FocusNode();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textfocusNode.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentTodoItem = ref.watch(currentTodo);
    return Focus(
      onFocusChange: (value) {
        if (!value) {
          setState(() {
            _hasFocus = false;
          });
          ref.read(todoListProvider.notifier).edit(
              id: currentTodoItem.id, newDescrpition: _textController.text);
        }
      },
      child: ListTile(
        onTap: () {
          setState(() {
            _hasFocus = true;
          });
          _textfocusNode.requestFocus();
          _textController.text = currentTodoItem.description;
        },
        leading: Checkbox(
          value: currentTodoItem.completed,
          onChanged: (value) {
            ref.read(todoListProvider.notifier).toggle(currentTodoItem.id);
          },
        ),
        title: _hasFocus
            ? TextField(
                controller: _textController,
                focusNode: _textfocusNode,
              )
            : Text(currentTodoItem.description),
      ),
    );
  }
}
