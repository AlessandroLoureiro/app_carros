import 'package:carros/pages/carros/simple_bloc.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class LoripsumBloc extends SimpleBloc<String> {
  static String? lorim;

  fetch() async {
    String? s = lorim ?? await LoripsumApi.getLoripsum();

    lorim = s;

    add(s!);
  }
}

class LoripsumApi {
  static Future<String?> getLoripsum() async {
    var url = 'https://loripsum.net/api';

    if (kDebugMode) {
      print("GET > $url");
    }

    var response = await http.get(Uri.parse(url));

    String text = response.body;

    text = text.replaceAll("<p>", "");
    text = text.replaceAll("</p>", "");

    return text;
  }
}
