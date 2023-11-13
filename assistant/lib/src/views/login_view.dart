import 'package:flutter/material.dart';

/// Displays detailed information about a RouteItem.
class LoginView extends StatelessWidget {
  const LoginView({super.key});

  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: const Center(
        child: Text('Id'),
      ),
    );
  }
}
