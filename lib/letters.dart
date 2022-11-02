import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/home_screen1.dart';
import 'package:first_app/login_screen.dart';
import 'package:first_app/user_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:animated_background/animated_background.dart';

class Letters_screen extends StatefulWidget {
  const Letters_screen({Key key}) : super(key: key);

  @override
  _Letters_screenState createState() => _Letters_screenState();
}

class _Letters_screenState extends State<Letters_screen> {
  final _auth = FirebaseAuth.instance;
  //form key
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assest/p4.jpg"), fit: BoxFit.cover)),
      ),
    );
  }
}
