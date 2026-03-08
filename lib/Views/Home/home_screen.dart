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
  bool isLoading = false;
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
    setState(() {
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 5));
    final pref = await SharedPreferences.getInstance();

    final finalTask = pref.getString('tasks');
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;
      setState(() {
        task = taskAfterDecode
            .map((element) => TaskModel.fromJson(element))
            .toList();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/home_icon.svg'),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/todo_icon.svg'),
            label: 'ToDo',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/completed_icon.svg'),
            label: 'Completed',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/profile_icon.svg'),
            label: 'Profile',
          ),
        ],
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return AddTaskScreen();
                },
              ),
            );
            return _loadTask();
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
                    : ListView.separated(
                        padding: EdgeInsets.only(bottom: 60),
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
                              child: Row(
                                children: [
                                  Checkbox(
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadiusGeometry.circular(4),
                                    ),
                                    activeColor: Colors.green,
                                    value: task[index].isDone,
                                    onChanged: (bool? value) async {
                                      setState(() {
                                        task[index].isDone = value ?? true;
                                      });
                                      final pref =
                                          await SharedPreferences.getInstance();
                                      final updatedTask = task
                                          .map(
                                            (element) => element.convertToMap(),
                                          )
                                          .toList();
                                      pref.setString(
                                        'tasks',
                                        jsonEncode(updatedTask),
                                      );
                                    },
                                  ),
                                  SizedBox(width: w * .03),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            task[index].taskName,
                                            maxLines: 1,
                                            style: TextStyle(
                                              fontSize: w * .05,
                                              fontWeight: FontWeight.bold,
                                              overflow: TextOverflow.ellipsis,
                                              color: task[index].isDone
                                                  ? Color(0xFFA0A0A0)
                                                  : Colors.white,
                                              decoration: task[index].isDone
                                                  ? TextDecoration.lineThrough
                                                  : TextDecoration.none,
                                              decorationColor: Color(
                                                0xFFA0A0A0,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: h * .01),
                                          Text(
                                            task[index].taskDescription,
                                            maxLines: 2,
                                            style: TextStyle(
                                              fontSize: w * .035,
                                              fontWeight: FontWeight.w500,
                                              color: task[index].isDone
                                                  ? Color(0xFFA0A0A0)
                                                  : Colors.white,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.more_vert,
                                      color: task[index].isDone
                                          ? Color(0xFFA0A0A0)
                                          : const Color.fromARGB(
                                              255,
                                              241,
                                              239,
                                              239,
                                            ),
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
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
