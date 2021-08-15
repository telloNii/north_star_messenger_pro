import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:north_star_messenger/components/material_button.dart';
import 'package:north_star_messenger/screens/chat_screen.dart';
import 'package:north_star_messenger/screens/login_screen.dart';
import 'package:north_star_messenger/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = './registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  late String email;
  late String password;
  bool obscureText = true;
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
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          "Create your Account",
                          style: TextStyle(fontSize: 40.0),
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
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        TextField(
                          textAlign: TextAlign.center,
                          obscureText: obscureText,
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
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
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                        MaterialButtons(
                          onPressed: () async {
                            setState(() {
                              showSpinner = true;
                            });
                            try {
                              await _auth.createUserWithEmailAndPassword(
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
                          childText: 'Sign Up',
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                              Navigator.pushNamed(context, LoginScreen.id);
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
    // TODO: implement dispose
    super.dispose();
    showSpinner = false;
  }
}
