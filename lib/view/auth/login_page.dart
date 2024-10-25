import 'package:flutter/material.dart';
import 'package:flutter_adv_ch3_exam/controller/sql_controller.dart';
import 'package:flutter_adv_ch3_exam/services/auth_firebase_services.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    SqlController sqlController = Provider.of(context, listen: true);
    SqlController sqlControllerFalse = Provider.of(context, listen: false);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Sign In Page"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: sqlController.email,
              decoration: const InputDecoration(
                hintText: "Enter Your Email",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
          ),
          // SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: sqlController.password,
              decoration: const InputDecoration(
                hintText: "Enter Your Password",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/signup");
              },
              child: Text(
                "Go To sign Up",
                style: TextStyle(color: Colors.blue),
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            await AuthFirebaseServices.authFirebaseServices.loginFirebase(
                emailAddress: sqlController.email.text.toString(),
                password: sqlController.password.text.toString());
            Navigator.of(context).popAndPushNamed("/");
          } catch (e) {
            print("Error Id is Not Found");
          }
        },
        child: const Icon(Icons.navigate_next_rounded),
      ),
    );
  }
}
