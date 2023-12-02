import 'package:flutter/material.dart';
import 'package:login_app_server/pages/login_page.dart';
import 'package:login_app_server/pages/register_page.dart';
import 'package:login_app_server/pages/user.dart';

import 'home_page.dart';
import 'login_or_register_page.dart';

// class AuthPage extends StatelessWidget {
  // const AuthPage({super.key});

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: StreamBuilder<User?>(
  //       stream: FirebaseAuth.instance.authStateChanges(),
  //       builder: (context, snapshot){
  //         // user is logged in
  //         if(snapshot.hasData){
  //           return HomePage();
  //         }

  //         // user is NOT logged in
  //         else{
  //           // return LoginPage();
  //           return LoginOrRegisterPage();
  //         }

  //       },
  //     ),
  //   );
  // }
// }
class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPage();
}
class _AuthPage extends State<AuthPage>{
  Future checklogin() async{
    bool? signin = await User.getsignin();
    if(signin == false){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(onTap: () {})));
    }
    else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(onTap: () {})));
    }
  }
  void initState(){
    checklogin();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}