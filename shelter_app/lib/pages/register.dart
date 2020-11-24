import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shelter_app/constraints.dart';
import 'package:shelter_app/pages/login.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'dart:io';
import '../components/rounded_button.dart';


class Register extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Register> {

  bool hidepassword = true, rememberme = false;
  String email,
      password,
      name,
      state,
      city,
      address1,
      district,
      dob,
      gender,
      formDob = "Date of Birth",
      userid;
  int aadharCardNo, mobileNo, age;
  File idPhoto;
  List states = [
        'Maharashtra',
        'Delhi'
      ],
      genders = ['Male', 'Female', 'Other'],
      districts = [];
  User temp;
  String imagestatus = 'Upload your picture';

  
  final CollectionReference fire =
      FirebaseFirestore.instance.collection('UserData');

 

  Future<bool> fileUpload() async {
    try {
      final FirebaseStorage storage = FirebaseStorage(
          storageBucket: 'gs://shelterapp-e4ec7.appspot.com/');
      final StorageReference uploader = storage.ref().child(userid.toString());
      StorageUploadTask task = uploader.putFile(idPhoto);
      await task.onComplete;
      return true;
    } catch (e) {
      Alert(
        context: context,
        title: 'Error',
        desc: e.message,
        buttons: [
          DialogButton(
            radius: BorderRadius.circular(25),
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.blue,
            child: Text(
              'Okay',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
              ),
            ),
          ),
        ],
        style: AlertStyle(
          backgroundColor: Colors.cyan,
          titleStyle: TextStyle(fontWeight: FontWeight.bold),
          descStyle: TextStyle(color: Colors.red),
          buttonAreaPadding: EdgeInsets.all(15),
        ),
      ).show();
      return false;
    }
  }

      final snackbar = SnackBar(
                content: Text(
                  'Photo Added',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.blue,
                duration: Duration(seconds: 1),
              );
              
      Future getcameraimage() async {
        ImagePicker picker= ImagePicker();
        PickedFile pickedFile;
        pickedFile = await picker.getImage(
          source: ImageSource.camera,);
        setState(() {
          if (pickedFile!= null){
            idPhoto=File(pickedFile.path);
            imagestatus = 'View/Edit your picture  ';
          }
          else{
            print("No image selected");
          }
        });
      }

      Future getgalleryimage() async {
          ImagePicker picker= ImagePicker();
        PickedFile pickedFile;
        pickedFile = await picker.getImage(
          source: ImageSource.gallery,);
        setState(() {
          if (pickedFile!= null){
            idPhoto=File(pickedFile.path);
            imagestatus = 'View/Edit your picture  ';
          }
          else{
            print("No image selected");
          }
        });
        }

      bool checkdetails() {
    if (email != null &&
        password != null &&
        name != null &&
        dob != null &&
        mobileNo.toString().length == 10 &&
        aadharCardNo.toString().length == 12 &&
        address1 != null &&
        city != null &&
        state != null&&
        idPhoto!=null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> registeruser() async {
    try {
      await Firebase.initializeApp();
      UserCredential result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      setState(() {
        temp = result.user;
        userid = result.user.uid;
      });
      return true;
    } catch (e) {
      Navigator.pop(context);
      Alert(
              context: context,
              title: 'Registration Error',
              desc: e.message,
              buttons: [],
              style:
                  AlertStyle(isCloseButton: false, isOverlayTapDismiss: false))
          .show();
      await Future.delayed(Duration(seconds: 3));
      return false;
    }
  }

  Future<bool> adddetails() async {
    try {
      String address =
          (address1 + ", " + city + ", " + state);
      
      fire.doc(userid).set({
        'name': name,
        'age': age,
        'gender': gender,
        'date_of_birth': dob,
        'mobile_no': mobileNo,
        'aadhar': aadharCardNo,
        'address_line': address1,
        'city': city,
        'state': state,
        'final_address': address,
        
      });
      return true;
    } catch (e) {
      Navigator.pop(context);
      Alert(
              context: context,
              title: 'Registration Error',
              desc: e.message,
              buttons: [],
              style:
                  AlertStyle(isCloseButton: false, isOverlayTapDismiss: false))
          .show();
      await Future.delayed(Duration(seconds: 3));
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
     var fieldDecoration = InputDecoration(
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(MediaQuery.of(context).size.width / 12.8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: kPrimaryColor,
            width: MediaQuery.of(context).size.width / 160,
          ),
          borderRadius:
              BorderRadius.circular(MediaQuery.of(context).size.width / 12.8),
        ),
        labelStyle: TextStyle(
          color: kPrimaryColor,
          fontSize: 25,
        ));
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple[300],
          centerTitle: true,
          title: Text(
            'Welcome to WeShelter',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.0437,
              color: Colors.white70,
            ),
          ),
        ),
        body: Builder(
          builder: (context) => SingleChildScrollView(
            child: Container(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width / 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 20,
                      ),
                      Text(
                        'Enter your personal details',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize:25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 32,
                      ),
                      
                      TextFormField(
                        cursorColor: kPrimaryColor,
                        textInputAction: TextInputAction.next,
                        maxLength: 20,
                        maxLengthEnforced: true,
                        decoration: fieldDecoration.copyWith(
                            labelText: 'Full Name', helperText: '*required'),
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontSize:25
                            ),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              name = value;
                            });
                          }
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 60,
                      ),
                      Container(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width / 64),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: kPrimaryColor,
                              width: MediaQuery.of(context).size.width / 160),
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width / 12.8),
                          color: Colors.white,
                        ),
                        child: DropdownButton(
                          iconEnabledColor: kPrimaryColor,
                          underline: Container(),
                          hint: Text(
                            'Select Gender:',
                            style: TextStyle(
                              fontSize:25,
                              color: kPrimaryColor,
                            ),
                          ),
                          isExpanded: true,
                          items: genders.map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                              child: Container(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width / 64),
                                height:
                                    MediaQuery.of(context).size.height / 10.66,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: kPrimaryColor,
                                      width: MediaQuery.of(context).size.width /
                                          160),
                                  borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.width / 32),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      value,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              42.666,
                                          fontWeight: FontWeight.bold,
                                          color: kPrimaryColor),
                                    ),
                                  ],
                                ),
                              ),
                              value: value,
                            );
                          }).toList(),
                          style: TextStyle(
                            color: Colors.black,
                            
                          ),
                          onChanged: (chosen) async {
                            setState(() {
                              gender = chosen;
                            });
                          },
                          value: gender,
                        ),
                      ),
                      
                      Text(
                        '*required',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: MediaQuery.of(context).size.height / 55,
                          
                        ),
                      ),
                      
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 60,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        maxLength: 3,
                        decoration: fieldDecoration.copyWith(
                          labelText: 'Age',
                          helperText: '*required',
                        ),
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 25),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              age = int.parse(value);
                            });
                          }
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 60,
                      ),
                      InkWell(
                        onTap: () async {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime(2000),
                                  firstDate: DateTime(1920),
                                  lastDate: DateTime.now())
                              .then((date) {
                            if (date != null) {
                              setState(() {
                                formDob =
                                    "${date.toString().split(' ')[0].split('-')[2]}/${date.toString().split(' ')[0].split('-')[1]}/${date.toString().split(' ')[0].split('-')[0]}";
                                dob = formDob;
                              });
                            }
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: kPrimaryColor,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            children: <Widget>[
                              Text(
                                formDob,
                                style:
                                    TextStyle(color: kPrimaryColor, fontSize: 25),
                              ),
                              SizedBox(
                                width: 160,
                              ),
                              Icon(
                                Icons.calendar_today,
                                color: kPrimaryColor,
                                size: 25,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        '*required',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: MediaQuery.of(context).size.height / 55,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 60,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        maxLength: 10,
                        decoration: fieldDecoration.copyWith(
                          labelText: 'Contact Number',
                          helperText: '*required',
                        ),
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 22),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              mobileNo = int.parse(value);
                            });
                          }
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 60,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        maxLength: 12,
                        decoration: fieldDecoration.copyWith(
                          labelText: 'AadharCard Number',
                          helperText: '*required',
                        ),
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 22),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              aadharCardNo = int.parse(value);
                            });
                          }
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 60,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        maxLength: 80,
                        minLines: 2,
                        maxLines: 2,
                        decoration: fieldDecoration.copyWith(
                            labelText: 'Address',
                            helperText: '*required'),
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 25),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              address1 = value;
                            });
                          }
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 60,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        maxLength: 15,
                        decoration: fieldDecoration.copyWith(
                          labelText: 'City',
                          helperText: '*required',
                        ),
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 25),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              city = value;
                            });
                          }
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 60,
                      ),
                      Container(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width / 64),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: kPrimaryColor,
                              width: MediaQuery.of(context).size.width / 160),
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width / 12.8),
                          color: Colors.white,
                        ),
                        child: DropdownButton(
                          iconEnabledColor: kPrimaryColor,
                          underline: Container(),
                          hint: Text(
                            'Select State:',
                            style: TextStyle(
                              fontSize:
                                  25,
                              color: kPrimaryColor,
                            ),
                          ),
                          isExpanded: true,
                          items: states.map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                              child: Container(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width / 64),
                                height:
                                    MediaQuery.of(context).size.height / 10.66,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: kPrimaryColor,
                                      width: MediaQuery.of(context).size.width /
                                          160),
                                  borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.width / 32),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      value,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              42.666,
                                          fontWeight: FontWeight.bold,
                                          color: kPrimaryColor),
                                    ),
                                  ],
                                ),
                              ),
                              value: value,
                            );
                          }).toList(),
                          style: TextStyle(
                            color: Colors.black,
                            
                          ),
                          onChanged: (chosen) async {
                            setState(() {
                              state = chosen;
                            });
                            Alert(
                                context: context,
                                style: AlertStyle(
                                  backgroundColor: Colors.white,
                                  isOverlayTapDismiss: false,
                                  isCloseButton: false,
                                ),
                                title: "Please wait",
                                desc: "Getting District List...",
                                buttons: [],
                                content: Container(
                                  child: SpinKitCircle(color: Colors.blue),
                                )).show();
                            
                            Navigator.pop(context);
                          },
                          value: state,
                        ),
                      ),
                      Text(
                        '*required',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: MediaQuery.of(context).size.height / 50,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (idPhoto == null) {
                            Alert(
                              context: context,
                              title: 'Select method',
                              buttons: [],
                              style: AlertStyle(
                                backgroundColor: Colors.black,
                                titleStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              content: Container(
                                padding: EdgeInsets.all(25),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    FlatButton(
                                      padding: EdgeInsets.all(10),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      onPressed: () async {
                                        await getcameraimage();
                                        Navigator.pop(context);
                                        Scaffold.of(context)
                                            .showSnackBar(snackbar);
                                      },
                                      color: Colors.blue,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            'Camera',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 25,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Icon(
                                            Icons.photo_camera,
                                            color: Colors.black,
                                            size: 30,
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    FlatButton(
                                      padding: EdgeInsets.all(10),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      onPressed: () async {
                                        await getgalleryimage();
                                        Navigator.pop(context);
                                        Scaffold.of(context)
                                            .showSnackBar(snackbar);
                                      },
                                      color: Colors.blue,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            'Gallery',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 25,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Icon(
                                            Icons.camera,
                                            color: Colors.black,
                                            size: 30,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ).show();
                          } else {
                            Alert(
                              context: context,
                              title: 'Your Image',
                              buttons: [],
                              style: AlertStyle(
                                backgroundColor: Colors.black,
                                titleStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              content: SingleChildScrollView(
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 2,
                                          ),
                                        ),
                                        child: Image.file(idPhoto),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          FlatButton(
                                            padding: EdgeInsets.all(10),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              Alert(
                                                context: context,
                                                title: 'Select method',
                                                buttons: [],
                                                style: AlertStyle(
                                                  backgroundColor: Colors.black,
                                                  titleStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                content: Container(
                                                  padding: EdgeInsets.all(25),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      FlatButton(
                                                        padding:
                                                            EdgeInsets.all(10),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        25)),
                                                        onPressed: () async {
                                                          await getcameraimage();
                                                          Navigator.pop(
                                                              context);
                                                          Scaffold.of(context)
                                                              .showSnackBar(
                                                                  snackbar);
                                                        },
                                                        color: Colors.blue,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Text(
                                                              'Camera',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 25,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Icon(
                                                              Icons
                                                                  .photo_camera,
                                                              color:
                                                                  Colors.black,
                                                              size: 30,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      FlatButton(
                                                        padding:
                                                            EdgeInsets.all(10),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        25)),
                                                        onPressed: () async {
                                                          await getgalleryimage();
                                                          Navigator.pop(
                                                              context);
                                                          Scaffold.of(context)
                                                              .showSnackBar(
                                                                  snackbar);
                                                        },
                                                        color: Colors.blue,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Text(
                                                              'Gallery',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 25,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Icon(
                                                              Icons.camera,
                                                              color:
                                                                  Colors.black,
                                                              size: 30,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ).show();
                                            },
                                            color: Colors.blue,
                                            child: Text(
                                              'Edit',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 25,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 15),
                                          FlatButton(
                                            padding: EdgeInsets.all(10),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            color: Colors.blue,
                                            child: Text(
                                              'Okay',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 25,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ).show();
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.yellow,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            children: <Widget>[
                              Text(
                                imagestatus,
                                style: TextStyle(
                                    color: Colors.orange, fontSize: 20),
                              ),
                              SizedBox(
                                width: 35,
                              ),
                              Icon(
                                Icons.photo_camera,
                                color: Colors.orange,
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        '*required',
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.red),
                      ),





                      SizedBox(
                        height: MediaQuery.of(context).size.height / 32,
                      ),
                      
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 32,
                      ),
                      Text(
                        'Enter your login credentials',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height / 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 32,
                      ),
                      
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        decoration: fieldDecoration.copyWith(
                            labelText: 'Email Address',
                            hintText: 'Example@domain.com',
                            helperText: '*required'),
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 25),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              email = value;
                            });
                          }
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 60,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.done,
                        obscureText: hidepassword,
                        decoration: fieldDecoration.copyWith(
                          labelText: 'Password',
                          helperText: '*required',
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.remove_red_eye,
                              color: kPrimaryColor,
                            ),
                            onPressed: () async {
                              setState(() {
                                hidepassword = false;
                              });
                              await Future.delayed(Duration(seconds: 3));
                              setState(() {
                                hidepassword = true;
                              });
                            },
                          ),
                        ),
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 25),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              password = value;
                            });
                          }
                        },
                      ),
                      RoundedButton(
                        text: "SIGN UP",
                        press: () async{
                          Alert(
                                context: context,
                                style: AlertStyle(
                                  backgroundColor: Colors.white,
                                  isOverlayTapDismiss: false,
                                  isCloseButton: false,
                                ),
                                title: "Please wait",
                                desc: "Registering User...",
                                buttons: [],
                                content: Container(
                                  child: SpinKitCircle(color: Colors.blue),
                                )).show();
                            if (checkdetails()) {
                              bool confirmation1 = await registeruser();
                              if (confirmation1) {
                                bool confirmation2 = await adddetails();
                                if (confirmation2) {
                                  bool confirmation3=await fileUpload();
                                  if (confirmation3){
                                  Navigator.pop(context);
                                  Alert(
                                          context: context,
                                          title: 'User Registered',
                                          desc: 'Redirecting to Login page..',
                                          buttons: [],
                                          content: Container(
                                            child: SpinKitCircle(
                                                color: Colors.blue),
                                          ),
                                          style: AlertStyle(
                                              isCloseButton: false,
                                              isOverlayTapDismiss: false))
                                      .show();
                                  await Future.delayed(Duration(seconds: 3));
                                  Navigator.pop(context);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Login(),
                                      ));
                                  }else{
                                    Navigator.pop(context);
                                  }
                                } else {
                                  temp.delete();
                                }
                              } else {
                                Navigator.pop(context);
                              }
                            } else {
                              Navigator.pop(context);
                              Alert(
                                      context: context,
                                      title: 'Invalid Input',
                                      desc:
                                          'All inputs are required and in correct format',
                                      buttons: [],
                                      style: AlertStyle(
                                          isCloseButton: false,
                                          isOverlayTapDismiss: false))
                                  .show();
                              await Future.delayed(Duration(seconds: 2));
                              Navigator.pop(context);
                            }
                        },
                      ),
                      
                
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 32,
                      ),
                      
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 64,
                      ),
                      Text(
                        'Already a User?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize:20,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 64,
                      ),

                      RoundedButton(
                        text: "LOGIN",
                        press: () {
                          Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Login(),
                                ));
                        },
                      ),
                      
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 32,
                      ),
                      Divider(
                        height: MediaQuery.of(context).size.height / 128,
                        thickness: MediaQuery.of(context).size.height / 320,
                        color: Colors.blueAccent,
                        indent: MediaQuery.of(context).size.width / 10.666,
                        endIndent: MediaQuery.of(context).size.width / 10.666,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 64,
                      ),
                      
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}