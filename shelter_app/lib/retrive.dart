import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseManager {
  final CollectionReference profileList =
      FirebaseFirestore.instance.collection('UserData');

  

  Future updateUserList(String name, String gender, int score, String uid) async {
    return await profileList.doc(uid).update({
      'name': name, 'gender': gender, 'score': score
    });
  }

  Future getUsersList(String uid) async {
    List itemsList = [];

    try {
      await profileList.doc(uid).get().then((querySnapshot) {
          itemsList.add(querySnapshot.data());
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}