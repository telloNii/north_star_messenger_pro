import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:north_star_messenger_pro/Components/init_textfields.dart';
import 'package:north_star_messenger_pro/Components/material_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:north_star_messenger_pro/Messenger/Screens/login_screen.dart';

import 'chat_screen.dart';

final _firebase = FirebaseFirestore.instance;
late String _email;
late String _password;
late String _userName;

class SignUpScreen extends StatefulWidget {
  static String id = "signupScreen";

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;

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
    return Scaffold(
      body: Container(
        color: Colors.grey.shade600,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.580,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.grey.shade800),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "Sign Up",
                            style: TextStyle(fontSize: 30.0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 8.0),
                          child: TextField(
                              onChanged: (userNameValue) {
                                setState(() {
                                  _userName = userNameValue;
                                });
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: inputDecorations.copyWith(
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Colors.white,
                                  ),
                                  hintText: "Enter your Username")),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 5.0),
                          child: TextField(
                              onChanged: (emailValue) {
                                setState(() {
                                  _email = emailValue;
                                });
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: inputDecorations.copyWith(
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Colors.white,
                                  ),
                                  hintText: "Enter your Email address")),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 8.0),
                          child: TextField(
                            onChanged: (passwordValue) {
                              setState(() {
                                _password = passwordValue;
                              });
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
                          padding: const EdgeInsets.only(top: 1.0),
                          child: MaterialButtons(
                            onPressed: () async {
                              await _auth.createUserWithEmailAndPassword(
                                  email: _email, password: _password);
                              Navigator.pushNamed(context, ChatScreen.id);
                              _firebase.collection("users").add({
                                "userName": _userName,
                                "userEmail": _email,
                              });
                            },
                            color: Colors.white,
                            childText: "Sign Up",
                            textColor: Colors.black,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: Text(
                              "By clicking Sign up, you to our terms of service and privacy policy"),
                        ),
                        Divider(
                          height: 5.0,
                          color: Colors.black,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, SigninScreen.id);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Already have an account?"),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text("Login")
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
