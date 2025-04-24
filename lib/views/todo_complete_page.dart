import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:todaylistapp/controllers/todo_controllers.dart';
import 'package:todaylistapp/views/todo_page.dart';

class TodoCompletePage extends StatelessWidget {
  const TodoCompletePage({super.key});

  @override
  Widget build(BuildContext context) {
    final TodoControllers controller = Get.find<TodoControllers>();
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   backgroundColor: Color(0xFFF1EFEC),
      // ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Color(0xFFD4C9BE),
        onPressed: () {
          Get.to(
            () => TodoPage(),
            transition: Transition.upToDown,
            duration: Duration(seconds: 2),
          );
        },
        child: Icon(
          Icons.arrow_drop_up_rounded,
          color: Color(0xFF030303),
          size: 55,
        ),
      ),

      backgroundColor: Color(0xFFF1EFEC),
      body: Column(
        children: [
          SizedBox(height: 80),
          Text(
            'To-Do Completion Status',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
          ),
          SizedBox(height: 25),
          Obx(() {
            final unCompleted = controller.todoList;
            final completed = controller.todoCompleted;
            int countAllToDo = unCompleted.length + completed.length;
            int countCompleted = completed.length;

            final bool isEmpty = countAllToDo == 0;

            return SizedBox(
              height: 200,
              child: Stack(
                children: [
                  PieChart(
                    PieChartData(
                      startDegreeOffset: 150,
                      centerSpaceRadius: 80,
                      sections:
                          isEmpty
                              ? [
                                PieChartSectionData(
                                  value: 1,
                                  color: Color(0xFFD4C9BE),
                                  showTitle: false,
                                ),
                              ]
                              : [
                                PieChartSectionData(
                                  value: countCompleted.toDouble(),
                                  color: Color(0xFF72B896),
                                  showTitle: false,
                                ),
                                PieChartSectionData(
                                  value:
                                      (countAllToDo - countCompleted)
                                          .toDouble(),
                                  color: Color(0xFF030303),
                                  showTitle: false,
                                ),
                              ],
                    ),
                  ),
                  Positioned.fill(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 140,
                          width: 140,
                          decoration: BoxDecoration(
                            color: Color(0xFFF1EFEB),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFF1EFEC),
                                blurRadius: 9,
                                spreadRadius: 9,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child:
                                isEmpty
                                    ? Text(
                                      '$countCompleted / $countAllToDo',
                                      style: TextStyle(fontSize: 20),
                                    )
                                    : Text(
                                      '$countCompleted / $countAllToDo',
                                      style: TextStyle(fontSize: 20),
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),

          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Divider(thickness: 2, color: Color(0xFF030303)),
          ),
          Expanded(
            child: GetBuilder<TodoControllers>(
              builder: (controller) {
                return ListView.builder(
                  padding: EdgeInsets.only(top: 1),
                  shrinkWrap: true,
                  itemCount: controller.todoCompleted.length,
                  itemBuilder: (context, index) {
                    final todoData = controller.todoCompleted[index];
                    // print(todoData);
                    return ListTile(
                      dense: true,
                      visualDensity: VisualDensity.compact,
                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                      leading: Checkbox(
                        activeColor: Color(0xFF72B896),
                        checkColor: Color(0xFF030303),
                        value: todoData.isCompleted,
                        onChanged: (value) {
                          controller.updateStatusToDo(todoData.id);
                          print(todoData.id);
                        },
                      ),
                      title: Text(
                        todoData.title,
                        style: TextStyle(fontSize: 16),
                      ),
                      horizontalTitleGap: -5,
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
