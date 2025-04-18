import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetask/login/login_screen.dart';
import 'package:firebasetask/screens/home_screen.dart';
import 'package:firebasetask/screens/settings_screen.dart';
import 'package:firebasetask/signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebasetask/screens/profile_screen.dart';
import 'package:intl/date_symbol_data_local.dart'; // ✅ Tambahkan ini

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializeDateFormatting(
    'id_ID',
    null,
  ); // ✅ Inisialisasi locale untuk DateFormat
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUpScreen(),
        '/home': (context) => HomeScreen(),
        '/settings': (context) => SettingsScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasData) {
          return HomeScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
