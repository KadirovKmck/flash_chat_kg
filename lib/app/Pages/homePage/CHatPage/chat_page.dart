import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fleshchat/app/Pages/modul/ChatModel.dart';
import 'package:fleshchat/app/Pages/widgets/contener_login.dart';
import 'package:flutter/material.dart';

class chatPage extends StatefulWidget {
  const chatPage({super.key});

  @override
  State<chatPage> createState() => _chatPageState();
}

final _formfield = GlobalKey<FormState>();
final smsMesseges = TextEditingController();
final Sms = FirebaseFirestore.instance.collection('Sms');
Future<void> addSms() {
  return Sms.add(ChatModels().toJson())
      .then((value) => print("User Sms Added"))
      .catchError((error) => print("Failed to add user sms: $error"));
}

class _chatPageState extends State<chatPage> {
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
              SizedBox(
                height: 70,
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
                            addSms();
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
