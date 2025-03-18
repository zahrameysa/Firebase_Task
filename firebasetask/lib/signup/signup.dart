import 'package:firebasetask/login/login_screen.dart';
import 'package:firebasetask/services/auth_service.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    "Register Account",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Login to access your account",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            Text(
              "Email Address",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: "Enter Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            SizedBox(height: 16),

            Text("Password", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Enter Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            SizedBox(height: 8),

            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Forgot Password?",
                style: TextStyle(color: Colors.red),
              ),
            ),
            SizedBox(height: 16),

            ElevatedButton(
              onPressed: () async {
                print("Sign Up button pressed"); // Debugging log

                String email = _emailController.text.trim();
                String password = _passwordController.text.trim();

                if (email.isEmpty || password.isEmpty) {
                  print("Email or password is empty");
                  return;
                } else {
                  try {
                    final user = await AuthService().signup(
                      email: email,
                      password: password,
                    );
                    if (user != null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    }
                    print("Sign Up success");
                  } catch (e) {
                    print("Error during Sign Up: $e");
                  }
                }
              },
              child: Text("Sign Up"),
            ),

            SizedBox(height: 24),

            Center(
              child: Text(
                "Or Sign in with",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 24),

            Container(
              padding: EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.grey),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/google.png", height: 16),
                  SizedBox(width: 8),
                  Text("Google", style: TextStyle(fontSize: 14)),
                ],
              ),
            ),
            SizedBox(height: 24),

            Center(
              child: RichText(
                text: TextSpan(
                  text: "Already Have Account? ",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                  children: [
                    TextSpan(
                      text: 'Log In',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // void _signUp() async {
  // print("Sign Up button pressed"); // Debugging log

  // String email = _emailController.text.trim();
  // String password = _passwordController.text.trim();

  // if (email.isEmpty || password.isEmpty) {
  //   print("Email or password is empty");
  //   return;
  // } else {
  //   try {
  //     final user = await AuthService().signup(
  //       email: email,
  //       password: password,
  //     );
  //     if (user != null) {
  //         // Navigator.pushReplacement(
  //         //   context,
  //         //   MaterialPageRoute(builder: (context) => LoginScreen()),
  //         // );
  //     }
  //     print("Sign Up success");
  //   } catch (e) {
  //     print("Error during Sign Up: $e");
  //   }
  // }
}
