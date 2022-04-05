import 'package:carros/utils/sql/entity.dart';

class Carro extends Entity {
  int? id;
  String? nome;
  String? tipo;
  String? descricao;
  String? urlFoto;
  String? urlVideo;
  String? latitude;
  String? longitude;

  Carro(
      {this.id,
      this.nome,
      this.tipo,
      this.descricao,
      this.urlFoto,
      this.urlVideo,
      this.latitude,
      this.longitude});
  Carro.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nome = map['nome'];
    tipo = map['tipo'];
    descricao = map['descricao'];
    urlFoto = map['urlFoto'];
    urlVideo = map['urlVideo'];
    latitude = map['latitude'];
    longitude = map['longitude'];
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = nome;
    data['tipo'] = tipo;
    data['descricao'] = descricao;
    data['urlFoto'] = urlFoto;
    data['urlVideo'] = urlVideo;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}
