import 'package:flutter/material.dart';
import 'package:viacep/models/viacep_back4_app_model.dart';
import 'package:viacep/repositorys/banco_dados_repository/back4_app_repository.dart';
import 'package:viacep/repositorys/viacep_repository/viacep_repository.dart';
import 'package:viacep/shared/custom_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loading = false;
  TextEditingController cepController = TextEditingController(text: "");
  var _viaCepRepository = ViaCepRepository();
  var viaCep = CepModel();
  var salvarCep = Back4AppRepository();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      drawer: const CustomDrawer(),
      floatingActionButton:
          FloatingActionButton(child: Icon(Icons.add), onPressed: () {}),
      appBar: AppBar(
        title: const Text("Via CEP"),
      ),
      body: Column(
        children: [
          const Text("CONSULTA CEP:", style: TextStyle(fontSize: 25)),
          TextField(
            keyboardType: TextInputType.number,
            controller: cepController,
            onChanged: (value) async {
              var cep = value.replaceAll(RegExp(r'[^0-9]'), '');
              if (cep.length == 8) {
                setState(() {
                  loading = true;
                });

                viaCep = await _viaCepRepository.obterCep(cep);
              }
              setState(() {
                loading = false;
              });
            },
          ),
          Center(
            child: Text(
              viaCep.logradouro!,
              style: const TextStyle(fontSize: 22),
            ),
          ),
          Text(
            "${viaCep.localidade!} - ${viaCep.uf!}",
            style: const TextStyle(fontSize: 22),
          ),
          Visibility(
              visible: loading, child: const CircularProgressIndicator()),
          TextButton(
              onPressed: () async {
                List<String> cepsCadastrados = [];
                var cepTeste = await salvarCep.obterEnderecos();
                for (var element in cepTeste.cepsCadastrados) {
                  cepsCadastrados.add(element.toString());
                  if (element.cep!.contains(viaCep.cep!)) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content:
                            Center(child: Text("O CEP JÁ ESTA CADASTRADO"))));
                    return;
                  }
                }
                salvarCep.salvar(viaCep);
                cepController.text = "";
                setState(() {});
              },
              child: const Text("Salvar dados"))
        ],
      ),
    ));
  }
}
