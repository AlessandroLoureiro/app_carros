import 'package:cached_network_image/cached_network_image.dart';
import 'package:carros/pages/carros/carro.dart';
import 'package:carros/pages/carros/carro_page.dart';
import 'package:carros/utils/nav.dart';
import 'package:flutter/material.dart';

class CarrosListView extends StatelessWidget {
  final List<Carro> carros;
  const CarrosListView(this.carros, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: carros.length,
        itemBuilder: (context, index) {
          Carro c = carros[index];

          return Card(
            color: Colors.grey[100],
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: (c.urlFoto == null
                        ? CachedNetworkImage(
                            imageUrl:
                                "https://mundofixa.com/wp-content/uploads/2017/10/00-696x350.jpg",
                            width: 250,
                          )
                        : CachedNetworkImage(
                            imageUrl: c.urlFoto!,
                            width: 250,
                          )),
                  ),
                  Text(
                    c.nome ?? "Carro indeterminado",
                    style: const TextStyle(fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Text(
                    "descrição...",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  ButtonBarTheme(
                    data: ButtonBarTheme.of(context),
                    child: ButtonBar(
                      children: <Widget>[
                        TextButton(
                          child: const Text('DETALHES'),
                          onPressed: () => onClickCarro(context, c),
                        ),
                        TextButton(
                          child: const Text('SHARE'),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  onClickCarro(context, Carro c) {
    push(context, CarroPage(c));
  }
}
