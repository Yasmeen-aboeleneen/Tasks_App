import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasks_app/Views/Home/home_screen.dart';

// ignore: must_be_immutable
class AddTaskScreen extends StatefulWidget {
  AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  //ToDo dispose these controllers
  final TextEditingController taskNameController = TextEditingController();

  final TextEditingController taskDescriptionController =
      TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  bool ishighPriority = false;

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        height: h * .049,
        width: w * .6,
        child: FloatingActionButton(
          backgroundColor: Color(0xFF15B86c),
          foregroundColor: Color(0xFFFFFFFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
          ),
          onPressed: () async {
            if (_key.currentState?.validate() ?? false) {
              final pref = await SharedPreferences.getInstance();
              await pref.setString('username', taskNameController.value.text);
              await pref.setString(
                'username',
                taskDescriptionController.value.text,
              );

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return HomeScreen();
                  },
                ),
              );
            }
          },
          child: Text(
            'Add Task',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
        ),
      ),
      backgroundColor: Color(0xFF181818),
      appBar: AppBar(
        backgroundColor: Color(0xFF181818),
        foregroundColor: Color(0xFFFFFFFF),
        title: Text('New Task'),
        titleTextStyle: TextStyle(
          color: Color(0xFFFFFFFF),
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
        toolbarHeight: h * .08,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Form(
            key: _key,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Task Name',
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: h * .01),
                  TextFormField(
                    controller: taskNameController,
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter task name';
                      }
                      return null;
                    },
                    style: TextStyle(color: Color(0xFFFFFcFc)),
                    decoration: InputDecoration(
                      hintText: 'Enter task name',
                      filled: true,
                      fillColor: Color(0xff282828),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    cursorColor: Color(0xFFFFFcFc),
                  ),
                  SizedBox(height: h * .045),
                  Text(
                    'Task Description',
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: h * .01),
                  TextFormField(
                    controller: taskDescriptionController,
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your task description';
                      }
                      return null;
                    },
                    style: TextStyle(color: Color(0xFFFFFcFc)),

                    maxLines: 9,
                    decoration: InputDecoration(
                      hintText: 'Describe your task',
                      filled: true,
                      fillColor: Color(0xff282828),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    cursorColor: Color(0xFFFFFcFc),
                  ),
                  SizedBox(height: h * .04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'High Priority',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Switch(
                        activeTrackColor: Color(0xFF15B86c),
                        value: ishighPriority,
                        onChanged: (bool value) {
                          setState(() {
                            ishighPriority = value;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
