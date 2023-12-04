import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreenContent extends StatefulWidget {
  const HomeScreenContent({Key? key}) : super(key: key);

  @override
  State<HomeScreenContent> createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreenContent> {
  Future<DocumentSnapshot<Map<String, dynamic>>> _fetchHomeData() async {
    return await FirebaseFirestore.instance
        .collection('homeData')
        .doc('first01')
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: _fetchHomeData(),
            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                String homeData = snapshot.data!.get('homeD') ?? ''; // Get the 'homeD' field from Firestore

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // _________________________________________________
                    // Displaying fetched image
                    Container(
                      child: Image(
                        image: AssetImage('assets/images/landing.jpg'),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    //  _________________________________________________
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        homeData, // Display fetched homeData
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
