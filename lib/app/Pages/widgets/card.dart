import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fleshchat/app/Pages/homePage/CHatPage/chat_page.dart';
import 'package:flutter/material.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      width: 450,
      height: 100,
      padding: new EdgeInsets.all(10.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        color: Colors.orange,
        elevation: 10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(
                EvaIcons.paperPlaneOutline,
                size: 60,
                color: Colors.black,
              ),
              title: Center(
                child: Text(
                  'Chat',
                  style: TextStyle(fontSize: 30.0, color: Colors.black),
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CChatPage()));
              },
            ),
          ],
        ),
      ),
    ));
  }
}
