import 'package:chatmate/app/home_screen.dart';
import 'package:chatmate/app/routes.dart';
import 'package:chatmate/core/theme/app_theme.dart';
import 'package:chatmate/features/auth/viewmodels/auth_viewmodel.dart';
import 'package:chatmate/features/auth/views/login_screen.dart';
import 'package:chatmate/features/auth/views/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      // Named routes for navigation
      routes: {
        AppRoutes.login: (context) => const LoginScreen(),
        AppRoutes.signup: (context) => const SignupScreen(),
        AppRoutes.home: (context) => const HomeScreen(),
      },

      // Check auth state and show appropriate screen
      home: Consumer<AuthViewModel>(
        builder: (context, authViewModel, child) {
          // Show loading while checking auth state
          if (authViewModel.isLoading && authViewModel.currentUser == null) {
            return _buildLoadingScreen();
          }

          // Show home if logged in, login if not
          return authViewModel.isLoggedIn
              ? const HomeScreen()
              : const LoginScreen();
        },
      ),
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
