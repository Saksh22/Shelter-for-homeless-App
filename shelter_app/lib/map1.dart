import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsPage extends StatefulWidget {
  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  GoogleMapController controller;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  void initMarker(specify, specifyId) async {
    var markerIdVal = specifyId;
    final MarkerId markerId = MarkerId(markerIdVal);
    DocumentSnapshot variable = await FirebaseFirestore.instance.collection('shelter').doc(specifyId).get();
    final Marker marker = Marker(
      markerId: markerId,
      position:
          LatLng(specify['location'].latitude, specify['location'].longitude),
      infoWindow: InfoWindow(title: specify['clientName'], snippet: specify['address']),
    );
    setState(() {
      markers[markerId] = marker;
    });
  }

  getMarkerData() async {
    FirebaseFirestore.instance.collection('shelters').get().then((myMockDoc) {
      if (myMockDoc.docs.isNotEmpty) {
        myMockDoc.docs.forEach((element)  {
          initMarker(element.data(), element.id);
        });
      }
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
        body: GoogleMap(
            markers: Set<Marker>.of(markers.values),
            mapType: MapType.normal,
            initialCameraPosition:
                CameraPosition(target: LatLng(19.058830,72.834670), zoom: 12.0),
            onMapCreated: (GoogleMapController controller) {
              controller = controller;
            }));
  }
}