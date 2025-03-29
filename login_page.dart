import 'package:first_app/functionalities_page.dart';
import 'package:flutter/material.dart';
import 'signup_page.dart'; // Import the SignupPage
import 'roomyx_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final double logoWidth = screenSize.width * 0.5; // 50% of screen width
    final double boxWidth = screenSize.width * 0.85; // 85% of screen width
    final double buttonWidth = (boxWidth - 60) / 2; // Accounting for padding

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            height: screenSize.height,
            child: Column(
              children: [
                // UnyLink Logo
                Padding(
                  padding: EdgeInsets.only(top: screenSize.height * 0.08),
                  child: Image.asset(
                    'assets/images/logo with name.jpg',
                    width: logoWidth.clamp(150.0, 200.0),
                  ),
                ),
                SizedBox(
                  height: screenSize.height * 0.02,
                ), // Changed from negative value
                Container(
                  width: boxWidth,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.all(screenSize.width * 0.05),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8.1,
                        offset: const Offset(6, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Tabs
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildTabButton('SIGN UP', false, buttonWidth, () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignupPage(),
                              ),
                            );
                          }),
                          _buildTabButton('LOGIN', true, buttonWidth, () {}),
                        ],
                      ),
                      SizedBox(height: screenSize.height * 0.03),
                      // Input Fields
                      _buildTextField('EMAIL OR PHONE NUMBER'),
                      SizedBox(height: screenSize.height * 0.02),
                      _buildTextField('PASSWORD'),
                      SizedBox(height: screenSize.height * 0.03),
                      // Login Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const FunctionalitiesPage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF010857),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: const Text(
                            'LOGIN',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.02),
                      // Social Media Login
                      const Text('OR'),
                      SizedBox(height: screenSize.height * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Image.asset('assets/images/google.jpg'),
                            iconSize: screenSize.width * 0.08,
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Image.asset('assets/images/facebook.jpg'),
                            iconSize: screenSize.width * 0.08,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabButton(
      String text,
      bool isActive,
      double width,
      VoidCallback onPressed,
      ) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
          isActive ? const Color(0xFF010857) : const Color(0xFFF0F3F2),
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(color: isActive ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  Widget _buildTextField(String hint) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(4, 4),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.black),
          filled: true,
          fillColor: const Color(0xFFE7E7E7),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
        ),
      ),
    );
  }
}