import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(user?.photoURL ?? ""),
              radius: 40,
            ),
            SizedBox(height: 10),
            Text(user?.displayName ?? "User", style: TextStyle(fontSize: 18)),
            Text(user?.email ?? "", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
