import 'package:carros/pages/carros/home_page.dart';
import 'package:carros/pages/login/login_page.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/utils/sql/db_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future futureA = DatabaseHelper.getInstance().db;

    Future futureB = Future.delayed(const Duration(seconds: 3));

    Future<Usuario> futureC = Usuario.get();

    Future.wait([futureA, futureB, futureC]).then((List values) {
      Usuario? user = values[2];
      if (kDebugMode) {
        print(user);
      }

      if (user?.nome != null) {
        push(context, const HomePage(), replace: true);
      } else {
        push(context, const LoginPage(), replace: true);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[200],
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
