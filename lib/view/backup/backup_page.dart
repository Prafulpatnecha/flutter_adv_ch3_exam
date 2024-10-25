import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adv_ch3_exam/services/auth_firebase_services.dart';
import 'package:flutter_adv_ch3_exam/services/firebase_store.dart';
import 'package:provider/provider.dart';

import '../../controller/sql_controller.dart';

class BackupPage extends StatelessWidget {
  const BackupPage({super.key});

  @override
  Widget build(BuildContext context) {
    SqlController sqlController = Provider.of(context,listen: true);
    SqlController sqlControllerFalse = Provider.of(context,listen: false);
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseStore.firebaseFirestore.getDataFirebase(), builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong ->${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            (document.data());
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            sqlControllerFalse.insertFirebaseToLocal(name: data["name"], date: data["date"], present: data["present"]);
          return ListTile(
            title: Text(data['name'].toString()),
            subtitle: Text(data['date'].toString()),
          );
        }).toList());
      },),
    );
  }
}
