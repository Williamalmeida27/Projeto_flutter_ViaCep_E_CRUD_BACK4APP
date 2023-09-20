import 'package:flutter/material.dart';
import 'package:viacep/models/viacep_back4_app_model.dart';
import 'package:viacep/repositorys/banco_dados_repository/back4_app_repository.dart';

class ListaCepCadastradoPage extends StatefulWidget {
  const ListaCepCadastradoPage({super.key});

  @override
  State<ListaCepCadastradoPage> createState() => _ListaCepCadastradoPageState();
}

class _ListaCepCadastradoPageState extends State<ListaCepCadastradoPage> {
  late Back4AppRepository cepRepository;
  var listaEnderecos = CepsModel([]);
  TextEditingController cepController = TextEditingController();
  TextEditingController logradouroController = TextEditingController();
  TextEditingController bairroController = TextEditingController();
  TextEditingController cidadeController = TextEditingController();
  TextEditingController ufController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cepRepository = Back4AppRepository();
    carregarDados();
  }

  carregarDados() async {
    listaEnderecos = await cepRepository.obterEnderecos();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de endereços"),
      ),
      // ignore: unnecessary_null_comparison
      body: listaEnderecos.cepsCadastrados.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "CEP",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "Logradouro",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "Bairro",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "Cidade",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "UF",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "Atualizar",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 9,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: listaEnderecos.cepsCadastrados.length,
                      itemBuilder: (_, int index) {
                        var endereco = listaEnderecos.cepsCadastrados[index];
                        return Dismissible(
                          key: Key(endereco.cep!),
                          onDismissed:
                              (DismissDirection dismissDirection) async {
                            await cepRepository.remover(endereco.objectId!);
                            const Text("Excluido");
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext bc) {
                                          return Column(
                                            children: [
                                              ListTile(
                                                title: TextField(
                                                  controller: cepController,
                                                  onChanged: (value) {
                                                    endereco.cep = value;
                                                    setState(() {});
                                                  },
                                                ),
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      endereco.cep ?? "",
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext bc) {
                                          return Column(
                                            children: [
                                              ListTile(
                                                title: TextField(
                                                  controller:
                                                      logradouroController,
                                                  onChanged: (value) {
                                                    endereco.logradouro = value;
                                                    setState(() {});
                                                  },
                                                ),
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      endereco.logradouro ?? "",
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext bc) {
                                          return Column(
                                            children: [
                                              ListTile(
                                                title: TextField(
                                                  controller: bairroController,
                                                  onChanged: (value) {
                                                    endereco.bairro = value;
                                                    setState(() {});
                                                  },
                                                ),
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      endereco.bairro ?? "",
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext bc) {
                                          return Column(
                                            children: [
                                              ListTile(
                                                title: TextField(
                                                  controller: cidadeController,
                                                  onChanged: (value) {
                                                    endereco.localidade = value;
                                                    setState(() {});
                                                  },
                                                ),
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      endereco.localidade ?? "",
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext bc) {
                                          return Column(
                                            children: [
                                              ListTile(
                                                title: TextField(
                                                  controller: ufController,
                                                  onChanged: (value) {
                                                    endereco.uf =
                                                        value.toUpperCase();
                                                    setState(() {});
                                                  },
                                                ),
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      endereco.uf ?? "",
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: TextButton(
                                        onPressed: () async {
                                          await cepRepository
                                              .atualizar(endereco);
                                        },
                                        child: const Icon(Icons.add)),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
    );
  }
}
