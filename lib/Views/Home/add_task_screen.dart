import 'package:flutter/material.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
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
    );
  }
}
