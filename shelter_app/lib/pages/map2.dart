import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shelter_app/constraints.dart';


class FoodBank extends StatefulWidget {
  @override
  _FoodBankState createState() => _FoodBankState();
}

class _FoodBankState extends State<FoodBank> {
  GoogleMapController mapController;
  var clients = [];
  var currentClient;
  var currentBearing;
  bool resetToggle = false;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  void initMarker(specify, specifyId) async {
    var markerIdVal = specifyId;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,
      position:
          LatLng(specify['location'].latitude, specify['location'].longitude),
      infoWindow: InfoWindow(title:specify['clientName']),
      icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueViolet,),
      onTap: (){}
    );
    setState(() {
      markers[markerId] = marker;
    });
  }

  getMarkerData() async {
    clients=[];
    FirebaseFirestore.instance.collection('foodBanks').get().then((myMockDoc) {
      if (myMockDoc.docs.isNotEmpty) {
        myMockDoc.docs.forEach((element)  {
          initMarker(element.data(), element.id);
          clients.add(element.data());
        });
      }
    });
    
  }

  

  Widget clientCard(client){
    return Padding(
      padding: EdgeInsets.only(left:2,top:10),
      child: InkWell(
        onTap: (){
          setState(() {
                currentClient = client;
                currentBearing = 90.0;
              });
              zoomInMarker(client);
        },
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(5),
          child: Container(
            height: 125,
            width: 125,
            decoration: BoxDecoration(
              borderRadius:BorderRadius.circular(5),
              color: Colors.white,

            ),
            child: Center(
              child:Text(client['clientName'])
            ),
          ),
          ),
      ),
      );
  }
  zoomInMarker(client) {
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(
                client['location'].latitude, client['location'].longitude),
            zoom: 17.0,
            bearing: 90.0,
            tilt: 45.0)))
        .then((val) {
      setState(() {
        resetToggle = true;
      });
    });
  }

  resetCamera() {
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(19.058830,72.834670), zoom: 10.0))).then((val) {
             setState(() {
                     resetToggle = false;
             });
        });
  }

  addBearing() {
    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(currentClient['location'].latitude, 
        currentClient['location'].longitude
      ),
      bearing: currentBearing == 360.0 ? currentBearing : currentBearing + 90.0,
      zoom: 17.0,
      tilt: 45.0
    )
    )
    ).then((val) {
      setState(() {
        if(currentBearing == 360.0) {}
        else {
          currentBearing = currentBearing + 90.0;
        }
      });
    });
      }

      removeBearing() {
    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(currentClient['location'].latitude, 
        currentClient['location'].longitude
      ),
      bearing: currentBearing == 0.0 ? currentBearing : currentBearing - 90.0,
      zoom: 17.0,
      tilt: 45.0
    )
    )
    ).then((val) {
      setState(() {
        if(currentBearing == 0.0) {}
        else {
          currentBearing = currentBearing - 90.0;
        }
      });
    });
      }
    
  void onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
}

 

  @override
  void initState() {
    getMarkerData();
    super.initState();
    
    
  }

  @override
  Widget build(BuildContext context) {
    
    

    return Scaffold(
        appBar: AppBar(
          title:Text("Food Banks"),
          centerTitle: true,
          backgroundColor: kPrimaryColor,
          
        ),
        body:Column(children: [
          Stack(
        children: <Widget>[
                   Container(
                    height: MediaQuery.of(context).size.height-80,
                    width: double.infinity,
                    child: GoogleMap(
                markers: Set<Marker>.of(markers.values),
                mapType: MapType.normal,
                initialCameraPosition:
                    CameraPosition(target: LatLng(19.1364,72.8296), zoom: 12.0),
                onMapCreated: onMapCreated,
                ),
          ),
          Positioned(
            top:MediaQuery.of(context).size.height-250,
            left: 10,
            child: Container(
              height:125,
              width:MediaQuery.of(context).size.width,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.all(8),
                children: clients.map((element){
                  return clientCard(element);
                }).toList(),

              ),
            )),
            resetToggle
                    ? Positioned(
                        top: MediaQuery.of(context).size.height -
                            (MediaQuery.of(context).size.height -
                            50.0),
                        right: 15.0,
                        child: FloatingActionButton(
                          onPressed: resetCamera,
                          mini: true,
                          backgroundColor: Colors.red,
                          child: Icon(Icons.refresh),
                        ))
                    : Container(),
                resetToggle
                    ? Positioned(
                        top: MediaQuery.of(context).size.height -
                            (MediaQuery.of(context).size.height -
                            50.0),
                        right: 60.0,
                        child: FloatingActionButton(
                          onPressed: addBearing,
                          mini: true,
                          backgroundColor: Colors.green,
                          child: Icon(Icons.rotate_left
                        ))
                    )
                    : Container(),
                resetToggle
                    ? Positioned(
                        top: MediaQuery.of(context).size.height -
                            (MediaQuery.of(context).size.height -
                            50.0),
                        right: 110.0,
                        child: FloatingActionButton(
                          onPressed: removeBearing,
                          mini: true,
                          backgroundColor: Colors.blue,
                          child: Icon(Icons.rotate_right)
                        ))
                    : Container()
            
          
          
          
          ],
        ),
     ],)
);

  }
}