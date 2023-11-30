import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:childrightapp/Admin/Quiz.dart'; // Import your Quiz model

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> _quizStream =
      Stream.empty(); // Stream to fetch quizzes from Firestore
  late List<Quiz> _quizzes = []; // List to hold fetched quizzes
  Map<int, String?> selectedAnswers = {}; // Map to store user selected answers

  @override
  void initState() {
    super.initState();
    // Initialize the stream to fetch quiz data from Firestore
    _quizStream = FirebaseFirestore.instance.collection('quizzes').snapshots();

    // Load all quizzes into a list
    _quizStream.listen((event) {
      setState(() {
        _quizzes = event.docs.map((doc) {
          final quizData = doc.data() as Map<String, dynamic>;
          return Quiz(
            category: quizData['category'],
            question: quizData['question'],
            options: List<String>.from(quizData['options']),
            correctAnswer: quizData['correctAnswer'],
          );
        }).toList();
      });
    });
  }

  int calculateScoreForCategory(List<Quiz> categoryQuizzes, Map<int, String?> selectedAnswers) {
    int score = 0;
    for (int index = 0; index < categoryQuizzes.length; index++) {
      Quiz quiz = categoryQuizzes[index];
      String? selectedAnswer = selectedAnswers[index];
      if (selectedAnswer == quiz.correctAnswer) {
        score++;
      }
    }
    return score;
  }

  @override
  Widget build(BuildContext context) {
    if (_quizzes.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final List<String> categories =
        _quizzes.map((quiz) => quiz.category).toSet().toList();

    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            isScrollable: true,
            tabs: categories.map((category) {
              return Tab(
                text: category,
              );
            }).toList(),
          ),
        ),
        body: TabBarView(
          children: categories.map((category) {
            final categoryQuizzes =
                _quizzes.where((quiz) => quiz.category == category).toList();

            return ListView.builder(
              itemCount: categoryQuizzes.length + 1, // +1 for the submit button
              itemBuilder: (context, index) {
                if (index == categoryQuizzes.length) {
                  // Last item in the list, show the submit button
                  return Padding(
                    padding: EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        int score = calculateScoreForCategory(categoryQuizzes, selectedAnswers);
                        final snackBar = SnackBar(
                          content: Text('Category: $category - Score: $score / ${categoryQuizzes.length}'),
                          duration: Duration(seconds: 2), // Adjust the duration as needed
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      child: Text('Submit'),
                    ),
                  );
                } else {
                  final quiz = categoryQuizzes[index];
                  return Card(
                    margin: EdgeInsets.all(8.0),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Question: ${quiz.question}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8.0),
                          // Display options as RadioListTile for user selection
                          ...quiz.options.asMap().entries.map(
                            (entry) {
                              final optionIndex = entry.key;
                              final option = entry.value;

                              return RadioListTile<String>(
                                title: Text(option),
                                value: option,
                                groupValue: selectedAnswers[index],
                                onChanged: (value) {
                                  setState(() {
                                    selectedAnswers[index] = value;
                                  });
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
