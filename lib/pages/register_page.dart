import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:due_dates/components/my_textfield.dart';
import 'package:due_dates/components/signup_button.dart';
import 'package:firebase_core/firebase_core.dart';
import '../components/apple_button.dart';
import '../components/google_button.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState(); 
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmedPasswordController = TextEditingController();

  //Sign-Up method
  void signUserUp() async{
    // show loading circle
    showDialog(
      context: context,
      builder: (context){
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    // try creating the user
    try {
      // ignore: unrelated_type_equality_checks
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: usernameController.text,
          password: passwordController.text,
        );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //pop the loading circle
      Navigator.pop(context);
      // show error message
      errorMessage(e.code);
      // Handle and display the error
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
                    mainAxisAlignment:MainAxisAlignment.center,
                    children: [
                      const SizedBox(height:10),
                      // logo
                      const Icon(Icons.lock, size:50),
                      const SizedBox(height:10),
                      // Welcome to DueDates!
                      Text(
                        "Welcome to DueDates!Meet deadlines one day at a time!",
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

                      // Sign in button
                      SignupButton(
                        onTap: signUserUp,
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
                            'Already a user?',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          const SizedBox(width:4),
                          GestureDetector(
                            onTap: widget.onTap,
                            child: const Text(
                                'Login now',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                            ),
                          ),
                        ],
                      )
                    ],
                ),
              ),
            ),
        )
    );
  }

  void errorMessage(String message) {
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

  void signGoogle() {
  }

  void signApple() {
  }
}