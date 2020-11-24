import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shelter_app/constraints.dart';
import 'package:shelter_app/retrive.dart';
import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  List userDetails=[];
  String userId;
  String idPhoto;
  

  fetchUserInfo() async {
    final User getUser = FirebaseAuth.instance.currentUser;
    userId = getUser.uid;
  }

  

  fetchDatabaseList() async {
  
  dynamic resultant = await DatabaseManager().getUsersList(userId);

  if (resultant == null) {
    print('Unable to retrieve');
  } else {
    setState(() {
      userDetails= resultant;
    });
  }
}

Future<void> getimage() async {
    final FirebaseStorage storage = FirebaseStorage(
        storageBucket: 'gs://shelterapp-e4ec7.appspot.com');
    final StorageReference downloader = storage.ref().child(userId);
    try {
      String url = await downloader.getDownloadURL();
      setState(() {
        idPhoto = url;
      });
    } catch (e) {
      print(e.message);
    }
  }


@override
  void initState() {
    fetchUserInfo();
    fetchDatabaseList();
    getimage();
    super.initState();
    
    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      appBar: AppBar(
        title: Text("My Profile"),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
      height: 200.0,
      child: Stack(
        children: <Widget>[
          
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height:30),
                 CircleAvatar(
                    radius: 85,
                    backgroundColor: kPrimaryColor,      
                    child: CircleAvatar(
                      minRadius: 5.0,
                      maxRadius: 80.0,
                      backgroundImage: NetworkImage(idPhoto),
                      
                    ),
                 ),
                
                
              ],
            ),
          ),
        
        ],
      ),
    ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
      children: <Widget> [
        Card(
          shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 40,
        child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.account_circle,size: 35.0,
                  color: Colors.blue,),
                    title: Text('User Name',
                    style: TextStyle(color: Colors.black.withOpacity(0.6),
                    fontSize: 18.0,
                    ),),
                    subtitle: Text(
                     userDetails[0]['name'],
                    style: TextStyle(color: Colors.black,
                    fontSize: 25.0,
                    ),
                  ),
                  )
                   
                ],
              ),   
      ),
      Card(
        elevation: 40,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
        child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.face,size: 35.0,
                  color: Colors.pink),
                    title: Text('Gender',
                    style: TextStyle(color: Colors.black.withOpacity(0.6),
                    fontSize: 18.0,
                    ),),
                    subtitle: Text(
                     userDetails[0]['gender'],
                    style: TextStyle(color: Colors.black,
                    fontSize: 25.0,
                    ),
                  ),
                  )
                   
                ],
              ),   
      ),
      Card(
        elevation: 40,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
        child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.calendar_today,size: 35.0,
                  color: Colors.red),
                    title: Text('Age',
                    style: TextStyle(color: Colors.black.withOpacity(0.6),
                    fontSize: 18.0,
                    ),),
                    subtitle: Text(
                     userDetails[0]['age'].toString(),
                    style: TextStyle(color: Colors.black,
                    fontSize: 25.0,
                    ),
                  ),
                  )
                   
                ],
              ),   
      ),
      
      Card(
        elevation: 40,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
        child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.cake,size: 35.0,
                  color: Colors.purple),
                    title: Text('Birth Date',
                    style: TextStyle(color: Colors.black.withOpacity(0.6),
                    fontSize: 18.0,
                    ),),
                    subtitle: Text(
                     userDetails[0]['date_of_birth'],
                    style: TextStyle(color: Colors.black,
                    fontSize: 25.0,
                    ),
                  ),
                  )
                   
                ],
              ),   
      ),
      Card(
        elevation: 40,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
        child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.location_pin,size: 35.0,
                  color: Colors.blueGrey),
                    title: Text('Address',
                    style: TextStyle(color: Colors.black.withOpacity(0.6),
                    fontSize: 18.0,
                    ),),
                    subtitle: Text(
                     userDetails[0]['final_address'],
                    style: TextStyle(color: Colors.black,
                    fontSize: 25.0,
                    ),
                  ),
                  )
                   
                ],
              ),   
      ),
      Card(
        elevation: 40,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
        child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.local_phone,size: 35.0,
                  color: Colors.green,),
                    title: Text('Mobile Number',
                    style: TextStyle(color: Colors.black.withOpacity(0.6),
                    fontSize: 18.0,
                    ),),
                    subtitle: Text(
                     userDetails[0]['mobile_no'].toString(),
                    style: TextStyle(color: Colors.black,
                    fontSize: 25.0,
                    ),
                  ),
                  )
                   
                ],
              ),   
      ),
      SizedBox(height:50)
      ],
      ),
    );
              },
              shrinkWrap: true,
              itemCount: 1,
            )
          ],
        ),
      ),
    );
  }
}

