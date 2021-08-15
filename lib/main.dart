import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:north_star_messenger_pro/Weather/Screens/weather_screen.dart';
// import 'Messenger/Screens/contacts_screens.dart';
import 'Messenger/Screens/welcome_screen.dart';
import 'Messenger/Screens/login_screen.dart';
import 'Messenger/Screens/signup_screen.dart';
// import 'Messenger/Screens/chat_room.dart';
import 'Messenger/Screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    NorthStarMessenger(),
  );
}

class NorthStarMessenger extends StatelessWidget {
  final _user = FirebaseAuth.instance;

  String getUserState() {
    if (_user.currentUser == null) {
      return WelcomeScreen.id;
    } else {
      return ChatScreen.id;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
        SigninScreen.id: (context) => SigninScreen(),
        // ContactsScreen.id: (context) => ContactsScreen(),
        // ChatRoomScreen.id: (context) => ChatRoomScreen(),
        ChatScreen.id: (context) => ChatScreen(
            // chatRoomId: null,
            ),
        WeatherScreen.id: (context) => WeatherScreen(),
      },
      initialRoute: getUserState(),
    );
  }
}
