// import 'package:flutter/material.dart';
// import 'package:north_star_messenger_pro/Components/init_textfields.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:north_star_messenger_pro/Messenger/Screens/chat_screen.dart';
//
// final _firestore = FirebaseFirestore.instance;
// late String contactUserName;
//
// class ContactsScreen extends StatefulWidget {
//   static String id = "contactsScreen";
//   String getMessageId() {
//     return getChatRoomId(contactUserName, "correntUser");
//   }
//
//   @override
//   _ContactsScreenState createState() => _ContactsScreenState();
// }
//
// class _ContactsScreenState extends State<ContactsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text("New Chat"),
//           centerTitle: true,
//         ),
//         body: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: TextField(
//                 onChanged: (searchValue) {},
//                 decoration: inputDecorations.copyWith(
//                     contentPadding: EdgeInsets.all(8),
//                     prefixIcon: Icon(Icons.search),
//                     hintText: "Search"),
//               ),
//             ),
//             Expanded(
//               child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
//                 stream: _firestore
//                     .collection("users")
//                     .orderBy("userName")
//                     .snapshots(),
//                 builder: (BuildContext context,
//                     AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
//                         snapshot) {
//                   List<Widget> contactWidgets = [];
//                   if (!snapshot.hasData) {
//                     return Center(
//                       child: CircularProgressIndicator(
//                         backgroundColor: Colors.blue.shade900,
//                       ),
//                     );
//                   } else {
//                     final contacts = snapshot.data!.docs.reversed;
//                     for (var contact in contacts) {
//                       final userName = contact.data()["userName"];
//                       final userEmail = contact.data()["userEmail"];
//                       // final currentUser = loggedInUser.email;
//
//                       final contactWidget = ElevatedButton(
//                         style: ButtonStyle(
//                           backgroundColor:
//                               MaterialStateProperty.all(Colors.white),
//                           elevation: MaterialStateProperty.all(20),
//                           shadowColor: MaterialStateProperty.all(Colors.black),
//                         ),
//                         onPressed: () {
//                           print(_firestore.collection("users").id);
//                           setState(() {
//                             print(userName);
//                             contactUserName = userName!;
//                             Navigator.pushNamed(context, ChatScreen.id);
//                           });
//                         },
//                         child: ContactCards(
//                           userName: userName,
//                           eMail: userEmail,
//                         ),
//                       );
//
//                       contactWidgets.add(contactWidget);
//                     }
//                     return Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 3.0, vertical: 1),
//                       child: ListView(reverse: false, children: contactWidgets),
//                     );
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class ContactCards extends StatelessWidget {
//   ContactCards({
//     required this.userName,
//     required this.eMail,
//   });
//   late final String? userName;
//   late final String? eMail;
//   late final Image? profileImage = null;
//   getDP() {
//     if (profileImage == null) {
//       return Icon(Icons.person);
//     } else {
//       return profileImage;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 1.0),
//       child: Padding(
//         padding: const EdgeInsets.all(1.0),
//         child: ListTile(
//           leading: CircleAvatar(
//             child: getDP(),
//           ),
//           title:
//               Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             Text(
//               userName!,
//               style: TextStyle(fontSize: 20.0),
//             ),
//             Text(
//               eMail!,
//               style: TextStyle(fontSize: 20.0),
//             ),
//           ]),
//         ),
//       ),
//     );
//   }
// }
//
// getChatRoomId(String a, String b) {
//   if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
//     return "$b\_$a";
//   } else {
//     return "$a\_$b";
//   }
// }
