// import 'package:eva_icons_flutter/eva_icons_flutter.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:fleshchat/app/Pages/widgets/card.dart';
// import 'package:fleshchat/app/Pages/widgets/drover.dart';
// import 'package:flutter/material.dart';

// class HomePages extends StatefulWidget {
//   const HomePages({Key? key}) : super(key: key);
//   static const String route = 'HomePage';

//   @override
//   _HomePagesState createState() => _HomePagesState();
// }

// class _HomePagesState extends State<HomePages> {
//   void logOut() {
//     FirebaseAuth.instance.signOut();
//   }

//   int _currentIndex = 0;
//   List<Widget> body = const [
//     Icon(EvaIcons.home),
//     Icon(EvaIcons.camera),
//     Icon(EvaIcons.phoneCallOutline),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: DefaultTabController(
//         initialIndex: 1,
//         length: 3,
//         child: Scaffold(
//           resizeToAvoidBottomInset: false,
//           drawer: Drover(key: GlobalKey()),
//           appBar: AppBar(
//             actions: [
//               IconButton(onPressed: () {}, icon: Icon(EvaIcons.bellOutline))
//             ],
//             leading: IconButton(
//                 onPressed: () {
//                   Navigator.pushNamed(context, Drover.route);
//                 },
//                 icon: Icon(EvaIcons.menuArrow)),
//             bottom: const TabBar(tabs: [
//               Tab(
//                 text: 'Chats',
//               ),
//               Tab(
//                 text: 'Status',
//               ),
//               Tab(
//                 text: 'Calls 📞',
//               ),
//             ]),
//             title: Center(
//               child: Text(
//                 'Flesh Chat ⚡',
//                 style: TextStyle(
//                     fontSize: 30,
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold),
//               ),
//             ),
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(25),
//                     bottomRight: Radius.circular(25))),
//           ),
//           body: TabBarView(children: [
//             Expanded(
//               child: ListView.builder(
//                   padding: EdgeInsets.only(),
//                   physics: BouncingScrollPhysics(
//                       decelerationRate: ScrollDecelerationRate.fast),
//                   itemCount: 10,
//                   itemBuilder: (context, index) {
//                     return ChatCard();
//                   }),
//             ),
//             Center(
//               child: Text(
//                 '⚡Status',
//                 style: TextStyle(
//                     fontSize: 30,
//                     color: Colors.blue,
//                     fontWeight: FontWeight.bold),
//               ),
//             ),
//             Center(
//               child: Text(
//                 '⚡Calls',
//                 style: TextStyle(
//                     fontSize: 30,
//                     color: Colors.blue,
//                     fontWeight: FontWeight.bold),
//               ),
//             ),
//           ]),
//         ),
//       ),
//     );
//   }
// }

//           // Center(
//           //   child: body[_currentIndex],
//           // ),
//           // bottomNavigationBar: BottomNavigationBar(
//           //   currentIndex: _currentIndex,
//           //   onTap: (int newIndex) {
//           //     setState(() {
//           //       _currentIndex = newIndex;
//           //     });
//           //   },
//           //   items: const [
//           //     BottomNavigationBarItem(label: 'home', icon: Icon(EvaIcons.home)),
//           //     BottomNavigationBarItem(
//           //         label: 'camera', icon: Icon(EvaIcons.cameraOutline)),
//           //     BottomNavigationBarItem(
//           //       label: 'Phone',
//           //       icon: Icon(EvaIcons.phoneCallOutline),
//           //     )
//           //   ],
//           // ),