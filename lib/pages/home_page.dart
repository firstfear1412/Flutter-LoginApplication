// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_app_server/pages/login_page.dart';
import 'user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// class HomePage extends StatelessWidget {
//   HomePage({super.key});

//   final user = FirebaseAuth.instance.currentUser!;

//   // sign user out method
//   void signUserOut() {
//     FirebaseAuth.instance.signOut();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           IconButton(
//             onPressed: signUserOut,
//             icon: Icon(Icons.logout),
//           )
//         ],
//       ),
//       body: Center(child: Text(
//         "LOGGED IN AS : " + user.email!,
//         style: TextStyle(fontSize: 20))),
//     );
//   }
// }

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required void Function() onTap}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // @override
  Future logout() async {
    await User.setsignin(false);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(onTap: () {})));
  }
  //async เพราะว่าเป็นการดึงข้อมูลจาก URL
  Future all_image() async {
    // var url = "http://192.168.127.41/flutter_loginDB_training/image.php";
    var url = "https://flutter-app-server.000webhostapp.com/image.php";
    final response = await http.post(Uri.parse(url));
    return json.decode(response.body);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: const Color.fromARGB(255, 33, 150, 243),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: (){
              logout();
            },
            icon: Icon(Icons.logout),
          )
        ],
      ),
      // body: Center(child: Text(
      //   "LOGGED IN AS : " + user.email!,
      //   // "Login Success : ",
      //   style: TextStyle(fontSize: 20))
      //   ),
      body: Center(
        child: FutureBuilder<String?>(
          future: User.getUserEmail(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasData) {
              return Text(
                "LOGGED IN AS : ${snapshot.data}",
                style: TextStyle(fontSize: 20),
              );
            } else {
              return Text(
                "Error retrieving email",
                style: TextStyle(fontSize: 20),
              );
            }
          },
        ),
      ),
    );
  }

}