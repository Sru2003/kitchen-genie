import 'package:flutter/material.dart';
import 'package:kitchen_genie/recipe_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color myColor = Color(0xFF003366);
    Color myColor2 = Color(0xFF39FF02);
    Color myColor3 = Color(0xFFFFCC00);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: myColor2,
        shadowColor: Colors.lightGreenAccent,
        title: Center(
          child: Text(
            'Kitchen Genie',
            style: TextStyle(
              color: myColor,
              fontSize: 30,
              fontFamily: 'ShortBaby',
            ),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 40,
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.yellowAccent,
                  spreadRadius: 3,
                  blurRadius: 10,
                ),
              ],
              color: myColor3,
              borderRadius: BorderRadius.circular(11),
            ),
            width: 400,
            height: 200,
            child: Center(
              child: Text(
                'Welcome to Kitchen Genie!\n\nThis app helps you generate recipes based on the ingredients you have. Get started by tapping the button below!',
                style: TextStyle(
                  fontSize: 16,
                  color: myColor,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatGPTScreen()),
              );
            },
            child: Text('Get Started'),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}
