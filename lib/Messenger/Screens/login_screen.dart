import 'package:flutter/material.dart';
import 'package:north_star_messenger_pro/Components/init_textfields.dart';
import 'package:north_star_messenger_pro/Components/material_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:north_star_messenger_pro/Messenger/Screens/signup_screen.dart';

import 'chat_screen.dart';

class SigninScreen extends StatefulWidget {
  static String id = "signinScreen";

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _auth = FirebaseAuth.instance;

  late String email;
  late String password;
  bool obscurePasswordText = true;
  Widget passwordVisibility() {
    if (obscurePasswordText == true) {
      return IconButton(
        onPressed: () {
          setState(() {
            obscurePasswordText = false;
          });
        },
        icon: Icon(Icons.visibility),
      );
    } else {
      return IconButton(
        onPressed: () {
          setState(() {
            obscurePasswordText = true;
          });
        },
        icon: Icon(Icons.visibility_off),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(color: Colors.grey.shade600),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.52,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.grey.shade800),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              "Sign In",
                              style: TextStyle(fontSize: 30.0),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 8.0),
                            child: TextFormField(
                                onChanged: (emailValue) {
                                  setState(() {
                                    email = emailValue;
                                  });
                                },
                                keyboardType: TextInputType.emailAddress,
                                decoration: inputDecorations.copyWith(
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: Colors.white,
                                    ),
                                    hintText:
                                        "Enter your Email address or Username")),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 8.0),
                            child: TextFormField(
                              onChanged: (passwordValue) {
                                password = passwordValue;
                              },
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: obscurePasswordText,
                              decoration: inputDecorations.copyWith(
                                prefixIcon: Icon(
                                  Icons.password,
                                  color: Colors.white,
                                ),
                                hintText: "Enter your password",
                                suffixIcon: passwordVisibility(),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 230.0,
                              top: 6.0,
                              bottom: 6.0,
                            ),
                            child: GestureDetector(
                              onTap: () {},
                              child: Text("forgot Password?"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: MaterialButtons(
                              onPressed: () async {
                                await _auth.signInWithEmailAndPassword(
                                    email: email, password: password);

                                Navigator.pushNamed(context, ChatScreen.id);
                              },
                              color: Colors.white,
                              childText: "Sign In",
                              textColor: Colors.black,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, SignUpScreen.id);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Don't have an account?"),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text("Sign up")
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
