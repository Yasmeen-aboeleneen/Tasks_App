// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasks_app/Models/task_model.dart';
import 'package:tasks_app/Views/Home/add_task_screen.dart';
import 'package:tasks_app/Widgets/task_list_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? username;
  List<TaskModel> tasks = [];
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadUserName();
    _loadTask();
  }

  void _loadUserName() async {
    final pref = await SharedPreferences.getInstance();

    setState(() {
      username = pref.getString('username');
    });
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
            .toList();
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, color: Colors.black, size: 32),
                  ),

                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good Evening , $username',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'One task at a time , one step closer',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: h * .03),
              Text(
                '$username , Your work is ',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Row(
                children: [
                  Text(
                    'almost done !',
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(width: 10),
                  SvgPicture.asset(
                    'assets/images/wavingHand.svg',
                    width: 25,
                    height: 25,
                  ),
                ],
              ),
              SizedBox(height: h * .03),
              Text(
                'My Tasks',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: w * .06,
                ),
              ),
              SizedBox(height: h * .02),
              Expanded(
                child: isLoading
                    ? Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      )
                    : TaskListWidget(
                        tasks: tasks,
                        onTap: (value, index) async {
                          setState(() {
                            tasks[index!].isDone = value ?? true;
                          });
                          final pref = await SharedPreferences.getInstance();
                          final updatedTask = tasks
                              .map((element) => element.convertToMap())
                              .toList();
                          pref.setString('tasks', jsonEncode(updatedTask));
                        },
                        emptyMessege: 'No Data',
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        height: h * .049,
        width: w * .46,
        child: FloatingActionButton.extended(
          backgroundColor: Color(0xFF15B86c),
          foregroundColor: Color(0xFFFFFFFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
          ),
          onPressed: () async {
            final bool? result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return AddTaskScreen();
                },
              ),
            );
            if (result != null && result) {
              _loadTask();
            }
          },
          label: Text(
            'Add New Task',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
          icon: Icon(Icons.add),
        ),
      ),
    );
  }
}
