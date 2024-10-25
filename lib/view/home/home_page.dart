import 'package:flutter/material.dart';
import 'package:flutter_adv_ch3_exam/controller/sql_controller.dart';
import 'package:flutter_adv_ch3_exam/services/auth_firebase_services.dart';
import 'package:flutter_adv_ch3_exam/services/firebase_store.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    SqlController sqlController = Provider.of(context, listen: true);
    SqlController sqlControllerFalse = Provider.of(context, listen: false);
    return Scaffold(
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pushNamed("/backup");
                },
                child: const Text("Local Storage Backup")),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () async {
                  String email = AuthFirebaseServices.authFirebaseServices
                      .getCurrantEmail()!
                      .email!;
                  for (int i = 0; i < sqlController.localList.length; i++) {
                    await FirebaseStore.firebaseFirestore.storeDateFirebase(
                        email,
                        sqlController.localList[i]["id"],
                        sqlController.localList[i]["name"],
                        sqlController.localList[i]["date"],
                        sqlController.localList[i]["present"]);
                  }
                },
                child: const Text("Cloud Storage Backup")),
          ],
        ),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                Navigator.of(context).pushReplacementNamed("/login");
                await AuthFirebaseServices.authFirebaseServices.signOut();
              },
              icon: const Icon(Icons.login_outlined)),
          IconButton(
              onPressed: () async {
                String email = AuthFirebaseServices.authFirebaseServices
                    .getCurrantEmail()!
                    .email!;
                for (int i = 0; i < sqlController.localList.length; i++) {
                  await FirebaseStore.firebaseFirestore.storeDateFirebase(
                      email,
                      sqlController.localList[i]["id"],
                      sqlController.localList[i]["name"],
                      sqlController.localList[i]["date"],
                      sqlController.localList[i]["present"]);
                }
              },
              icon: const Icon(Icons.backup_outlined))
        ],
        title: const Text("Student Record"),
      ),
      body: ListView.builder(

        itemCount: sqlController.localList.length,
        itemBuilder: (context, index) => ListTile(
          trailing: (sqlController.localList[index]['present']==0)?const Text("absent"):const Text("present"),
          title: Text(sqlController.localList[index]["name"]),
          subtitle: Text(sqlController.localList[index]["date"]),
          onTap: () {
            showModalBottomSheet(context: context, builder: (context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(children: [],),
                  SizedBox(height: 50,),
                  IconButton(onPressed: () {
                    sqlController.deleteLocalRecord(sqlController.localList[index]['id']);
                  }, icon: Icon(Icons.delete)),
                  IconButton(onPressed: () {
                    TextEditingController txtName = TextEditingController(text: sqlController.localList[index]["name"]);
                    TextEditingController txtDate = TextEditingController(text:sqlController.localList[index]["date"]);
                    int value = 0;
                    showDialog(context: context, builder: (context) {
                      return AlertDialog(
                        title: const Text("Student Data Adding Record"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: txtName,
                                decoration: InputDecoration(
                                  hintText: "Name",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: txtDate,
                                decoration: InputDecoration(
                                  hintText: "Date",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            TextButton(onPressed: () {
                              value = 1;
                            }, child: Text("present")),
                          ],
                        ),
                        actions: [
                          TextButton(onPressed: () {
                            Navigator.of(context).pop();
                          }, child: Text("Exit")),
                          TextButton(onPressed: () {
                            Navigator.of(context).pop();
                            sqlControllerFalse.updateLocalStorage(
                                name: txtName.text.toString(), date: txtDate.text.toString(), present: value, id: sqlController.localList[index]["id"]);
                          }, child: Text("Save")),
                        ],
                      );
                    },);
                    // sqlController.deleteLocalRecord(sqlController.localList[index]['id']);
                  }, icon: Icon(Icons.update)),
                  Container(
                    height: 100,
                  )
                ],
              );
            },);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          TextEditingController txtName = TextEditingController();
          TextEditingController txtDate = TextEditingController();
          // DateTime dateTime = DateTime.now();
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Student Data Adding Record"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: txtName,
                        decoration: InputDecoration(
                          hintText: "Name",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: txtDate,
                        decoration: InputDecoration(
                          hintText: "Date",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(onPressed: () {
                    Navigator.of(context).pop();
                  }, child: Text("Exit")),
                  TextButton(onPressed: () {
                    Navigator.of(context).pop();
                    sqlControllerFalse.insertLocalStorage(
                        name: txtName.text.toString(), date: txtDate.text.toString(), present: 0);
                  }, child: Text("Save")),
                ],
              );
            },
          );
          // sqlControllerFalse.insertLocalStorage(
          //     name: "name", date: "date", present: 0);
        },
        child: const Icon(Icons.add_circle_outline_sharp),
      ),
    );
  }
}
