import 'package:carros/pages/login/login_page.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:carros/utils/nav.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DrawerList extends StatelessWidget {
  DrawerList({Key? key}) : super(key: key);
  static late Usuario user;

  UserAccountsDrawerHeader _header(user) {
    return UserAccountsDrawerHeader(
      accountName: Text(user.nome),
      accountEmail: Text(user.email),
      currentAccountPicture: CircleAvatar(
        backgroundImage: NetworkImage(user.urlFoto),
      ),
    );
  }

  final Future<Usuario> future = Usuario.get();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            FutureBuilder<Usuario>(
                future: future,
                builder: (context, snapshot) {
                  Usuario? user = snapshot.data;

                  return user != null ? _header(user) : Container();
                }),
            ListTile(
              leading: const Icon(Icons.star),
              title: const Text("Favoritos"),
              subtitle: const Text("mais informações..."),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                if (kDebugMode) {
                  print("item 1");
                  Navigator.pop(context);
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text("Ajuda"),
              subtitle: const Text("mais informações..."),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                if (kDebugMode) {
                  print("item 1");
                  Navigator.pop(context);
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text("Logout"),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () => _onClickLogout(context),
            ),
          ],
        ),
      ),
    );
  }

  _onClickLogout(BuildContext context) {
    Usuario.clear();
    Navigator.pop(context);
    push(context, const LoginPage(), replace: true);
  }
}
