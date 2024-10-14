import 'package:elearning_front/screens/home_screen.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';
import '../services/api_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ApiService _apiService = ApiService();

  void _login() async {
    try {
      User? user = await _apiService.login(
        _usernameController.text,
        _passwordController.text,
      );

      if (user != null) {
        if (user.id == null) {
          throw Exception('User ID is null');
        }

        // Récupérer le token
        String? token = user.token;

        // Récupérer les utilisateurs avec le token
        List<User> users = await _apiService.getUsers(token);

        // Naviguer vers l'écran d'accueil après une connexion réussie
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );

        // (Optionnel) Afficher les utilisateurs dans la console pour vérifier
        for (var u in users) {
          print('User: ${u.username}');
        }
      }
    } catch (e) {
      // Afficher la réponse du serveur pour le débogage
      print('Login failed: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
