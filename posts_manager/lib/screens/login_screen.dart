import 'package:flutter/material.dart';

import '../models/session.dart';

class LoginScreen extends StatefulWidget {
  final void Function(Session) onLoggedIn;

  const LoginScreen({super.key, required this.onLoggedIn});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int _selectedUserId = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login to Posts Manager')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Select a user to simulate login.\n'
              'New posts will be created under this user.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            DropdownButtonFormField<int>(
              value: _selectedUserId,
              decoration: const InputDecoration(labelText: 'User ID'),
              items: List.generate(
                10,
                (i) => DropdownMenuItem(
                  value: i + 1,
                  child: Text('User #${i + 1}'),
                ),
              ),
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  _selectedUserId = value;
                });
              },
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  widget.onLoggedIn(
                    Session(
                      userId: _selectedUserId,
                      userName: 'User #$_selectedUserId',
                    ),
                  );
                },
                child: const Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

