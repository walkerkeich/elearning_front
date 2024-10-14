class User {
  final int? id; // Changez ici pour autoriser null
  final String username;
  final String email;
  final String token; // Assurez-vous que vous récupérez le token également

  User(
      {required this.id,
      required this.username,
      required this.email,
      required this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0, // Valeur par défaut si id est null
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      token: json['token'] ?? '',
    );
  }
}
