



import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:due_dates/components/my_button.dart';
import 'package:due_dates/components/my_textfield.dart';
import 'package:due_dates/components/apple_button.dart';
import 'package:due_dates/components/google_button.dart';

import 'package:firebase_core/firebase_core.dart';



class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  //Sign-in method
  void signUserIn() async{
    // show loading circle
    showDialog(
        context: context,
        builder: (context){
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
    );
    
    // try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: usernameController.text,
        password: passwordController.text,
      );
      // Successful sign-in
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //pop the loading circle
      Navigator.pop(context);
      // show error message
      errorMessage(e.code);
    }
  }

  //error message to user
  void errorMessage(String message){
    showDialog(
        context: context,
        builder: (context){
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment:MainAxisAlignment.center,
                  children: <Widget>[
                  const SizedBox(height:10),
                  // logo

                    const Icon(Icons.lock, size:100),
                  const SizedBox(height:10),
                  // Welcome back, you've missed!
                  Text(
                      "Let\'s meet some deadlines!",
                      style:TextStyle(color: Colors.grey[700],
                      fontSize: 16,
                      ),
                  ),
                  const SizedBox(height:10),
                  // Email textfield
                  MyTextField(
                    controller: usernameController,
                    hintText: 'Email',
                    obscureText: false,
                  ),
                  const SizedBox(height: 10),
                  // Password textfield
                  MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),
                  const SizedBox(height: 10),
                  // forgot password?
                   Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Text(
                              'Forgot Password?',
                              style: TextStyle(color: Colors.grey[600]),
                            )
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     GestureDetector(
                    //       onTap: (){
                    //         Navigator.push(context, MaterialPageRoute(builder: (context){
                    //           return ;
                    //         },
                    //         ),
                    //         );
                    //       },
                    //       child: Text(
                    //         'Forgot Password?',
                    //         style: TextStyle(color: Colors.grey[600]),
                    //       ),
                    //     )
                    //
                    //   ],
                    // ),
                  ),
                  const SizedBox(height: 10),
                  // Sign in button
                  MyButton(
                    onTap: signUserIn,
                  ),
                  const SizedBox(height: 10),
                  // Or, Continue with
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness:0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Or Continue With',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),
                  // Google + apple sign in buttons
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      // google button
                      GoogleButton(
                        onTap: signGoogle,
                      ),
                      // apple button
                      AppleButton(
                        onTap: signApple,
                      ),

                    ]
                  ),
                  const SizedBox(height:10),
                  // not a user? register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          'Not a user?',
                          style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(width:4),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                            'Sign-up now',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            )
                        ),
                      )


                    ],
                  )
      ]),
            ),
          )
    ));
  }

  void signGoogle() {
  }

  void signApple() {
  }
}