import 'package:chatmate/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ChatMateApp extends StatelessWidget {
  const ChatMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatMate',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, // Auto light/dark mode
      debugShowCheckedModeBanner: false, // Remove debug banner
      home: _buildLoadingScreen(),
    );
  }

  Widget _buildLoadingScreen() {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App icon/logo placeholder
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.chat_bubble,
                size: 50,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'ChatMate',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'AI-Powered Chat Assistant',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 30),
            // Loading indicator
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
