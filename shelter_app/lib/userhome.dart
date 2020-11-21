import 'package:flutter/material.dart';


class UserHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("HOME"),
            RaisedButton(
              onPressed: () {

              },
              child: Text("Sign out"),
            ),
          ],
        ),
      ),
    );
  }
}