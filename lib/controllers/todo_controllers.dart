import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:todaylistapp/model/today_data.dart';

class TodoControllers extends GetxController {
  final List<TodayData> todoList = <TodayData>[].obs;
  final List<TodayData> todoCompleted = <TodayData>[].obs;

  void addTodo(String title) {
    final newTodo = TodayData(
      id: DateTime.now().toString(),
      title: title,
      dayWrite: DateTime.now(),
      dayComplete: null,
      isCompleted: false,
    );
    todoList.add(newTodo);
    update();
  }

  void deleteTodo(String id) {
    todoList.removeWhere(((todo) => todo.id == id));
    update();
  }

  void updateStatusToDo(String id) {
    TodayData? todo = todoList.firstWhereOrNull((t) => t.id == id);
    bool fromTodoList = true;

    if (todo == null) {
      todo = todoCompleted.firstWhereOrNull((t) => t.id == id);
      fromTodoList = false;
    }

    if (todo == null) {
      print("Not found id ${id}");
      return;
    }

    todo.isCompleted = !todo.isCompleted;
    todo.dayComplete = todo.isCompleted ? DateTime.now() : null;

    if (todo.isCompleted) {
      todoCompleted.add(todo);
      todoList.removeWhere((t) => t.id == id);
    } else {
      todoList.add(todo);
      todoCompleted.removeWhere((t) => t.id == id);
    }

    update();
  }
}
