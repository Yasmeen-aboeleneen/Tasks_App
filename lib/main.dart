import 'package:flutter/material.dart';
import 'package:tasks_app/Views/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tasky',
      theme: ThemeData(useMaterial3: true),
      home: WelcomeScreen(),
    );
  }
}
