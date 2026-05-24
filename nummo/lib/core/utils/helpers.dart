import 'package:flutter/material.dart';

/// Core utilities and helpers
/// TODO(Bau): Add common helpers: formatCurrency, validateEmail, etc.
class Helpers {
  /// Format amount with currency
  static String formatCurrency(double amount) {
    return '\$${amount.toStringAsFixed(2)}'; // TODO: intl
  }

  /// Validate email
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  /// Show snackbar
  static void showSnackbar(
    BuildContext context,
    String message, {
    bool isError = false,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : null,
      ),
    );
  }
}

extension ContextExtensions on BuildContext {
  // TODO: Add screen size helpers
}
