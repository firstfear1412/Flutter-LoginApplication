import 'package:flutter/material.dart';
import 'package:login_app_server/pages/auth_page.dart';
import 'package:login_app_server/pages/login_or_register_page.dart';
import 'package:login_app_server/pages/login_page.dart';
import 'package:login_app_server/pages/register_page.dart';
import 'package:email_validator/email_validator.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(const MyApp());
// }

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Login App with Server',
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
      // home: LoginOrRegisterPage(),
    );
  }
}
