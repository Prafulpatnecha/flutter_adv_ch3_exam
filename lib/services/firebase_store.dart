import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_adv_ch3_exam/services/auth_firebase_services.dart';

class FirebaseStore {
  FirebaseStore._();
  static FirebaseStore firebaseFirestore = FirebaseStore._();

  // CollectionReference firestoreStudent = FirebaseFirestore.instance.collection('');

  // Future<void> firebaseDataAllDelete(String email,int id)
  // {
  //   return FirebaseFirestore.instance.collection(email).doc("$id").delete();
  // }

  Future<void> storeDateFirebase(String email,int id,String name,String date,int present) {
    return FirebaseFirestore.instance.collection(email).doc("$id")
        .set({
      "name":name,
      "date":date,
      "present":present,
      "id":id,
    });
  }

  List firebaseList = [];
  Stream<QuerySnapshot<Map<String, dynamic>>> getDataFirebase()
  {
    String email = AuthFirebaseServices.authFirebaseServices.getCurrantEmail()!.email!;
    return FirebaseFirestore.instance.collection(email).snapshots();
  }
}