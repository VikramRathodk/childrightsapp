import 'package:flutter/material.dart';

class HomeScreenContent extends StatefulWidget {
  const HomeScreenContent({super.key});

  @override
  State<HomeScreenContent> createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreenContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // _________________________________________________
            //image is not loading the homescreen content
            Container(
                child: Image(
              image: AssetImage('assets/images/landing.jpg'),
            )),
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
                "Kids should not be forced to work and should have the chance to play and learn instead.\nWhen kids don't have to do heavy work, they can explore things they love, like drawing, playing sports, or just hanging out with friends. That's how they learn and get ready for their future.",
                style: TextStyle(fontSize: 16.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
