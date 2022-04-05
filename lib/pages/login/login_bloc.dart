import 'dart:async';

import 'package:carros/pages/api_response.dart';
import 'package:carros/pages/carros/simple_bloc.dart';
import 'package:carros/pages/login/login_api.dart';

class LoginBloc extends BooleanBloc {
  Future<ApiResponse> login(String login, String senha) async {
    add(true);
    ApiResponse response = await LoginApi.login(login, senha);
    add(false);

    return response;
  }
}
