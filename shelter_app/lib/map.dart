import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';


class Map extends StatefulWidget {

  
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  
  bool mapToggle=false;
  var currentLocation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best).then((currloc) {
      setState(() {
        currentLocation=currloc;
        mapToggle=true;
      });

    });
    

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(
          "Map",
        )
      ),
      body: Column(
        children: <Widget>[
          Stack(
            children:<Widget>[
              Container(
                height:MediaQuery.of(context).size.height - 80,
                width: double.infinity,
                child: mapToggle?
                GoogleMap(

                  initialCameraPosition: CameraPosition(target: LatLng(currentLocation.latitude,currentLocation.longitude),zoom: 10)
                  ):Center(
                  child:Text("Loading")
                ),
              )
            ]
          )
        ]
      ),
    );
  }
}