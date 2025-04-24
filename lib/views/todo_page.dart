import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:todaylistapp/controllers/todo_controllers.dart';
import 'package:todaylistapp/views/todo_complete_page.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TodoControllers todoControllers = Get.put(TodoControllers());
    final TextEditingController titleController = TextEditingController();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFF1EFEC),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 2,
            title: Text(
              'To Day List',
              style: TextStyle(
                fontSize: 30,
                color: Color(0xFF030303),
                fontWeight: FontWeight.w400,
              ),
            ),
            centerTitle: false,
          ),
        ),
      ),
      backgroundColor: Color(0xFFF1EFEC),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Color(0xFFD4C9BE),
        onPressed: () {
          Get.to(
            () => TodoCompletePage(),
            transition: Transition.downToUp,
            duration: Duration(seconds: 1),
          );
        },
        child: Icon(
          Icons.arrow_drop_up_rounded,
          color: Color(0xFF030303),
          size: 55,
        ),
      ),

      body: Column(
        children: [
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: TextFormField(
              cursorColor: Color(0xFF123458),
              controller: titleController,
              onFieldSubmitted: (value) {
                if (value.isNotEmpty) {
                  todoControllers.addTodo(titleController.text);
                  titleController.clear();
                }
              },
              decoration: InputDecoration(
                hintText: 'To Do...',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF123458)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF123458), width: 2),
                ),
              ),
            ),
          ),
          Expanded(
            child: GetBuilder<TodoControllers>(
              builder: (controller) {
                return ListView.builder(
                  // padding: EdgeInsets.all(value),
                  padding: EdgeInsets.only(top: 10),
                  shrinkWrap: true,
                  itemCount: controller.todoList.length,
                  itemBuilder: (context, index) {
                    final todoData = controller.todoList[index];

                    return Dismissible(
                      direction: DismissDirection.endToStart,
                      key: ValueKey(controller.todoList[index].id.toString()),
                      background: Container(
                        color: Color(0xFFCD4439),
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 15),
                        child: Icon(
                          Icons.delete_outline_rounded,
                          color: Color(0xFF030303),
                        ),
                      ),
                      onDismissed: (direction) {
                        controller.deleteTodo(todoData.id);
                      },
                      child: ListTile(
                        dense: true,
                        visualDensity: VisualDensity.compact,
                        contentPadding: EdgeInsets.symmetric(horizontal: 8),
                        leading: Checkbox(
                          value: todoData.isCompleted,
                          onChanged: (value) {
                            print('todosbe: ${todoData.id}');
                            controller.updateStatusToDo(todoData.id);
                          },
                        ),
                        title: Text(
                          todoData.title,
                          style: TextStyle(fontSize: 16),
                        ),
                        horizontalTitleGap: -1,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
