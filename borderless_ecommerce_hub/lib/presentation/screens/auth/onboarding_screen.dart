import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../home/home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  
  Future<void> _completeOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboardingComplete', true);
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 100),
            Text(
              'Tell us About Yourself',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              'Who do you shop for?',
              style: TextStyle(fontSize: 18, color: Colors.white70),
            ),
            Row(
              children: [
                _buildOptionButton('Men', Colors.purple),
                SizedBox(width: 10),
                _buildOptionButton('Women', Colors.grey),
              ],
            ),
            SizedBox(height: 20),
            Text('How Old are you?', style: TextStyle(fontSize: 18, color: Colors.white70)),
            SizedBox(height: 10),
            DropdownButtonFormField(
              dropdownColor: Colors.black,
              items: [
                DropdownMenuItem(child: Text('18-25', style: TextStyle(color: Colors.white)), value: '18-25'),
                DropdownMenuItem(child: Text('26-35', style: TextStyle(color: Colors.white)), value: '26-35'),
              ],
              onChanged: (value) {},
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: _completeOnboarding,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text('Finish', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton(String text, Color color) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Text(text, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}