import 'package:cached_network_image/cached_network_image.dart';
import 'package:carros/pages/carros/carro.dart';
import 'package:carros/pages/carros/loripsum_api.dart';
import 'package:carros/pages/favoritos/favorito_service.dart';
import 'package:carros/widgets/text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CarroPage extends StatefulWidget {
  final Carro carro;
  const CarroPage(this.carro, {Key? key}) : super(key: key);

  @override
  State<CarroPage> createState() => _CarroPageState();
}

class _CarroPageState extends State<CarroPage> {
  final _loripsumApiBloc = LoripsumBloc();

  Carro get carro => widget.carro;

  @override
  void initState() {
    super.initState();

    _loripsumApiBloc.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.carro.nome!),
        actions: <Widget>[
          IconButton(
            onPressed: _onClickMapa,
            icon: const Icon(
              Icons.location_on,
            ),
          ),
          IconButton(
            onPressed: _onClickVideo,
            icon: const Icon(Icons.videocam),
          ),
          PopupMenuButton<String>(
              onSelected: _onClickPopUpMenu,
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem(value: "Editar", child: Text("Editar")),
                  const PopupMenuItem(value: "Deletar", child: Text("Deletar")),
                  const PopupMenuItem(value: "Share", child: Text("Share")),
                ];
              })
        ],
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            (widget.carro.urlFoto == null
                ? CachedNetworkImage(
                    imageUrl:
                        "https://mundofixa.com/wp-content/uploads/2017/10/00-696x350.jpg",
                    width: 250,
                  )
                : CachedNetworkImage(
                    imageUrl: widget.carro.urlFoto!,
                  )),
            _bloco1(),
            const Divider(),
            _bloco2()
          ],
        ));
  }

  Row _bloco1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          fit: FlexFit.loose,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              text(
                widget.carro.nome!,
                fontSize: 16,
                bold: true,
              ),
              text(widget.carro.tipo!, fontSize: 12),
            ],
          ),
        ),
        Row(
          children: <Widget>[
            IconButton(
              onPressed: _onClickFavorito,
              icon: const Icon(Icons.favorite, color: Colors.red, size: 40),
            ),
            IconButton(
              onPressed: _onClickShare,
              icon: const Icon(Icons.share, size: 40),
            ),
          ],
        )
      ],
    );
  }

  _bloco2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        text(widget.carro.descricao!, fontSize: 14, bold: true),
        const SizedBox(height: 20),
        StreamBuilder<String?>(
          stream: _loripsumApiBloc.stream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return text(snapshot.data, fontSize: 16);
          },
        ),
      ],
    );
  }

  void _onClickMapa() {}

  void _onClickVideo() {}

  _onClickPopUpMenu(String value) {
    switch (value) {
      case "Editar":
        if (kDebugMode) {
          print("Editar !!!");
        }
        break;
      case "Deletar":
        if (kDebugMode) {
          print("Deletar !!!");
        }
        break;
      case "Share":
        if (kDebugMode) {
          print("Share !!!");
        }
        break;
    }
  }

  void _onClickFavorito() async {
    FavoritoService.favoritar(carro);
  }

  void _onClickShare() {}

  @override
  void dispose() {
    super.dispose();

    _loripsumApiBloc.dispose();
  }
}
