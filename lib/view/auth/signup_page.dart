import 'package:flutter/material.dart';
import 'package:flutter_adv_ch3_exam/services/auth_firebase_services.dart';
import 'package:provider/provider.dart';

import '../../controller/sql_controller.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    SqlController sqlController = Provider.of(context,listen: true);
    SqlController sqlControllerFalse = Provider.of(context,listen: false);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Sign Up Page"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: sqlController.email,
              decoration: const InputDecoration(
                hintText: "Enter Your Email",
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.black
                  ),
                ),focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.black
                ),
              ),enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.black
                ),
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
                  borderSide: BorderSide(
                      color: Colors.black
                  ),
                ),focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.black
                ),
              ),enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.black
                ),
              ),
              ),
            ),
          ),
          ElevatedButton(onPressed: () {
            Navigator.of(context).pushNamed("/signup");
          }, child: Text("Go To sign In",style: TextStyle(color: Colors.blue),)),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        try{
        Navigator.of(context).popAndPushNamed("/login");
        await AuthFirebaseServices.authFirebaseServices.emailSignUp(emailAddress: sqlController.email.text.toString(), password: sqlController.password.text.toString());
        }catch(e)
        {
          print("Email Check");
        }
      },child: const Icon(Icons.navigate_next_rounded),),
    );
  }
}
