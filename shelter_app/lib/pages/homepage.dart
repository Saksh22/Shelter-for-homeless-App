import 'package:flutter/material.dart';
import 'package:shelter_app/loading.dart';
import 'package:shelter_app/pages/welcome.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool start = false;

  Future<void> splash() async {
    await Future.delayed(Duration(seconds: 5));
    setState(() {
      start = true;
    });
  }

  @override
  void initState() {
    splash();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (start == false) {
      return Loading();
    } else {
      return WelcomeScreen();
      }
    }
  }



