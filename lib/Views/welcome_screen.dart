import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasks_app/Views/Home/home_screen.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});
  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFF181818),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: h * .044),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/Vector.svg',
                        width: 42,
                        height: 42,
                      ),
                      SizedBox(width: 16),
                      Text(
                        'TASKY',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 28,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 108),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome To TASKY',
                        style: TextStyle(
                          color: Color(0xFFFFFcFc),
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 20),
                      SvgPicture.asset(
                        'assets/images/wavingHand.svg',
                        width: 30,
                        height: 30,
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Your productivity journey starts here',
                    style: TextStyle(
                      color: Color(0xFFFFFcFc),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 20),
                  SvgPicture.asset(
                    'assets/images/pana.svg',
                    width: 215,
                    height: 200,
                  ),
                  SizedBox(height: 30),
                  Align(
                    alignment: AlignmentGeometry.centerLeft,
                    child: Text(
                      "Full Name",
                      style: TextStyle(
                        color: Color(0xFFFFFcFc),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: controller,
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                    style: TextStyle(color: Color(0xFFFFFcFc)),
                    decoration: InputDecoration(
                      hintText: 'e.g Celia Tarek',
                      filled: true,
                      fillColor: Color(0xff282828),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    cursorColor: Color(0xFFFFFcFc),
                  ),
                  SizedBox(height: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: (Color(0xFF15B86c)),
                      fixedSize: Size(w, h * .06),
                    ),
                    onPressed: () {
                      if (_key.currentState?.validate() ?? false) {
                        Navigator.push(
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
                      "Let's Get Started",
                      style: TextStyle(
                        color: Color(0xFFFFFcFc),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
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
