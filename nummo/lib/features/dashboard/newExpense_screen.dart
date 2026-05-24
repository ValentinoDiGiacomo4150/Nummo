import 'package:flutter/material.dart';

class NewExpenseScreen extends StatelessWidget {
  const NewExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Expense')),
      body: const Center(child: Text('New Expense')),
    );
  }
}
