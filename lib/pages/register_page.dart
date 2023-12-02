// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:login_app_server/components/my_button.dart';
import 'package:login_app_server/components/my_textfield.dart';
import 'package:login_app_server/components/square_tile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:login_app_server/pages/login_page.dart';
import 'package:login_app_server/pages/user.dart';

import 'home_page.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  // sign user up method
  void signUserUp() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    //try sign up
    // try {
    //   // check if password is confirmed
    //   if (passwordController.text == confirmpasswordController.text ) {
    //     await FirebaseAuth.instance.createUserWithEmailAndPassword(
    //     email: emailController.text,
    //     password: passwordController.text,
    //   );
    //   } else{
    //     // show error message, password don't match
    //     showErrorMessage("Passwords don't match!");
    //   }
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
    // check if password is confirmed
    Navigator.pop(context);
    if (passwordController.text == confirmpasswordController.text) {
      // send registration request to PHP server
      try {
        // String url = "http://192.168.127.41/flutter_loginDB_training/register.php";
        String url = "https://flutter-app-server.000webhostapp.com/register.php";
        final response = await http.post(Uri.parse(url), body: {
          // 'name': nameController.text,
          'name': "test",
          'password': passwordController.text,
          'email': emailController.text,
        });

        var data = json.decode(response.body);
        if (data == 'Succeed') {
          // registration successful
          await User.setsignin(true);
          await User.setUserEmail(emailController.text);
          print("Registration Success");
          print("Login Success");
          // Navigator.pop(context); // pop the loading circle
          // Optionally, you can navigate to the login page or perform other actions.
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage(onTap: () {  },)),
          );
        } else if (data == 'Error') {
          // registration failed
          print("Email already exists!");
          showErrorMessage("Email already exists!");
          // Navigator.pop(context);
        }
      } catch (e) {
        // handle error, e.g., showErrorMessage("Registration failed")
        print("Error during registration: $e");
        showErrorMessage("Registration failed code : $e");
        // Navigator.pop(context);
      }
    } else {
      // show error message, password don't match
      print("Passwords do not match!");
      showErrorMessage("Passwords do not match!");
      // pop the loading circle
      // Navigator.pop(context);
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

  // bool isEmpty(input){
  //   if(input.length == 0){
  //     return true;
  //   }else{
  //     return false;
  //   }
  // }
  // bool isValidEmail(input){
  //   if(EmailValidator.validate(input)){
  //     return true;
  //   }else{
  //     return false;
  //   }
  // }
  
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
                  const SizedBox(height: 25),

                  // logo
                  const Icon(
                    Icons.lock,
                    size: 50,
                  ),

                  const SizedBox(height: 25),

                  // Let's create an account for you
                  Text(
                    'Let\'s create an account for you!',
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
                    obscureText: false,
                    validator: null,
                  ),
                // TextFormField(
                //     decoration: InputDecoration(
                //       hintText: 'Email',
                //       // border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                //       filled: true,
                //       fillColor: Colors.white,
                //     ),
                //     obscureText: false,
                //     autovalidateMode: AutovalidateMode.onUserInteraction,
                //     controller: emailController,
                //     validator: (value) {
                //       if (isEmpty(value)){
                //         return 'enter your email';
                //       } else{
                //         if(isValidEmail(value)){
                //           return null;
                //         }else {
                //           return 'enter a valid email';
                //         }
                //       }
                //     },
                //   ),

                  const SizedBox(height: 10),

                  // password textfield
                  MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                    validator: null,
                  ),

                  const SizedBox(height: 10),

                  // confirm password textfield
                  MyTextField(
                    controller: confirmpasswordController,
                    hintText: 'Confirm Password',
                    obscureText: true,
                    validator: null,
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

                  //sign up button
                  MyButton(
                    text: "Sign Up",
                    onTap: signUserUp,
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
                        'Already have an account?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginPage(onTap: () {})),
                          );
                        },
                        child: const Text(
                          'Login now',
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
