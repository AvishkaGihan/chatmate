import 'package:flutter/material.dart';
import '../../../data/services/auth_service.dart';
import '../../../data/models/user_model.dart';

class AuthViewModel with ChangeNotifier {
  final AuthService _authService = AuthService();

  UserModel? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isLoggedIn => _currentUser != null;

  // Initialize viewmodel
  AuthViewModel() {
    _initializeUser();
  }

  // Check if user is already logged in
  void _initializeUser() {
    final user = _authService.getCurrentUser();
    if (user != null) {
      _currentUser = UserModel.fromFirebase(user);
      notifyListeners();
    }
  }

  // Login with email and password
  Future<void> login(String email, String password) async {
    _setLoading(true);
    _clearError();

    try {
      final user = await _authService.signInWithEmail(email, password);
      if (user != null) {
        _currentUser = UserModel.fromFirebase(user);
        _showSuccessMessage('Welcome back!');
      }
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // Sign up with email and password
  Future<void> signup(String name, String email, String password) async {
    _setLoading(true);
    _clearError();

    try {
      final user = await _authService.signUpWithEmail(email, password);
      if (user != null) {
        // Update display name
        await user.updateDisplayName(name);
        _currentUser = UserModel.fromFirebase(user);
        _showSuccessMessage('Account created successfully!');
      }
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // Sign out
  Future<void> logout() async {
    _setLoading(true);
    _clearError();

    try {
      await _authService.signOut();
      _currentUser = null;
      _showSuccessMessage('Signed out successfully');
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Private helper methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void _showSuccessMessage(String message) {
    // This would typically use a ScaffoldMessenger, but we'll handle it in the UI
    debugPrint('Success: $message');
  }
}
