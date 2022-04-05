import 'package:carros/pages/carros/carro.dart';
import 'package:carros/pages/carros/carro_dao.dart';
import 'package:carros/pages/carros/carros_api.dart';
import 'package:carros/pages/carros/simple_bloc.dart';
import 'package:carros/utils/network.dart';

class CarrosBloc extends SimpleBloc<List<Carro>> {
  Future fetch(String tipo) async {
    try {
      bool netWorkOn = await isNetworkOn();
      if (!netWorkOn) {
        List<Carro>? carros = await CarroDAO().findAllByTipo(tipo);
        add(carros!);
        return carros;
      }

      List<Carro> carros = await CarrosApi.getCarros(tipo);

      if (carros.isNotEmpty) {
        final dao = CarroDAO();
        carros.forEach(dao.save);
      }

      add(carros);
      return carros;
    } catch (e) {
      addError(e);
    }
  }
}
