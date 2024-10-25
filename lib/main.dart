import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adv_ch3_exam/controller/sql_controller.dart';
import 'package:flutter_adv_ch3_exam/services/auth_firebase_services.dart';
import 'package:flutter_adv_ch3_exam/view/auth/login_page.dart';
import 'package:flutter_adv_ch3_exam/view/auth/signup_page.dart';
import 'package:flutter_adv_ch3_exam/view/backup/backup_page.dart';
import 'package:flutter_adv_ch3_exam/view/home/home_page.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SqlController(),
        )
      ],
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/login",
        routes: {
          "/": (context) => const HomePage(),
          "/login": (context) => AuthFirebaseServices.authFirebaseServices.getCurrantEmail()==null? const LoginPage():const HomePage(),
          "/signup": (context) => const SignupPage(),
          "/backup": (context) => const BackupPage(),
        },
      ),
    );
  }
}
