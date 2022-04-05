import 'package:carros/pages/carros/carro.dart';
import 'package:carros/pages/carros/carro_dao.dart';
import 'package:carros/pages/favoritos/favorito.dart';
import 'package:carros/pages/favoritos/favorito_dao.dart';

class FavoritoService {
  static favoritar(Carro c) async {
    Favorito f = Favorito.fromCarro(c);

    final dao = FavoritoDAO();
    final exists = await dao.exists(c.id!);

    if (exists) {
      await dao.delete(c.id!, "favorito");
    } else {
      await dao.save(f);
    }
  }

  static Future<List<Carro>> getCarros() async {
    List<Carro>? carros = await CarroDAO()
        .query("select * from carro c, favorito f where c.id == f.id");

    return carros!;
  }
}
