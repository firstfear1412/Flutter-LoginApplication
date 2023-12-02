// import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:login_app_server/components/my_button.dart';
import 'package:login_app_server/components/my_textfield.dart';
import 'package:login_app_server/components/square_tile.dart';
import 'package:http/http.dart' as http;
import 'package:login_app_server/pages/home_page.dart';
import 'package:login_app_server/pages/register_page.dart';
import 'dart:convert';

import 'package:login_app_server/pages/user.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  // sign user in method
  void signUserIn() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    //try sign in
    // try {
    //   await FirebaseAuth.instance.signInWithEmailAndPassword(
    //     email: emailController.text,
    //     password: passwordController.text,
    //   );
    //   // pop the loading circle
    //   Navigator.pop(context);
    // } on FirebaseAuthException catch (e) {
    //   // pop the loading circle
    //   Navigator.pop(context);
      
    //   // show error message

    //   showErrorMessage(e.code);

    //   // // Wrong Email
    //   // if (e.code == 'user-not-found') {
    //   //   print('No user found for that email');
    //   //   //show error to user
    //   //   wrongEmailMessage();
    //   // }
    //   // // Wrong Password
    //   // else if (e.code == 'wrong-password') {
    //   //   print('Wrong password please try again.');
    //   //   //show error to user
    //   //   wrongPasswordMessage();
    //   // }
    // }



    // *****************************************
    // authenticate user using PHP and MySQL
    try {
      // String url = "http://192.168.127.41/flutter_loginDB_training/login.php";
      String url = "https://flutter-app-server.000webhostapp.com/login.php";
      final response = await http.post(Uri.parse(url),body: {
          'email': emailController.text,
          'password': passwordController.text,
        },
      );

      // pop the loading circle
      Navigator.pop(context);

      // check the response
      if (response.statusCode == 200) {
        final result = json.decode(response.body);

        if (result == "Success") {
          // Navigate to the home page on successful login
          await User.setsignin(true);
          await User.setUserEmail(emailController.text);
          print("Login Success");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage(onTap: () {  },)),
          );
        } else {
          // show error message
          showErrorMessage("Your email or password is incorrect");
        }
      } else {
        // show error message
        // showErrorMessage("Error during login");
        showErrorMessage("Server not response");
      }
    } catch (e) {
      // pop the loading circle
      Navigator.pop(context);
      
      // show error message
      // showErrorMessage("Error during login");
      showErrorMessage("Error during login code : $e");
    }
  }

  // error message to user
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
              ),
              ),
        );
      },
    );
  }

  // Future sign_in() async{
  //   print("access signin Success ++++++++++++++++");
  //   String url = "http://192.168.127.41/flutter_loginDB_training/login.php";
  //   final response = await http.post(Uri.parse(url),body:{
  //     'email' : emailController.text,
  //     'password' : passwordController.text
  //   });
  //   var data = json.decode(response.body);
  //     if(data == "Error"){
  //       // Navigator.pushNamed(context,'login');
  //       // Navigator.pop(context);
  //       print("Login Failed");
  //       // showErrorMessage;
  //     }else{
  //       await User.setsignin(true);
  //       print("Login Success");
  //       await User.setUserEmail(emailController.text);
  //       // Navigator.pushNamed(context, 'homepage');
  //       // Navigator.pop(context);
  //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(onTap: () {})));
  //   }
  // }
  bool isEmpty(input){
    if(input.length == 0){
      return true;
    }else{
      return false;
    }
  }
  bool isValidEmail(input){
    if(EmailValidator.validate(input)){
      return true;
    }else{
      return false;
    }
  }
  bool isValidPassword(input) {
  // ตัวอย่างเงื่อนไขที่อาจจะตรวจสอบ
  // ในที่นี้ตรวจสอบความยาวของรหัสผ่าน
  if (input.length >= 8) {
    return true;
  } else {
    return false;
  }
}
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),

                  // logo
                  const Icon(
                    Icons.lock,
                    size: 100,
                  ),

                  const SizedBox(height: 50),

                  // welcome back
                  Text(
                    'Welcome back you\'ve been missed!',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 25),

                  // email textfield
                  MyTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your email';
                      } else {
                          if (isValidEmail(value)) {
                            return null;
                          } else {
                            return 'Enter a valid email';
                          }
                        }
                    },
                  ),
                  // TextFormField(
                  //   decoration: InputDecoration(
                  //     hintText: 'Email',
                  //     // border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                  //     filled: true,
                  //     fillColor: Colors.white,
                  //   ),
                  //   obscureText: false,
                  //   autovalidateMode: AutovalidateMode.onUserInteraction,
                  //   controller: emailController,
                  //   validator: (value) {
                  //     if (isEmpty(value)){
                  //       return 'enter your email';
                  //     } else{
                  //       if(isValidEmail(value)){
                  //         return null;
                  //       }else {
                  //         return 'enter a valid email';
                  //       }
                  //     }
                  //   },
                  // ),

                  const SizedBox(height: 10),

                  // password textfield
                  MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your password';
                      } else {
                        if (isValidPassword(value)) {
                            return null;
                          } else {
                            return 'Enter a valid Password';
                          }
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  //forgot password?
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  //sign in button
                  MyButton(
                    text: "Sign In",
                    onTap: signUserIn,
                  ),
                  const SizedBox(height: 50),

                  // or continue with
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Or continue with',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 50),

                  //sign in button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      //google
                      SquareTile(imagePath: 'lib/images/google.png'),

                      SizedBox(width: 25),

                      //apple
                      SquareTile(imagePath: 'lib/images/apple.png')
                    ],
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not a member?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RegisterPage(onTap: () {})),
                          );
                        },
                        child: const Text(
                          'Register now',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
