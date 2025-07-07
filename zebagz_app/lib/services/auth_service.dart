import '../models/user_model.dart';

class AuthService {
  static final List<Map<String, String>> _dummyUsers = [
    {"username": "admin", "password": "1234", "role": "admin"},
    {"username": "user", "password": "1234", "role": "user"},
  ];

  static User? login(String username, String password) {
    final match = _dummyUsers.firstWhere(
      (u) => u['username'] == username && u['password'] == password,
      orElse: () => {},
    );

    if (match.isEmpty) return null;
    return User(username: match['username']!, role: match['role']!);
  }
}