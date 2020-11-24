import 'package:flutter/material.dart';

import '../constraints.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      appBar: AppBar(
        title: Text("About Us"),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: 
      Container(
        child:Padding( 
          padding:EdgeInsets.all(12), 
       child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Colors.pink,
      elevation: 10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const ListTile(
            title: Text('Welcome to WeShelter', style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              )),
            subtitle: Text('Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus " \n\n An App By\n Sakshi Khochare\n Meera Ghaskadvi \n Rozebud Gonsalves\n', 
            style: TextStyle(color: Colors.white,fontSize: 20)),
            
          ),
        ],

      ),
        ),
      ),
      ),
    );
  }
}