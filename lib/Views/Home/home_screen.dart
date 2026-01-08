// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasks_app/Models/task_model.dart';
import 'package:tasks_app/Views/Home/add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? username;
  List<TaskModel> task = [];
  @override
  void initState() {
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
    final pref = await SharedPreferences.getInstance();

    final finalTask = pref.getString('tasks');
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;
      setState(() {
        task = taskAfterDecode
            .map((element) => TaskModel.fromJson(element))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: SizedBox(
        height: h * .049,
        width: w * .46,
        child: FloatingActionButton.extended(
          backgroundColor: Color(0xFF15B86c),
          foregroundColor: Color(0xFFFFFFFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return AddTaskScreen();
                },
              ),
            );
          },
          label: Text(
            'Add New Task',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
          icon: Icon(Icons.add),
        ),
      ),
      backgroundColor: Color(0xFF181818),
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
              Expanded(
                child: ListView.builder(
                  itemCount: task.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        height: h * .09,
                        width: w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 94, 91, 91),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              task[index].taskName,
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(height: h * .02),
                            Text(
                              task[index].taskDescription,
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (task.isNotEmpty)
                Container(
                  height: h * .09,
                  width: w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 94, 91, 91),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(
                    task[0].taskName,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
