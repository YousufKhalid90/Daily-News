// signup_provider.dart
import 'package:flutter/material.dart';

class SignupProvider with ChangeNotifier {
  String _username = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  bool _isSubmitting = false;
  String? _errorMessage;

  String get username => _username;
  String get email => _email;
  String get password => _password;
  String get confirmPassword => _confirmPassword;
  bool get isSubmitting => _isSubmitting;
  String? get errorMessage => _errorMessage;

  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void setUsername(String value) {
    _username = value;
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  void setConfirmPassword(String value) {
    _confirmPassword = value;
    notifyListeners();
  }

  Future<void> submit() async {
    if (_password != _confirmPassword) {
      _errorMessage = 'Passwords do not match';
      notifyListeners();
      return;
    }

    _isSubmitting = true;
    notifyListeners();

    try {
      // Simulate network request
      await Future.delayed(Duration(seconds: 2));

      // Handle signup logic here
      _errorMessage = null; // Clear error message on success
    } catch (error) {
      _errorMessage = 'Signup failed';
    } finally {
      _isSubmitting = false;
      notifyListeners();
    }
  }
}
