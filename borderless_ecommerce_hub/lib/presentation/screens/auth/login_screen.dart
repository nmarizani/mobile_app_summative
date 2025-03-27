import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'onboarding_screen.dart'; // Import Onboarding Screen
import 'signup_screen.dart'; // Import SignupScreen
import 'password_reset_screen.dart'; // Import ForgotPasswordScreen

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E1E2C),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Text(
                'Sign in',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: emailController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFF2A2A3C),
                  labelText: 'Email Address',
                  labelStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF9370DB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () async {
                    // ✅ Save sign-in state
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setBool('isSignedIn', true);

                    // ✅ Navigate to OnboardingScreen
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => OnboardingScreen()),
                    );
                  },
                  child: Text('Continue', style: TextStyle(color: Colors.white)),
                ),
              ),
              SizedBox(height: 10),

              /// 🔹 Forgot Password Button
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                  );
                },
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),

              TextButton(
                onPressed: () {
                  // Navigate to Signup Page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupScreen()),
                  );
                },
                child: Text(
                  "Don't have an account? Create One",
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  _buildSocialButton('Continue With Apple', 'assets/icons/apple.png'),
                  SizedBox(height: 10),
                  _buildSocialButton('Continue With Google', 'assets/icons/google.png'),
                  SizedBox(height: 10),
                  _buildSocialButton('Continue With Facebook', 'assets/icons/facebook.png'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton(String text, String iconPath) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF2A2A3C),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {}, // TODO: Implement Social Sign-In
        icon: Image.asset(iconPath, height: 24),
        label: Text(text, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
