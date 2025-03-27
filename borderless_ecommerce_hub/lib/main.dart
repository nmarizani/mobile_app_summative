import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'presentation/screens/auth/splash_screen.dart';
import 'presentation/screens/auth/login_screen.dart';
import 'presentation/screens/auth/onboarding_screen.dart';
import 'presentation/screens/home/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Widget _defaultHome;

  @override
  void initState() {
    super.initState();
    _defaultHome = SplashScreen(); // Start with Splash Screen
    _determineStartScreen();
  }

  Future<void> _determineStartScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isSignedIn = prefs.getBool('isSignedIn') ?? false;
    bool onboardingComplete = prefs.getBool('onboardingComplete') ?? false;

    await Future.delayed(const Duration(seconds: 3)); // Simulate splash screen delay

    setState(() {
      if (!isSignedIn) {
        _defaultHome = LoginScreen(); // Show Sign-In screen first
      } else if (!onboardingComplete) {
        _defaultHome = OnboardingScreen(); // Show Onboarding if not done
      } else {
        _defaultHome = HomeScreen(); // Otherwise, go to Home
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Borderless App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _defaultHome,
    );
  }
}