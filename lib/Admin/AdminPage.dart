import 'package:childrightapp/Admin/changehomedata.dart';
import 'package:childrightapp/Admin/manageQuiz.dart';
import 'package:childrightapp/pages/HomeScrenn.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'ManageVideosPage.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Admin'),
          
          actions: [
            ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
              },
              child: Text("Logout"),
            ),
          ],
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.play_arrow),
              ),
              Tab(
                icon: Icon(Icons.quiz_sharp),
              ),
              Tab(
                icon: Icon(Icons.home),
              ),
              
            ],
          ),
        ),
        body:  TabBarView(
          children: <Widget>[
             ManageVideosPage(),
            CreateQuizPage(),
            ChangeHomeData(),
            
          ],
        ),
      ),
    );
  }
}
