import 'dart:async';

import 'package:carros/pages/api_response.dart';
import 'package:carros/pages/carros/home_page.dart';
import 'package:carros/pages/login/login_bloc.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:carros/utils/alert.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/app_button.dart';
import 'package:carros/widgets/app_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _bloc = LoginBloc();

  final _tLogin = TextEditingController();

  final _tSenha = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _focusSenha = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Carros"),
        centerTitle: true,
      ),
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            const SizedBox(
              height: 12,
            ),
            AppText("Login", "Digite o Login",
                controller: _tLogin,
                validator: _validateLogin,
                keyboardType: TextInputType.emailAddress,
                nextFocus: _focusSenha,
                textInputAction: TextInputAction.next),
            const SizedBox(
              height: 24,
            ),
            AppText(
              "Senha",
              "Digite a Senha",
              password: true,
              controller: _tSenha,
              validator: _validateSenha,
              keyboardType: TextInputType.number,
              focusNode: _focusSenha,
              nextFocus: _focusSenha,
            ),
            const SizedBox(
              height: 24,
            ),
            StreamBuilder<dynamic>(
                stream: _bloc.stream,
                initialData: false,
                builder: (context, snapshot) {
                  return AppButton(
                    "Login",
                    _onClickLogin,
                    showProgress: snapshot.data ?? false,
                  );
                }),
          ],
        ),
      ),
    );
  }

  Future<void> _onClickLogin() async {
    {
      if (!_formKey.currentState!.validate()) {
        return;
      }
    }

    String login = _tLogin.text;
    String senha = _tSenha.text;

    if (kDebugMode) {
      print("Login:$login , Senha: $senha");

      ApiResponse response = await _bloc.login(login, senha);
      if (response.ok) {
        Usuario user = response.result;
        print(">>>$user");

        push(context, const HomePage(), replace: true);
      } else {
        alert(context, response.msg);
      }
    }
  }

  String? _validateLogin(String? text) {
    if (text!.isEmpty) {
      return "Digite o Login";
    }
  }

  String? _validateSenha(String? text) {
    if (text!.isEmpty) {
      return "Digite a Senha";
    }
    if (text.length < 3) {
      return "A senha precisa ter pelo menos 3 números";
    }
  }

  @override
  void dispose() {
    super.dispose();

    _bloc.dispose();
  }
}
