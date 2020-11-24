import 'package:flutter/material.dart';
import 'package:shelter_app/components/rounded_button.dart';
import 'package:shelter_app/constraints.dart';
import 'package:shelter_app/pages/login.dart';
import 'package:shelter_app/pages/register.dart';
import 'package:shelter_app/screens/Welcome/components/background.dart';


class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.09),
            Text(
              "WELCOME TO WeSHELTER",
              
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                height: 5,
          
                ),
            ),
            SizedBox(height: 10),
            Image.asset(
              'images/welcome.jpg',
              height: 200,
              width: 200,
            ),
            
            
            SizedBox(height: 10),
            RoundedButton(
              text: "LOGIN",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Login();
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: "SIGN UP",
              color: kPrimaryLightColor,
              textColor: Colors.black,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Register();
                    },
                  ),
                );
              },
            ),
          ],
        ),
        
      ),
    );
  }
}