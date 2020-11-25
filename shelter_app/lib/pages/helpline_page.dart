import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpLine extends StatefulWidget {
  @override
  _HelpLineState createState() => _HelpLineState();
}

class _HelpLineState extends State<HelpLine> {

  call(c1){
    String phone="tel:"+c1;
    launch(phone);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help Line"),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,

      ),

      body: Container(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children:<Widget>[
              Text("Help-Line Service",
              style: TextStyle(color: Colors.black,fontSize: 40),
              ),
              InkWell(
                onTap: (){
                  call('999-737362');
                },
                child:Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Colors.white,
      elevation: 10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const ListTile(
            
            title: Text('Social Service', style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 30,
              )),
            subtitle: Text('999-737362', 
            style: TextStyle(color: Colors.black,fontSize: 20)),
            
          ),
        ],
      ),
      ),
        ),
        InkWell(
                onTap: (){
                  call('999-737362');
                },
                child:Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Colors.white,
      elevation: 10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const ListTile(
            
            title: Text('NGO Service', style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 30,
              )),
            subtitle: Text('999-737362', 
            style: TextStyle(color: Colors.black,fontSize: 20)),
            
          ),
        ],
      ),
      ),
        ),
        InkWell(
                onTap: (){
                  call('999-737362');
                },
                child:Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Colors.white,
      elevation: 10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const ListTile(
            
            title: Text('Medical Service', style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 30,
              )),
            subtitle: Text('999-737362', 
            style: TextStyle(color: Colors.black,fontSize: 20)),
            
          ),
        ],
      ),
      ),
        ),
            ],
          ),
        ),
      ),
    );
  }
}