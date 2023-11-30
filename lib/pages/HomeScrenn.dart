import 'package:flutter/material.dart';

import '../Auth/Loginpage.dart';
import 'CommunityScreen.dart';
import 'HomeScreenContent.dart';
import 'QuizScreen.dart';
import 'VideosScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Current selected index

  // List of pages or widgets corresponding to each tab
  static List<Widget> _widgetOptions = <Widget>[
    HomeScreenContent(),
    VideosScreen(),
    QuizScreen(),
    CommunityScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Children Rights"),
        actions: [
          Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: InkWell(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Admin',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginPage();
                    },
                  ),
                );
              },
            ),
          )
        ],
      ),
      // drawer: Drawer(
      //   child: ListView(
      //     children: [
      //       ListTile(
      //         leading: const Icon(Icons.abc),
      //         title: const Text('Login to Admin'),
      //         trailing: ElevatedButton(
      //           child: const Text("Login"),
      //           onPressed: () {
      //             //  login logic
      //           },
      //         ),
      //       )
      //     ],
      //   ),
      // ),
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.play_arrow), label: 'Videos'),
          BottomNavigationBarItem(icon: Icon(Icons.book_sharp), label: 'Quiz'),
          BottomNavigationBarItem(
              icon: Icon(Icons.people_alt), label: 'Community'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      //update the index of the selected page
      _selectedIndex = index;
    });
  }
}
