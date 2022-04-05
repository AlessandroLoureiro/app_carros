import 'dart:convert';

import 'package:carros/pages/api_response.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class LoginApi {
  static Future<ApiResponse<Usuario>> login(String login, String senha) async {
    try {
      var url =
          Uri.parse('https://carros-springboot.herokuapp.com/api/v2/login');

      Map<String, String> headers = {"Content-Type": "application/jason"};

      Map params = {
        "username": login,
        "password": senha,
      };

      String s = json.encode(params);
      if (kDebugMode) {
        print(">$s");
      }

      var response = await http.post(url, body: s, headers: headers);
      if (kDebugMode) {
        print('Response status: ${response.statusCode}');
      }
      if (kDebugMode) {
        print('Response body: ${response.body}');
      }

      Map mapResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        final user = Usuario.fromJson(mapResponse);

        user.save();

        return ApiResponse.ok(user);
      }
      return ApiResponse.error(mapResponse["error"]);
    } catch (error, exception) {
      if (kDebugMode) {
        print("Erro no login $error > $exception");
      }
      return ApiResponse.error("Não foi possível fazer o login");
    }
  }
}
