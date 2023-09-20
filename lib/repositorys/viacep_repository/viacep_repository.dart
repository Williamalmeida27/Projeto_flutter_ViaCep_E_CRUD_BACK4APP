import 'package:dio/dio.dart';
import 'package:viacep/models/viacep_back4_app_model.dart';

class ViaCepRepository {
  var _dio = Dio();

  Future<CepModel> obterCep(String cep) async {
    try {
      var url = "https://viacep.com.br/ws/$cep/json/";
      var results = await _dio.get(url);
      if (results.statusCode == 200) {
        return CepModel.fromJson(results.data);
      }
    } catch (e) {
      rethrow;
    }
    return CepModel();
  }
}
