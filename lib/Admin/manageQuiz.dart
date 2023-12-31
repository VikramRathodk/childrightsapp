import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz Management App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CreateQuizPage(),
    );
  }
}

class CreateQuizPage extends StatefulWidget {
  @override
  _CreateQuizPageState createState() => _CreateQuizPageState();
}

class _CreateQuizPageState extends State<CreateQuizPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _option1Controller = TextEditingController();
  final TextEditingController _option2Controller = TextEditingController();
  final TextEditingController _option3Controller = TextEditingController();
  final TextEditingController _option4Controller = TextEditingController();
  final TextEditingController _correctAnswerController =
      TextEditingController();

  bool isEditing = false;
  late String quizIdToUpdate;

  void _submit() async {
    try {
      // Validate form fields
      if (!_formKey.currentState!.validate()) {
        return;
      }

      // Add or update quiz data to Firebase Firestore
      if (isEditing) {
        await FirebaseFirestore.instance
            .collection('quizzes')
            .doc(quizIdToUpdate)
            .update({
          'category': _categoryController.text,
          'question': _questionController.text,
          'options': [
            _option1Controller.text,
            _option2Controller.text,
            _option3Controller.text,
            _option4Controller.text,
          ],
          'correctAnswer': _correctAnswerController.text,
        });
      } else {
        await FirebaseFirestore.instance.collection('quizzes').add({
          'category': _categoryController.text,
          'question': _questionController.text,
          'options': [
            _option1Controller.text,
            _option2Controller.text,
            _option3Controller.text,
            _option4Controller.text,
          ],
          'correctAnswer': _correctAnswerController.text,
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text(isEditing ? 'Quiz Updated!' : 'Quiz Added successfully!'),
          duration: Duration(seconds: 2),
        ),
      );

      // Clear input fields after submitting the quiz
      _categoryController.clear();
      _questionController.clear();
      _option1Controller.clear();
      _option2Controller.clear();
      _option3Controller.clear();
      _option4Controller.clear();
      _correctAnswerController.clear();
      setState(() {
        isEditing = false;
      });
    } catch (e) {
      print('Error submitting quiz: $e');
    }
  }

  void _editQuiz(DocumentSnapshot quiz) {
    setState(() {
      isEditing = true;
      quizIdToUpdate = quiz.id;
      _categoryController.text = quiz['category'];
      _questionController.text = quiz['question'];
      List<dynamic> options = quiz['options'];
      _option1Controller.text = options[0];
      _option2Controller.text = options[1];
      _option3Controller.text = options[2];
      _option4Controller.text = options[3];
      _correctAnswerController.text = quiz['correctAnswer'];
    });
  }

  void _deleteQuiz(String quizId) async {
    try {
      await FirebaseFirestore.instance
          .collection('quizzes')
          .doc(quizId)
          .delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Quiz Deleted!'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      print('Error deleting quiz: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              
              TextFormField(
                controller: _categoryController,
                decoration: InputDecoration(
                  labelText: 'Category',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the category';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _questionController,
                decoration: InputDecoration(
                  labelText: 'Question',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the question';
                  }
                  return null;
                },
              ),
SizedBox(height: 16.0),
              TextFormField(
                controller: _option1Controller,
                decoration: InputDecoration(
                  labelText: 'Option 1',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Colors.blue, // Change the border color
                      width: 2.0,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter option 1';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _option2Controller,
                decoration: InputDecoration(
                  labelText: 'Option 2',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Colors.blue, // Change the border color
                      width: 2.0,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter option 2';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _option3Controller,
                decoration: InputDecoration(
                  labelText: 'Option 3',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Colors.blue, // Change the border color
                      width: 2.0,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter option 3';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _option4Controller,
                decoration: InputDecoration(
                  labelText: 'Option 4',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Colors.blue, // Change the border color
                      width: 2.0,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter option 4';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _correctAnswerController,
                decoration: InputDecoration(
                  labelText: 'Correct Answer',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(
                      color: Colors.blue, // Change the border color
                      width: 2.0,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the correct answer';
                  }
                  return null;
                },
              ),              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: _submit,
                child: Text(isEditing ? 'Update Quiz' : 'Submit'),
              ),
              SizedBox(height: 24.0),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('quizzes')
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot quiz = snapshot.data!.docs[index];
                      return ListTile(
                        title: Text(quiz['question']),
                        subtitle: Text(quiz['category']),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () => _editQuiz(quiz),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () => _deleteQuiz(quiz.id),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}