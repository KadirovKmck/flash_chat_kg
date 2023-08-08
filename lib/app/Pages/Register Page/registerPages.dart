import 'dart:developer';
import 'dart:io';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fleshchat/app/Pages/Class/constants/color.dart';
import 'package:fleshchat/app/Pages/homePage/CHatPage/chat_page.dart';
import 'package:fleshchat/app/Pages/modul/usersModuls/userModuls.dart';
import 'package:fleshchat/app/Pages/widgets/contener_login.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    super.key,
  });
  static const String route = 'RegisterPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formfield = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  XFile? _imageFile;
  dynamic _picKetImageEror;
  late String _profileImage;
  final ImagePicker _picker = ImagePicker();
// Future<void> addUsers()async{

// }
  final users = FirebaseFirestore.instance.collection('users');
  final _auth = FirebaseAuth.instance;
  Future<void> UModels() {
    final _userModels = UrModels(
        email: emailController.text,
        name: nameController.text,
        id: _auth.currentUser!.uid);
    return users
        .doc(_auth.currentUser!.uid)
        .set(
          _userModels.toJson(),
        )
        .then((value) => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CChatPage(userModel: _userModels)))
            })
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> registerApp() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          )
          .then((value) => {
                UModels(),
                nameController.clear(),
                emailController.clear(),
                passwordController.clear(),
                confirmController.clear(),
              });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {}
  }

  void _pickImageFromCamera() async {
    final _pickedImage = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 95,
        maxHeight: 300,
        maxWidth: 300);
    setState(() {
      _imageFile = _pickedImage;
    });
  }

  void _pickImageFromGallery() async {
    final _pickedImage = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 95,
        maxHeight: 300,
        maxWidth: 300);
    setState(() {
      _imageFile = _pickedImage;
    });
  }

  bool passwordOff = false;
  bool confirmoff = false;

  final sizedBox = SizedBox(
    height: 10,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Form(
          key: _formfield,
          child: Column(
            children: [
              WidgetContener(
                text: 'Sin Up Flash Chat⚡',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 70,
              ),
              Row(
                children: [
                  // CircleAvatar purpleAccont
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 30,
                      horizontal: 40,
                    ),
                    child: CircleAvatar(
                      backgroundImage: _imageFile == null
                          ? null
                          : FileImage(
                              File(_imageFile!.path),
                            ),
                      radius: 60,
                      backgroundColor: AppColors.purpleAccent,
                    ),
                  ),
                  Column(
                    children: [
                      // top camera icon
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.purple,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.camera_alt,
                            color: AppColors.white,
                          ),
                          onPressed: () {
                            _pickImageFromCamera();
                            log('Pick image from camera');
                          },
                        ),
                      ),
                      SizedBox(height: 6.0),
                      // bottom camera icon
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.purple,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.photo,
                            color: AppColors.white,
                          ),
                          onPressed: () {
                            _pickImageFromGallery();
                            log('Pick image from gallery');
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  controller: nameController,
                  cursorHeight: 45,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: 'enter your name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey, width: 4)),
                    labelText: 'enter your name',
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    focusColor: Colors.black,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "enter your name";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  controller: emailController,
                  cursorHeight: 45,
                  obscureText: false,
                  decoration: InputDecoration(
                      hintText: 'enter your email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey, width: 4)),
                      labelText: 'enter your email',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      focusColor: Colors.black,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black)),
                      prefixIcon: Icon(EvaIcons.emailOutline)),
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return "Enter Email";
                  //   }
                  //   final bool emailValid = RegExp(
                  //           r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[gmail]+\.[com]]+")
                  //       .hasMatch(value);
                  //   if (!emailValid) {
                  //     return "Enter Valid Email";
                  //   }
                  // },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  controller: passwordController,
                  cursorHeight: 45,
                  obscureText: passwordOff,
                  decoration: InputDecoration(
                    hintText: 'enter your password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey, width: 4)),
                    labelText: 'enter your password',
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
                          passwordOff = !passwordOff;
                        });
                      },
                      child: Icon(passwordOff
                          ? EvaIcons.eyeOffOutline
                          : EvaIcons.eyeOutline),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Your Passcord";
                    } else if (passwordController.text.length < 6) {
                      return "Password Length Should be more than 6 characters";
                    }
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  controller: confirmController,
                  cursorHeight: 45,
                  obscureText: confirmoff,
                  decoration: InputDecoration(
                    hintText: 'enter your password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey, width: 4)),
                    labelText: 'enter your password',
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    focusColor: Colors.black,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black)),
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          confirmoff = !confirmoff;
                        });
                      },
                      child: Icon(confirmoff
                          ? EvaIcons.eyeOffOutline
                          : EvaIcons.eyeOutline),
                    ),
                  ),
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return "Enter Your Confirm Password";
                  //   } else if (value != passwordController) {
                  //     return "Password Length Should be more than 6 characters";
                  //   }
                  // },
                ),
              ),
              sizedBox,
              InkWell(
                onTap: () {
                  if (_formfield.currentState!.validate()) {
                    registerApp();
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
                      ' Register⚡',
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
