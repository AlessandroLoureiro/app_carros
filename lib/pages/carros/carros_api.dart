import 'package:carros/pages/carros/carro.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class TipoCarro {
  static const String classicos = "classicos";
  static const String esportivos = "esportivos";
  static const String luxo = "luxo";
}

class CarrosApi {
  static Future<List<Carro>> getCarros(String tipo) async {
    Usuario user = await Usuario.get();

    Map<String, String> headers = {
      "Content-Type": "application/jason",
      "Authorization": "Bearer ${user.token}"
    };

    var url = Uri.parse(
        'https://carros-springboot.herokuapp.com/api/v2/carros/tipo/$tipo');

    if (kDebugMode) {
      print("GET > $url");
    }

    var response = await http.get(url, headers: headers);

    String json = response.body;

    List list = convert.json.decode(json);

    List<Carro> carros = list.map<Carro>((map) => Carro.fromMap(map)).toList();

    return carros;
  }
}
