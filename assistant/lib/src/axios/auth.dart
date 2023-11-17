import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';

import '../model/user.dart';
import 'token.dart';

const baseUrl = 'http://localhost:8080/api';

Future<User> signup(String username, String email, String password) async {
  // var token = await getToken();

  final response = await http.post(
    Uri.parse('$baseUrl/user/register'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      // 'Authorization': 'Bearer $token'
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'email': email,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    var body = jsonDecode(response.body);
    var data = jsonDecode(body['data']);
    // var status = body['status'];
    // var message = body['message'];
    // var responseStringBody = response.body;

    // return response.body;
    return User.fromJson(data);
  } else {
    throw Exception('Failed to create album.');
  }
}

Future<bool> login(String email, String password) async {
  final response = await http.post(
    Uri.parse('$baseUrl/user/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    var token = response.body;
    setToken(token);
    log('Success Login');
    log('token Recieved: $token');
    return true;
  } else {
    log('Failed Login with email: $email, pwd: $password');
    throw Exception('Failed to login.');
  }
}
