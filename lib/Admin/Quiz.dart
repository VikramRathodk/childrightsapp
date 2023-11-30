
class Quiz {
  final String category;
  final String question;
  final List<String> options;
  final String correctAnswer;

  Quiz({
    required this.category,
    required this.question,
    required this.options,
    required this.correctAnswer,
  });

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'question': question,
      'options': options,
      'correctAnswer': correctAnswer,
    };
  }
}
List<Quiz> sampleQuizzes = [
  Quiz(
    category: 'Math',
    question: 'What is 2 + 2?',
    options: ['1', '2', '4', '5'],
    correctAnswer: '4',
  ),
  Quiz(
    category: 'Science',
    question: 'What is the boiling point of water?',
    options: ['50°C', '75°C', '100°C', '120°C'],
    correctAnswer: '100°C',
  )];