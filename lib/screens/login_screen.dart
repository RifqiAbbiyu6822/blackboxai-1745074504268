import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/session_manager.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // For demo, accept any non-empty username/password
      Provider.of<SessionManager>(context, listen: false).login();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Username'),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Enter username' : null,
                  onSaved: (value) => _username = value ?? '',
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Enter password' : null,
                  onSaved: (value) => _password = value ?? '',
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _submit,
                  child: Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
