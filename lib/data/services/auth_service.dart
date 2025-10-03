import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

// Custom exceptions for better error handling
class AuthException implements Exception {
  final String message;
  AuthException(this.message);

  @override
  String toString() => 'AuthException: $message';
}

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Logger _logger = Logger();

  // Sign up with email and password
  Future<User?> signUpWithEmail(String email, String password) async {
    try {
      _logger.i('Attempting to sign up user: $email');

      final UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      _logger.i('User signed up successfully: ${userCredential.user?.email}');
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      _logger.e('Firebase sign up error: ${e.code} - ${e.message}');

      // Convert Firebase errors to user-friendly messages
      switch (e.code) {
        case 'email-already-in-use':
          throw AuthException(
            'This email is already registered. Please try logging in.',
          );
        case 'invalid-email':
          throw AuthException('Please enter a valid email address.');
        case 'operation-not-allowed':
          throw AuthException(
            'Email/password accounts are not enabled. Please contact support.',
          );
        case 'weak-password':
          throw AuthException(
            'Please choose a stronger password (at least 6 characters).',
          );
        default:
          throw AuthException('Sign up failed. Please try again.');
      }
    } catch (e) {
      _logger.e('Unexpected sign up error: $e');
      throw AuthException('An unexpected error occurred. Please try again.');
    }
  }

  // Sign in with email and password
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      _logger.i('Attempting to sign in user: $email');

      final UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      _logger.i('User signed in successfully: ${userCredential.user?.email}');
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      _logger.e('Firebase sign in error: ${e.code} - ${e.message}');

      switch (e.code) {
        case 'invalid-email':
          throw AuthException('Please enter a valid email address.');
        case 'user-disabled':
          throw AuthException(
            'This account has been disabled. Please contact support.',
          );
        case 'user-not-found':
          throw AuthException(
            'No account found with this email. Please sign up first.',
          );
        case 'wrong-password':
          throw AuthException('Incorrect password. Please try again.');
        default:
          throw AuthException(
            'Sign in failed. Please check your credentials and try again.',
          );
      }
    } catch (e) {
      _logger.e('Unexpected sign in error: $e');
      throw AuthException('An unexpected error occurred. Please try again.');
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      _logger.i('Signing out user');
      await _firebaseAuth.signOut();
      _logger.i('User signed out successfully');
    } catch (e) {
      _logger.e('Sign out error: $e');
      throw AuthException('Failed to sign out. Please try again.');
    }
  }

  // Get current user
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  // Check if user is logged in
  bool get isLoggedIn => _firebaseAuth.currentUser != null;

  // Auth state changes stream (for real-time updates)
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
}
