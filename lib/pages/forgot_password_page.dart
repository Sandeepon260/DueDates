import 'package:flutter/material.dart';

import '../components/my_textfield.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Padding(
          padding: const EdgeInsets.symmetric(),
        )
          Text(
            'Please enter your email and a link will be sent to your email to reset your password',
            textAlign: TextAlign.center,
        ),
        // Email textfield
        MyTextField(
          controller: usernameController,
          hintText: 'Email',
          obscureText: false,
        ),
        MaterialButton(
            onPressed: (){},
          color: Colors.grey,
          child: Text(
              'Reset Password',
          ),
        ),
      ],)
    );
  }
}

