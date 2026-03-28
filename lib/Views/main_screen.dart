import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasks_app/Views/Home/home_screen.dart';
import 'package:tasks_app/Views/completed_screen.dart';
import 'package:tasks_app/Views/profile_screen.dart';
import 'package:tasks_app/Views/to_do_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _screen = [
    HomeScreen(),
    ToDoScreen(),
    CompletedScreen(),
    ProfileScreen(),
  ];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF181818),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int? index) {
          setState(() {
            _currentIndex = index ?? 0;
          });
        },
        backgroundColor: Color(0xFF181818),
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Color(0xFFc6c6c6),
        selectedItemColor: Color(0xFF15B86c),
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/home.svg',
              colorFilter: ColorFilter.mode(
                _currentIndex == 0 ? Color(0xFF15B86c) : Color(0xFFc6c6c6),
                BlendMode.srcIn,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/todo.svg',
              colorFilter: ColorFilter.mode(
                _currentIndex == 1 ? Color(0xFF15B86c) : Color(0xFFc6c6c6),
                BlendMode.srcIn,
              ),
            ),
            label: 'To Do',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/completed.svg',
              colorFilter: ColorFilter.mode(
                _currentIndex == 2 ? Color(0xFF15B86c) : Color(0xFFc6c6c6),
                BlendMode.srcIn,
              ),
            ),
            label: 'Completed',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/profile.svg',
              colorFilter: ColorFilter.mode(
                _currentIndex == 3 ? Color(0xFF15B86c) : Color(0xFFc6c6c6),
                BlendMode.srcIn,
              ),
            ),
            label: 'Profile',
          ),
        ],
      ),
      body: _screen[_currentIndex],
    );
  }
}
