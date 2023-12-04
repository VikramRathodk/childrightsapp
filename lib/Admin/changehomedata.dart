import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChangeHomeData extends StatefulWidget {
  @override
  _ChangeHomeDataState createState() => _ChangeHomeDataState();
}

class _ChangeHomeDataState extends State<ChangeHomeData> {
  TextEditingController _textController = TextEditingController();

  Future<void> _addToDatabase() async {
    Map<String, dynamic> data = {'homeD': _textController.text};

    try {
      await FirebaseFirestore.instance
          .collection("homeData")
          .doc("first01")
          .set(data);

      // Show SnackBar upon successful data update
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Home data updated successfully!'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (error) {
      // Show SnackBar if an error occurs during data update
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update home data.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Enter new home data',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _addToDatabase();
              },
              child: Text('Update Home Data'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
