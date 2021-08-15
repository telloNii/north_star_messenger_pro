import 'package:flutter/material.dart';
import 'package:north_star_messenger/components/material_button.dart';
import 'package:north_star_messenger/screens/registration_screen.dart';
import 'package:north_star_messenger/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';
import 'registration_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static String id = './login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  late String email;
  late String password;
  late bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/starsbackground.jpg'),
                fit: BoxFit.cover),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Color(0x99ffffff),
                      borderRadius: BorderRadius.circular(30)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          "Sign in",
                          style: TextStyle(fontSize: 50.0),
                        ),
                        SizedBox(
                          height: 48.0,
                        ),
                        TextField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                          decoration: textField.copyWith(
                              icon: Icon(Icons.mail),
                              hintText:
                                  "Enter your email address or phone number"),
                          onSubmitted: (submit) async {
                            setState(() {
                              showSpinner = true;
                            });
                            try {
                              await _auth.signInWithEmailAndPassword(
                                  email: email, password: password);

                              Navigator.pushNamed(context, ChatScreen.id);
                              setState(() {
                                showSpinner = false;
                              });
                            } catch (e) {
                              print(e);
                            }
                          },
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        TextField(
                          textAlign: TextAlign.center,
                          obscureText: obscureText,
                          onChanged: (value) {
                            setState(
                              () {
                                password = value;
                              },
                            );
                          },
                          decoration: textField.copyWith(
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(
                                    () {
                                      if (obscureText == true) {
                                        obscureText = false;
                                      } else {
                                        obscureText = true;
                                      }
                                    },
                                  );
                                },
                                child: Icon(Icons.remove_red_eye),
                              ),
                              icon: Icon(Icons.password),
                              hintText: "Enter your password"),
                          onSubmitted: (submit) async {
                            setState(() {
                              showSpinner = true;
                            });
                            try {
                              await _auth.signInWithEmailAndPassword(
                                  email: email, password: password);

                              Navigator.pushNamed(context, ChatScreen.id);
                              setState(() {
                                showSpinner = false;
                              });
                            } catch (e) {
                              print(e);
                            }
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 16.0, top: 8.0, bottom: 6.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _auth.sendPasswordResetEmail(email: email);
                                },
                                child: Text(
                                  "Forgot password",
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                        ),
                        MaterialButtons(
                          onPressed: () async {
                            setState(() {
                              showSpinner = true;
                            });
                            try {
                              await _auth.signInWithEmailAndPassword(
                                  email: email, password: password);

                              Navigator.pushNamed(context, ChatScreen.id);
                              setState(() {
                                showSpinner = false;
                              });
                            } catch (e) {
                              print(e);
                            }
                          },
                          color: Colors.black,
                          childText: 'Sign in',
                        ),
                        Divider(
                          height: 5.0,
                          color: Colors.black,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, RegistrationScreen.id);
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
                )
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
    showSpinner = false;
  }
}
