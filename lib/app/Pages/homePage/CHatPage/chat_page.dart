import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fleshchat/app/Pages/modul/ChatModel.dart';
import 'package:fleshchat/app/Pages/modul/usersModuls/userModuls.dart';
import 'package:fleshchat/app/Pages/widgets/contener_login.dart';
import 'package:flutter/material.dart';

class CChatPage extends StatefulWidget {
  const CChatPage({super.key, this.userModel});

  static const String route = 'CChatPage';
  final UrModels? userModel;

  @override
  State<CChatPage> createState() => _CChatPageState();
}

class _CChatPageState extends State<CChatPage> {
  final _formfield = GlobalKey<FormState>();
  final smsMesseges = TextEditingController();
  final Sms = FirebaseFirestore.instance.collection('Sms');
  Future<void> addSms(String sms) {
    final chatModols = ChatModels(
      userName: widget.userModel!.name,
      senderId: widget.userModel!.id,
      creattedTime: Timestamp.now(),
      sms: sms,
      sender: widget.userModel!.email,
    );
    return Sms.add(chatModols.toJson())
        .then((value) => print("User Sms Added"))
        .catchError((error) => print("Failed to add user sms: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formfield,
          child: Column(
            children: [
              WidgetContener(
                text: 'Flash Chat⚡',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: SizedBox(
                  height: 70,
                ),
              ),
              Center(
                child: TextFormField(
                  controller: smsMesseges,
                  cursorHeight: 45,
                  obscureText: false,
                  decoration: InputDecoration(
                      hintText: 'enter your masseges',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey, width: 4)),
                      labelText: 'enter your masseges',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      focusColor: Colors.black,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {
                            addSms(smsMesseges.text);
                          },
                          icon: Icon(EvaIcons.paperPlaneOutline))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "enter your masseges";
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
