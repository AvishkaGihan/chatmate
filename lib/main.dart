import 'package:chatmate/core/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:chatmate/app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    logger.i('Firebase initialized successfully! 🔥');
  } catch (e) {
    logger.e('Error initializing Firebase: $e');
  }

  runApp(const ChatMateApp());
}
