import 'package:flutter/material.dart';

class ForumPost {
  final String title;
  final String content;
  final String author;
  final DateTime date;

  ForumPost({
    required this.title,
    required this.content,
    required this.author,
    required this.date,
  });
}

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  List<ForumPost> childrenRightsForumPosts = [
    ForumPost(
      title: 'Importance of Education for Every Child',
      content:
          'Education is a fundamental right for every child. It empowers them to build a better future. How can we ensure access to quality education for all children?',
      author: 'ChildAdvocate1',
      date: DateTime(2023, 10, 20),
    ),
    ForumPost(
      title: 'Child Protection Laws Discussion',
      content:
          'Discussing the effectiveness of current child protection laws and potential improvements. What steps can be taken to ensure better protection for children in various contexts?',
      author: 'RightsAdvocate23',
      date: DateTime(2023, 11, 5),
    ),
    ForumPost(
      title: 'Child Labor Issues and Solutions',
      content:
          'The issue of child labor persists in many parts of the world. Let\'s brainstorm solutions and actions to eradicate child labor and provide better opportunities for children.',
      author: 'ActivistForKids',
      date: DateTime(2023, 11, 15),
    ),
    ForumPost(
      title: 'Addressing Mental Health Challenges in Children',
      content:
          'Mental health issues among children are a growing concern. Let\'s discuss strategies to address mental health challenges and provide adequate support and resources for children.',
      author: 'MentalHealthAwareness',
      date: DateTime(2023, 12, 5),
    ),
    ForumPost(
      title: 'Promoting Child Participation in Decision Making',
      content:
          'Empowering children to participate in decisions that affect them is vital. How can we encourage and facilitate meaningful participation of children in decision-making processes?',
      author: 'ChildRightsActivist',
      date: DateTime(2023, 12, 15),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
        body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.7, // Adjust this ratio as needed
          ),
          itemCount: childrenRightsForumPosts.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 2.0,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      childrenRightsForumPosts[index].title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(childrenRightsForumPosts[index].content),
                    SizedBox(height: 8.0),
                    Text(
                      'By ${childrenRightsForumPosts[index].author} - ${childrenRightsForumPosts[index].date}',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
