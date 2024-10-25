import 'package:firebase_auth/firebase_auth.dart';

class AuthFirebaseServices {
  AuthFirebaseServices._();
  static AuthFirebaseServices authFirebaseServices = AuthFirebaseServices._();
  final credential = FirebaseAuth.instance;

  Future<void> emailSignUp({required emailAddress,required String password})
  async {

    await credential.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
    getCurrantEmail();
  }

  Future<void> loginFirebase({required emailAddress,required String password})
  async {
    await credential.signInWithEmailAndPassword(
        email: emailAddress,
        password: password
    );
    getCurrantEmail();
  }

  Future<void> signOut()
  async {
    await credential.signOut();
  }

  User? getCurrantEmail()
  {
    User? user = credential.currentUser;
    if(user!=null)
      {
        print("Email ---> ${user.email}");
      }
    return user;
  }
}