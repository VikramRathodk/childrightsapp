import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ForumPost {
  final String title;
  final String content;
  final String link;

  ForumPost({
    required this.title,
    required this.content,
    required this.link,
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
      title: 'Bal Raksha Bharat',
      content:
          'For lasting change to happen, the hands of many must join as one. Since 2008, we’ve partnered with agencies at various levels towards actualizing the vision to build a new “Bharat”: one where children are given equal opportunities, wholesome nutrition and protection from exploitation; to untap the true potential of our Nation. We believe that a childhood nurtured holistically is a future well-secured.',
      link: 'https://balrakshabharat.org/',
    ),
    ForumPost(
      title: 'CRY (Child Rights and you)',
      content:
          'At CRY, they are committed to their vision for a happy, healthy, and creative childhood for every child. They include ensuring children in CRY-supported projects have access to free and quality education, primary healthcare and are safe from violence, abuse, and exploitation.',
      link: 'https://www.cry.org/',
    ),
    ForumPost(
      title: 'Child Help Foundation',
      content:
          'Founded in 2010, Child Help Foundation (CHF) is a child-centric national non-profit organization committed to fulfillment of Child Rights as enshrined in the Indian constitution and UNCRC (United Nation Convention on the Rights of the Child).',
      link: 'https://childhelpfoundation.in/',
    ),
    ForumPost(
      title: 'The Akshaya Patra Foundation',
      content:
          'The Akshaya Patra Foundation is a non-profit organisation that operates on a public-private partnership (PPP) model. Since Akshaya Patra acts as an implementing partner of the Mid-Day Meal Scheme, there is firm support from the Government of India, the State Governments, and associated organizations.',
      link: 'https://www.akshayapatra.org/',
    ),
    ForumPost(
      title: 'Katha Foundation',
      content:
          'Started in 1988 with a magazine for children from the underserved communities, Katha’s work spans the literacy to literature continuum. By seamlessly connecting grassroots work in education and urban resurgence, Katha brings children living in poverty into reading and quality education.',
      link: 'https://www.katha.org/',
    ),
    ForumPost(
      title: 'K C Mahindra Education Trust (Nanhi Kali)',
      content:
          'Project Nanhi Kali provides 360-degree support to underprivileged girls from Class 1-10, with the objective of enabling them to complete their schooling with dignity.',
      link: 'https://crm.fundoodata.com/users/login',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: childrenRightsForumPosts.length,
        itemBuilder: (context, index) {
          final Uri _url = Uri.parse(childrenRightsForumPosts[index].link);
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
                  GestureDetector(
                    onTap: () =>
                        _launchUrl(_url),
                    child: Text(
                      'Link: ${childrenRightsForumPosts[index].link}',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

 Future<void> _launchUrl(Uri url) async {
  try {
    if (!await launch(url.toString())) {
      throw 'Could not launch $url';
    }
  } catch (e) {
    print('Error launching URL: $e');
  }
}

}
