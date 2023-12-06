import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreenContent extends StatefulWidget {
  const HomeScreenContent({Key? key}) : super(key: key);

  @override
  State<HomeScreenContent> createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreenContent> {
  late String homeData;
  late List<bool> _isExpandedList;

  @override
  void initState() {
    super.initState();
    _isExpandedList = [false, false, false, false];
    fetchHomeData();
  }

  Future<void> fetchHomeData() async {
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('homeData').doc('first01').get();

    setState(() {
      homeData = snapshot.get('homeD') ?? '';
    });
  }

  Widget _buildCard(
      String title, String imagePath, String description, int index) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Image.asset(
                  imagePath,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              _isExpandedList[index] ? description : '',
              textAlign: TextAlign.justify,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextButton(
              onPressed: () {
                setState(() {
                  _isExpandedList[index] = !_isExpandedList[index];
                });
              },
              child: Text(
                _isExpandedList[index] ? 'Show Less' : 'Show More',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Displaying fetched image
              Container(
                child: Image(
                  image: AssetImage('assets/images/landing.jpg'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // Displaying fetched homeData
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: EdgeInsets.all(16.0),
                child: Text(
                  homeData,
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              SizedBox(height: 20),
              // Four cards with title, image, and expandable description
              _buildCard(
                  "Right to equality", "assets/images/card1.png", "Article 14 of the Constitution of India states that every person is equal before the law and has equal protection of the laws. Thus, this right is applicable to children of India, as well, because, they too, are the citizens of this nation.", 0),
              _buildCard(
                  "Right against discrimination", "assets/images/card2.jpg", "Article 15 of the Constitution talks about the prohibition of discrimination based on race, caste, etc. Under Article 15(1), no citizen shall be discriminated against based on his religion, race, caste, sex, place of birth or any of them. Further, Article 15(3) states that the State shall not be prevented from making any special provisions for women and children.", 1),
              _buildCard(
                  "Right to freedom of expression", "assets/images/card3.jpg", "Article 19(1)(a) has conferred a right to freedom of speech and expression to each and every citizen of India. This right is applicable to everyone, including the children of India. Children have the liberty of expression as long as their opinions and knowledge do not harm others.", 2),
              _buildCard(
                  "Right to health", "assets/images/card4.jpg", "Under Article 21 of the Constitution of India, although indirectly, every child has the right to lead a healthy life. Issues like HIV infections, lack of safe drinking water, adequate sanitation, malnutrition, inter alia, come under the protection of life. ", 3),
            ],
          ),
        ),
      ),
    );
  }
}
