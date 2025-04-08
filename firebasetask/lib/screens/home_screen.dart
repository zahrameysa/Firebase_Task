import 'package:firebasetask/screens/feature_menu.dart'; // Import FeatureMenu
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String userName = "User";
  String? photoUrl;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  void _getUserData() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userName = user.displayName ?? "User";
        photoUrl = user.photoURL;
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg_home.png',
              fit: BoxFit.fitWidth,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/profile',
                        ); // Navigasi ke profil
                      },
                      child: Row(
                        children: [
                          photoUrl != null
                              ? CircleAvatar(
                                backgroundImage: NetworkImage(photoUrl!),
                                radius: 20,
                              )
                              : CircleAvatar(
                                child: Icon(Icons.person, size: 24),
                                radius: 20,
                              ),
                          SizedBox(width: 10),
                          Text(
                            userName,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.notifications,
                      color: Color(0xffFFD95F),
                      size: 32,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // Panggil FeatureMenu di sini
                Expanded(child: FeatureMenu()),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: "Payments",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.edit), label: "Requests"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
          BottomNavigationBarItem(
            icon: Icon(Icons.handshake),
            label: "Activity",
          ),
        ],
        selectedItemColor: Color(0xff2F7EF7),
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
