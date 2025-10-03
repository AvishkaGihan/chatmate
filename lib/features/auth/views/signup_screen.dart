import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../shared/widgets/error_message.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreeToTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  void _signup() {
    if (_formKey.currentState!.validate() && _agreeToTerms) {
      FocusScope.of(context).unfocus();

      final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
      authViewModel
          .signup(
            _nameController.text.trim(),
            _emailController.text.trim(),
            _passwordController.text,
          )
          .then((_) {
            // Pop the signup screen to reveal the home screen
            Navigator.pop(context);
          });
    } else if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please agree to the Terms & Conditions')),
      );
    }
  }

  void _navigateToLogin() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back button
                IconButton(
                  onPressed: _navigateToLogin,
                  icon: const Icon(Icons.arrow_back),
                ),
                const SizedBox(height: 40),

                // Header
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.chat_bubble_outline,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Create Account',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Join ChatMate and start chatting with AI',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 48),

                // Name field
                CustomTextField(
                  label: 'Full Name',
                  hintText: 'Enter your full name',
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),

                // Email field
                CustomTextField(
                  label: 'Email Address',
                  hintText: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!_isValidEmail(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),

                // Password field
                CustomTextField(
                  label: 'Password',
                  hintText: 'Create a password',
                  obscureText: _obscurePassword,
                  controller: _passwordController,
                  validator: _validatePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),

                Builder(
                  builder: (context) {
                    final password = _passwordController.text;
                    String strengthText = '';
                    Color strengthColor = Colors.grey;

                    if (password.length >= 8) {
                      strengthText = 'Strong password ✓';
                      strengthColor = Colors.green;
                    } else if (password.length >= 6) {
                      strengthText = 'Medium password';
                      strengthColor = Colors.orange;
                    } else if (password.isNotEmpty) {
                      strengthText = 'Weak password';
                      strengthColor = Colors.red;
                    }

                    return password.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              strengthText,
                              style: TextStyle(
                                color: strengthColor,
                                fontSize: 12,
                              ),
                            ),
                          )
                        : const SizedBox.shrink();
                  },
                ),

                // Confirm password field
                CustomTextField(
                  label: 'Confirm Password',
                  hintText: 'Confirm your password',
                  obscureText: _obscureConfirmPassword,
                  controller: _confirmPasswordController,
                  validator: _validateConfirmPassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                ),

                // Terms and conditions
                Row(
                  children: [
                    Checkbox(
                      value: _agreeToTerms,
                      onChanged: (value) {
                        setState(() {
                          _agreeToTerms = value ?? false;
                        });
                      },
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // TODO: Show terms and conditions
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Terms & Conditions coming soon!'),
                            ),
                          );
                        },
                        child: Text(
                          'I agree to the Terms & Conditions and Privacy Policy',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Error message
                Consumer<AuthViewModel>(
                  builder: (context, authViewModel, child) {
                    if (authViewModel.errorMessage != null) {
                      return ErrorMessage(
                        message: authViewModel.errorMessage!,
                        onRetry: authViewModel.clearError,
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                const SizedBox(height: 16),

                // Sign up button
                Consumer<AuthViewModel>(
                  builder: (context, authViewModel, child) {
                    return PrimaryButton(
                      text: 'Create Account',
                      onPressed: _signup,
                      isLoading: authViewModel.isLoading,
                      enabled: !authViewModel.isLoading && _agreeToTerms,
                    );
                  },
                ),
                const SizedBox(height: 32),

                // Login link
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      TextButton(
                        onPressed: _navigateToLogin,
                        child: const Text('Sign In'),
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
}
