import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/user.dart';

class ApiService {
  final String baseUrl =
      'http://192.168.100.34:8000'; // Remplacez par l'URL de votre API

  Future<User?> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/api-token-auth/'),
      body: jsonEncode({'username': username, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      // Imprimez la réponse pour le débogage
      // ignore: avoid_print
      print('Response body: ${response.body}');
      throw Exception(
          'Failed to log in: ${response.statusCode} ${response.body}');
    }
  }

  Future<List<User>> getUsers(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/users/'),
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}
