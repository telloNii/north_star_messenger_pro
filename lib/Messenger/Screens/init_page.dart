import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = './welcome_screen';
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
    animation.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed ||
            status == AnimationStatus.dismissed) {
          if (FirebaseAuth.instance.currentUser != null) {
            Navigator.pushNamed(context, ChatScreen.id);
          } else {
            Navigator.pushNamed(context, WelcomeScreen.id);
          }
        }
      },
    );
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
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: animation.value * 200,
                  ),
                ),
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
    return welcomeScreenAnimation();
    //   Scaffold(
    //   backgroundColor: Colors.white,
    //   body: Padding(
    //     padding: EdgeInsets.symmetric(horizontal: 24.0),
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       crossAxisAlignment: CrossAxisAlignment.stretch,
    //       children: <Widget>[
    //         Container(
    //           height: 100.0,
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: <Widget>[
    //               Hero(
    //                 tag: 'logo',
    //                 child: Container(
    //                   child: Image.asset('images/logo.png'),
    //                   height: animation.value * 100,
    //                 ),
    //               ),
    //               Expanded(
    //                 child: TextLiquidFill(
    //                   text: 'NorthStar',
    //                   boxWidth: 200.0,
    //                   waveColor: Colors.blueAccent,
    //                   waveDuration: Duration(seconds: 3),
    //                   textStyle: TextStyle(
    //                     color: Colors.black,
    //                     fontSize: 40.0,
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                   boxHeight: 150.0,
    //                 ),
    //               ),
    //               // Text(
    //               //   'NorthStar ',
    //               //   style: TextStyle(
    //               //     fontSize: 45.0,
    //               //     fontWeight: FontWeight.w900,
    //               //     color: Colors.black,
    //               //   ),
    //               // ),
    //             ],
    //           ),
    //         ),
    //         SizedBox(
    //           height: 48.0,
    //         ),
    //         MaterialButtons(
    //           onPressed: () {
    //             Navigator.pushNamed(
    //               context,
    //               LoginScreen.id,
    //             );
    //           },
    //           color: Colors.black,
    //           childText: 'Log In',
    //         ),
    //         MaterialButtons(
    //             onPressed: () {
    //               Navigator.pushNamed(context, RegistrationScreen.id);
    //             },
    //             color: Colors.black,
    //             childText: ' Sign Up'),
    //       ],
    //     ),
    //   ),
    // );
  }
}
