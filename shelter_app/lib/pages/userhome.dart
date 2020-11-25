import 'package:flutter/material.dart';
import 'package:shelter_app/constraints.dart';
import 'package:shelter_app/pages/about_us.dart';
import 'package:shelter_app/pages/helpline_page.dart';
import 'package:shelter_app/pages/login.dart';
import 'package:shelter_app/pages/map2.dart';
import 'package:shelter_app/pages/userprofile.dart';
import 'package:shelter_app/pages/welcome.dart';
import 'map1.dart';
import 'package:firebase_auth/firebase_auth.dart';



class UserHome extends StatefulWidget {

  // ignore: non_constant_identifier_names

  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<bool>signOut() async {
    await _firebaseAuth.signOut();
    return true;
   }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kPrimaryColor,
          centerTitle: true,
          title: Text(
            'Welcome to WeShelter',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white70,
            ),
          ),
          actions: <Widget>[
                FlatButton(
                  textColor: Colors.white,
                  onPressed: () async{
                    bool result = await signOut();
                            if (result) {
                              Navigator.pop(context);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WelcomeScreen(),
                                  ));
                            }

                    
                  },
                  child: Text("Logout"),
                  shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
                ),
              ],
          
        ),
        backgroundColor: Color.fromARGB(255,21, 21, 21),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                                    height: 20.0,
                                  ),
              
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: Wrap(
                    spacing:20,
                    runSpacing: 20.0,
                    children: <Widget>[

                      SizedBox(
                        width:340.0,
                        height: 140.0,
                        child: 
                        
                        InkWell(
                          onTap: (){
                            
                            Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return HomeView();
                      },
                    ),
                  );

                          },
                           child: Card(
                            color: Colors.blue,
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)
                            ),
                            child:Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Icon(Icons.account_circle, color: Colors.white,size: 52.0,),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "My Profile",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0
                                    ),
                                  ),
                                 
                                  
                                ],
                                ),
                              )
                            ),
                          ),
                        ),
                      ),


                      SizedBox(
                        width:160.0,
                        height: 160.0,
                        child: 
                        
                        InkWell(
                          onTap: (){
                            Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return AboutUs();
                      },
                    ),
                  );

                          },
                           child: Card(
                            color: Colors.yellow,
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)
                            ),
                            child:Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 25.0,
                                  ),
                                  Icon(Icons.info, color: Colors.white,size: 52.0,),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "About Us",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0
                                    ),
                                  ),
                                 
                                  
                                ],
                                ),
                              )
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width:160.0,
                        height: 160.0,
                        child: 
                        InkWell(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return MapsPage();
                                  },
                                ),
                              );

                          },
                          child: Card(
                            color: Colors.pink,
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)
                            ),
                            child:Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                      height: 25.0,
                                    ),
                                    Icon(Icons.add_location, color: Colors.white,size: 52.0,),
                                      
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        "Shelters",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                     
                                    ],
                                  ),
                                )
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width:160.0,
                        height: 160.0,
                        child: 
                        InkWell(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return HelpLine();
                                  },
                                ),
                              );
                          },
                          child: Card(
                            color: Colors.lightGreen,
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)
                            ),
                            child:Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                      height: 25.0,
                                    ),
                                    Icon(Icons.add_call, color: Colors.white,size: 52.0,),
                                      
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        "Help-Line",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      
                                    ],
                                  ),
                                )
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width:160.0,
                        height: 160.0,
                        child: 
                        InkWell(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return FoodBank();
                                  },
                                ),
                              );
                          },
                           child: Card(

                            color: Colors.red,
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)
                            ),
                            child:Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                      height: 25.0,
                                    ),
                                    Icon(Icons.food_bank, color: Colors.white,size: 52.0,),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        "Food Drives",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      
                                    ],
                                  ),
                                )
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        )
      ),
    );
 
  }
}