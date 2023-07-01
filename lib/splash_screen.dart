import 'package:flutter/material.dart';
import 'package:kitchen_genie/inputpage.dart';
import 'package:kitchen_genie/recipe_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToHomePage();
  }

  void navigateToHomePage() async {
    await Future.delayed(Duration(seconds: 2)); // Display image for 1 second

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color myColor = Color(0xFF39FF02);

    return Scaffold(
      body: Container(
        color: myColor,
        child: Image.asset(
          'assets/image/splash_screen.gif', // Replace with your image asset
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }

}
