// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:north_star_messenger_pro/Components/init_textfields.dart';
// import 'package:north_star_messenger_pro/Messenger/Screens/chat_screen.dart';
// import 'package:north_star_messenger_pro/Messenger/Screens/login_screen.dart';
// // import 'package:north_star_messenger_pro/Messenger/Screens/contacts_screens.dart';
// import 'package:north_star_messenger_pro/Messenger/Services/search_service.dart';
//
// final _auth = FirebaseAuth.instance;
// final _firestore = FirebaseFirestore.instance;
// late String contactEmail;
// late String contactUserName;
// String? getMessageId() {
//   return getChatRoomId(contactEmail, _auth.currentUser!.email);
// }
//
// class ChatRoomScreen extends StatefulWidget {
//   static String id = "chatRoomScreen";
//   String? getMessageId() {
//     return getChatRoomId(contactEmail, "correntUser");
//   }
//
//   @override
//   _ChatRoomScreenState createState() => _ChatRoomScreenState();
// }
//
// class _ChatRoomScreenState extends State<ChatRoomScreen> {
//   var queryResultSet = [];
//   var tempSearchStore = [];
//
//   initiateSearch(value) {
//     if (value.length == 0) {
//       setState(() {
//         queryResultSet = [];
//         tempSearchStore = [];
//       });
//     }
//
//     var capitalizedValue =
//         value.substring(0, 1).toUpperCase() + value.substring(1);
//
//     if (queryResultSet.length == 0 && value.length == 1) {
//       SearchService().searchByName(value).then((QuerySnapshot docs) {
//         for (int i = 0; i < docs.docs.length; ++i) {
//           queryResultSet.add(docs.docs[i].data);
//         }
//       });
//     } else {
//       tempSearchStore = [];
//       queryResultSet.forEach((element) {
//         if (element['businessName'].startsWith(capitalizedValue)) {
//           setState(() {
//             tempSearchStore.add(element);
//           });
//         }
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         // bottomNavigationBar: BottomNavigationBar(
//         //   selectedItemColor: Colors.red,
//         //   unselectedItemColor: Colors.grey.shade600,
//         //   selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
//         //   unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
//         //   type: BottomNavigationBarType.fixed,
//         //   items: [
//         //     BottomNavigationBarItem(
//         //       icon: Icon(Icons.message),
//         //       label: "Chats",
//         //     ),
//         //     BottomNavigationBarItem(
//         //       icon: Icon(Icons.group_work),
//         //       label: "Channels",
//         //     ),
//         //     BottomNavigationBarItem(
//         //       icon: Icon(Icons.account_box),
//         //       label: "Profile",
//         //     ),
//         //   ],
//         // ),
//         body: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 children: [
//                   CircleAvatar(
//                     radius: 24,
//                     backgroundColor: Colors.red.shade900,
//                   ),
//                   SizedBox(
//                     width: 12,
//                   ),
//                   Expanded(
//                     child: TextField(
//                       onSubmitted: (searchSubmit) {},
//                       onChanged: (searchValue) {
//                         initiateSearch(searchValue);
//                       },
//                       decoration: inputDecorations.copyWith(
//                           contentPadding: EdgeInsets.all(8),
//                           prefixIcon: Icon(Icons.search),
//                           hintText: "Search"),
//                     ),
//                   ),
//                   IconButton(
//                       onPressed: () {
//                         _auth.signOut();
//                         Navigator.pushNamed(context, SigninScreen.id);
//                       },
//                       icon: Icon(Icons.exit_to_app))
//                 ],
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
//                           setState(() {
//                             contactUserName = userEmail;
//                             contactEmail = userEmail;
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
//         //
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             // Navigator.pushNamed(context, ContactsScreen.id);
//           },
//           child: Icon(Icons.add),
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
//   Widget returnWidget() {
//     if (eMail == _auth.currentUser!.email) {
//       return Padding(
//         padding: EdgeInsets.zero,
//       );
//     } else {
//       return Padding(
//         padding: const EdgeInsets.symmetric(vertical: 1.0),
//         child: Padding(
//           padding: const EdgeInsets.all(1.0),
//           child: ListTile(
//             leading: CircleAvatar(
//               child: getDP(),
//             ),
//             title:
//                 Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//               Text(
//                 userName!,
//                 style: TextStyle(fontSize: 20.0),
//               ),
//               Text(
//                 eMail!,
//                 style: TextStyle(fontSize: 20.0),
//               ),
//             ]),
//           ),
//         ),
//       );
//     }
//   }
//
//   // I/flutter ( 8749): Tello_nii@outlook.com_tello_nii@outlook.com
//   // I/flutter ( 8749): robertaakoto@outlook.com_tello_nii@outlook.com
//   @override
//   Widget build(BuildContext context) {
//     return returnWidget();
//   }
// }
//
// getChatRoomId(String? a, String? b) {
//   if (a!.substring(0, 4).codeUnitAt(0) > b!.substring(0, 4).codeUnitAt(0)) {
//     return "$b\_$a";
//   } else {
//     return "$a\_$b";
//   }
// }
