import 'package:flutter/material.dart';
import 'package:netflix_clone/Screens/screen_home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      toHomeScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset(
          'lib/assets/Amazone logo.png',
          height: 130,
        ),
      ),
    );
  }

  Future<void> toHomeScreen() async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (ctx) => const ScreenHome()));
  }
}
