import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:north_star_messenger_pro/Components/material_buttons.dart';
import 'package:north_star_messenger_pro/Messenger/Screens/login_screen.dart';
import 'package:north_star_messenger_pro/Messenger/Screens/signup_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);
    controller.forward();
    // animation.addStatusListener(
    //   (status) {
    //     if (status == AnimationStatus.completed ||
    //         status == AnimationStatus.dismissed) {
    //       Navigator.pushNamed(context, SignUpScreen.id);
    //     }
    //   },
    // );
    controller.addListener(
      () {
        setState(() {});
      },
    );
  }

  Widget welcomeScreenAnimation() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 220.0),
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextLiquidFill(
                    loadUntil: 0.50,
                    text: 'NorthStar',
                    boxWidth: animation.value * 200,
                    waveColor: Colors.blueAccent,
                    waveDuration: Duration(seconds: 3),
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: animation.value * 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                    boxHeight: animation.value * 80.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: (3 / 5) * MediaQuery.of(context).size.height,
                child: Center(
                  child: Text(
                    "⚡",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.25,
                    ),
                  ),
                )),
            Text(
              "North Star Messenger",
              style: TextStyle(fontSize: 30),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                "Bring you closer to your friends. Share breath taking moments with loved ones, Bring together your files, your tools, your progects and your people",
                style: TextStyle(color: Color(0xFF716F7B), fontSize: 20),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButtons(
                      onPressed: () {
                        Navigator.pushNamed(context, SignUpScreen.id);
                      },
                      color: Colors.white,
                      childText: "Register",
                      textColor: Colors.black,
                    ),
                    MaterialButtons(
                      onPressed: () {
                        Navigator.pushNamed(context, SigninScreen.id);
                      },
                      color: Color(0xFF716F7B),
                      childText: "Sign In",
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
