import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:north_star_messenger_pro/Components/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;

class ChatScreen extends StatefulWidget {
  static String id = './chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  late String messageText;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }
  //
  // void getMessages() async {
  //   await for (var messageSnapshot
  //       in _firestore.collection("messages").snapshots()) {
  //     for (var message in messageSnapshot.docs) {
  //       print(message.data());
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent.shade700,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            setState(() {
              Navigator.pop(context);
            });
            //Implement logout functionality
          },
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              child: Text('⚡'),
            ),
          )
          // IconButton(
          //     icon: Icon(Icons.close),
          //     onPressed: () {
          //       // getMessages();
          //       _auth.signOut();
          //       Navigator.pushNamed(context, SigninScreen.id);
          //       // //Implement logout functionality
          //     }),
        ],
        title: Text('⚡ Polaris Community'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: _firestore
                    .collection('messages')
                    .orderBy('timeStamp')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  List<MessageBubbles> messageWidgets = [];
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.blue.shade900,
                      ),
                    );
                  } else {
                    final messages = snapshot.data!.docs.reversed;

                    for (var message in messages) {
                      final messageText = message.data()["message"];
                      final messageSender = message.data()['sender'];
                      final currentUser = loggedInUser.email;
                      // if (currentUser == messageSender) {
                      //   isMe = true;
                      // }
                      final messageWidget = MessageBubbles(
                        messageSender: messageSender,
                        textMessage: messageText,
                        isMe: currentUser == messageSender,
                      );
                      messageWidgets.add(messageWidget);
                    }
                  }
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListView(reverse: true, children: messageWidgets),
                    ),
                  );
                }),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.camera_alt_outlined),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: messageTextController,
                        onSubmitted: (grand) {
                          messageTextController.clear();
                          _firestore.collection("messages").add(
                            {
                              'timeStamp': DateTime.now(),
                              'sender': loggedInUser.email,
                              'message': messageText
                            },
                          );
                        },
                        onChanged: (value) {
                          setState(() {
                            messageText = value;
                          });
                        },
                        decoration: kMessageTextFieldDecoration.copyWith(
                          suffixIcon: GestureDetector(
                            onTap: () {},
                            child: Icon(
                              Icons.mic,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      messageTextController.clear();
                      _firestore.collection("messages").add(
                        {
                          'timeStamp': DateTime.now(),
                          'sender': loggedInUser.email,
                          'message': messageText
                        },
                      );
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBubbles extends StatelessWidget {
  MessageBubbles(
      {required this.messageSender,
      required this.textMessage,
      required this.isMe});
  late final String textMessage;
  late final String messageSender;
  late final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            messageSender,
            style: TextStyle(fontSize: 12.0),
          ),
        ),
        Material(
          elevation: 10,
          color: isMe ? Colors.lightBlueAccent.shade400 : Colors.grey.shade600,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomLeft: isMe ? Radius.circular(30) : Radius.circular(0),
            bottomRight: isMe ? Radius.circular(0) : Radius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              textMessage,
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ),
      ],
    );
  }
}
