import 'package:flutter/material.dart';

import 'package:tasks_app/Models/task_model.dart';

class TaskListWidget extends StatelessWidget {
  const TaskListWidget({
    super.key,
    required this.tasks,
    required this.onTap,
    required this.emptyMessege,
  });
  final List<TaskModel> tasks;
  final Function(bool?, int?) onTap;
  final String emptyMessege;

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return tasks.isEmpty
        ? Center(
            child: Text(
              emptyMessege,
              style: TextStyle(
                color: Color(0xFFc6c6c6),
                fontWeight: FontWeight.bold,
                fontSize: w * .1,
              ),
            ),
          )
        : ListView.separated(
            padding: EdgeInsets.only(bottom: 60),
            itemCount: tasks.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  height: h * .099,
                  width: w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 94, 91, 91),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    children: [
                      Checkbox(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(4),
                        ),
                        activeColor: Colors.green,
                        value: tasks[index].isDone,
                        onChanged: (bool? value) {
                          onTap(value, index);
                        },
                      ),
                      SizedBox(width: w * .03),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tasks[index].taskName,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: w * .05,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                                color: tasks[index].isDone
                                    ? Color(0xFFA0A0A0)
                                    : Colors.white,
                                decoration: tasks[index].isDone
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                decorationColor: Color(0xFFA0A0A0),
                              ),
                            ),
                            SizedBox(height: h * .01),
                            if (tasks[index].taskDescription.isNotEmpty)
                              Text(
                                tasks[index].taskDescription,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: w * .035,
                                  fontWeight: FontWeight.w500,
                                  color: tasks[index].isDone
                                      ? Color(0xFFA0A0A0)
                                      : Colors.white,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.more_vert,
                          color: tasks[index].isDone
                              ? Color(0xFFA0A0A0)
                              : const Color.fromARGB(255, 241, 239, 239),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 8);
            },
          );
  }
}
