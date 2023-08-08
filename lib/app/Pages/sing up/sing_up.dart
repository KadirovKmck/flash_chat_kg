import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fleshchat/app/Pages/homePage/CHatPage/chat_page.dart';
import 'package:fleshchat/app/Pages/modul/usersModuls/userModuls.dart';
import 'package:fleshchat/app/Pages/widgets/contener_login.dart';
import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});
  static const String route = 'SingUp';

  @override
  State<LogIn> createState() => LogInState();
}

class LogInState extends State<LogIn> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final sizedBox = SizedBox(
    height: 30,
  );
  void singIn() async {
    final UserCredential credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
    getUser(credential.user!.uid);
  }

  Future<void> getUser(String? uid) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    final data = await users.doc(uid).get();
    final urModels = UrModels.fromJson(data.data() as Map<String, dynamic>);
    log('data---> $data');
    log('User Model ---> $urModels');
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CChatPage(
                  userModel: urModels,
                )));
  }

  bool passOff = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              WidgetContener(
                text: 'Log In Flash Chat⚡',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                height: 250,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.text,
                    cursorHeight: 45,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: 'Emter your email ',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey, width: 4)),
                      labelText: 'Emter your email ',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      focusColor: Colors.black,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black)),
                      prefixIcon: Icon(EvaIcons.emailOutline),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Email";
                      }
                      final bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value);
                      if (!emailValid) {
                        return "Enter Valid Email";
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    cursorHeight: 45,
                    obscureText: passOff,
                    decoration: InputDecoration(
                        hintText: 'Emter your Password ',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 4)),
                        labelText: 'Emter your Password ',
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                        focusColor: Colors.black,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black)),
                        prefixIcon: Icon(EvaIcons.lock),
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              passOff = !passOff;
                            });
                          },
                          child: Icon(passOff
                              ? EvaIcons.eyeOffOutline
                              : EvaIcons.eyeOutline),
                        )),
                    validator: (value) {
                      if (passwordController.text.length < 6) {
                        return "Your password is slow";
                      }
                      return null;
                    },
                  ),
                ),
              ),
              sizedBox,
              InkWell(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    singIn();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CChatPage()));
                  }
                },
                child: Container(
                    width: 360,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Center(
                        child: Text(
                      'Log In ⚡',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
