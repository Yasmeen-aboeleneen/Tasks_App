import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasks_app/Models/task_model.dart';
import 'package:tasks_app/Widgets/task_list_widget.dart';

class CompletedScreen extends StatefulWidget {
  const CompletedScreen({super.key});

  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
  List<TaskModel> tasks = [];
  bool isLoading = false;
  void initState() {
    super.initState();

    _loadTask();
  }

  void _loadTask() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 0));
    final pref = await SharedPreferences.getInstance();

    final finalTask = pref.getString('tasks');
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;
      setState(() {
        tasks = taskAfterDecode
            .map((element) => TaskModel.fromJson(element))
            .where((element) => element.isDone)
            .toList();
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Completed Tasks')),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: isLoading
              ? Center(child: CircularProgressIndicator(color: Colors.white))
              : TaskListWidget(
                  tasks: tasks,
                  onTap: (value, index) async {
                    setState(() {
                      tasks[index!].isDone = value ?? false;
                    });
                    final pref = await SharedPreferences.getInstance();
                    final allData = pref.getString('tasks');
                    if (allData != null) {
                      List<TaskModel> allDataList =
                          (jsonDecode(allData) as List)
                              .map((element) => TaskModel.fromJson(element))
                              .toList();
                      final int newIndex = allDataList.indexWhere(
                        (e) => e.id == tasks[index!].id,
                      );
                      allDataList[newIndex] = tasks[index!];

                      await pref.setString(
                        'tasks',
                        jsonEncode(
                          allDataList.map((e) => e.convertToMap()).toList(),
                        ),
                      );
                      _loadTask();
                    }
                  },
                  emptyMessege: 'No Tasks Found',
                ),
        ),
      ),
    );
  }
}
