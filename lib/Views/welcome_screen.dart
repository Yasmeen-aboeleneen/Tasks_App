import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF181818),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 12),
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
                TextField(
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
                    fixedSize: Size(330, 40),
                  ),
                  onPressed: () {},
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
    );
  }
}
