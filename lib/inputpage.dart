import 'package:flutter/material.dart';
import 'package:kitchen_genie/recipe_page.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

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
          FadeTransition(
            opacity: _animation,
            child: Container(
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
                  'Welcome to Kitchen Genie!\n\nYour culinary companion that transforms ingredients into nourishing meals. With a few taps, unlock personalized recipes tailored to your pantry, tackling food insecurity and minimizing waste. Let Kitchen Genie grant your culinary wishes for a more sustainable and inclusive food future!',
                  style: TextStyle(
                    fontSize: 16,
                    color: myColor,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.justify,
                ),
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
            style: ElevatedButton.styleFrom(
              backgroundColor: myColor2,
            ),
            child: Text(
              'Get Started',
              style: TextStyle(color: myColor),
            ),
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
