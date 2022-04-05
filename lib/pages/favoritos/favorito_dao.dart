import 'package:carros/pages/favoritos/favorito.dart';
import 'package:carros/utils/sql/base_dao.dart';

Map<String, dynamic> favoritos = {};

class FavoritoDAO extends BaseDAO<Favorito> {
  @override
  String get tableName => "favorito";
  @override
  Favorito fromMap(Map<String, dynamic> map) {
    map.forEach((key, value) {
      favoritos.addAll({key: value});
    });

    return Favorito.fromMap(map);
  }
}
