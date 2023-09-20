import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:viacep/models/viacep_back4_app_model.dart';

class Back4AppRepository {
  var _dio = Dio();

  Back4AppRepository();

  Future<void> salvar(CepModel cepModel) async {
    try {
      var url = dotenv.get("BASEURL");
      _dio.options.headers["X-Parse-Application-Id"] =
          dotenv.get("HEADERSPARSEAPLICATTION");
      _dio.options.headers["X-Parse-REST-API-Key"] =
          dotenv.get("HEADERSPARSERESTAPIKEY");
      _dio.options.headers["Content-Type"] = "application/json";
      await _dio.post("$url/ViaCep", data: cepModel.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> remover(String objectId) async {
    try {
      var url = dotenv.get("BASEURL");
      _dio.options.headers["X-Parse-Application-Id"] =
          dotenv.get("HEADERSPARSEAPLICATTION");
      _dio.options.headers["X-Parse-REST-API-Key"] =
          dotenv.get("HEADERSPARSERESTAPIKEY");
      _dio.options.headers["Content-Type"] = "application/json";

      await _dio.delete("$url/ViaCep/$objectId");
    } catch (e) {
      rethrow;
    }
  }

  Future<void> atualizar(CepModel cepModel) async {
    try {
      var url = dotenv.get("BASEURL");
      _dio.options.headers["X-Parse-Application-Id"] =
          dotenv.get("HEADERSPARSEAPLICATTION");
      _dio.options.headers["X-Parse-REST-API-Key"] =
          dotenv.get("HEADERSPARSERESTAPIKEY");
      _dio.options.headers["Content-Type"] = "application/json";

      await _dio.put("$url/ViaCep/${cepModel.objectId}",
          data: cepModel.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<CepsModel> obterEnderecos() async {
    var url = dotenv.get("BASEURL");
    _dio.options.headers["X-Parse-Application-Id"] =
        dotenv.get("HEADERSPARSEAPLICATTION");
    _dio.options.headers["X-Parse-REST-API-Key"] =
        dotenv.get("HEADERSPARSERESTAPIKEY");
    _dio.options.headers["Content-Type"] = "application/json";

    var results = await _dio.get("$url/ViaCep");
    print(results.data);
    return CepsModel.fromJson(results.data);
  }
}
