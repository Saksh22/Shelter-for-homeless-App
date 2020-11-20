import 'package:flutter/material.dart';
import 'package:shelter_app/services/authentication.dart';
import 'package:shelter_app/components/already_have_checked.dart';
import 'package:shelter_app/components/rounded_button.dart';
import 'package:shelter_app/screens/SignUp/sign_up.dart';
import 'package:provider/provider.dart';


class Body extends StatelessWidget {


  const Body({
    Key key,
    
  }) : super(key: key);
  
  @override
  
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    Size size = MediaQuery.of(context).size;
    return Container(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.20),
            Text(
              "LOGIN",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                ),
            ),
            SizedBox(height: size.height * 0.10),
            
            SizedBox(height: size.height * 0.03),
            TextField(
                controller: emailController,
                decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                    ),
                    filled: true,
                    hintStyle: new TextStyle(color: Colors.grey[800]),
                    hintText: "Type in your text",
                    fillColor: Colors.white70),
              ),
            TextField(
                controller: passwordController,
                decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                    ),
                    filled: true,
                    hintStyle: new TextStyle(color: Colors.grey[800]),
                    hintText: "Type in your text",
                    fillColor: Colors.white70),
              ),
            RoundedButton(
              text: "LOGIN",
              press: () {
                context.read<AuthenticationService>().signIn(
                  email:emailController.text.trim(),
                  password:passwordController.text.trim(),
                  
                );
                
               
                 
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
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