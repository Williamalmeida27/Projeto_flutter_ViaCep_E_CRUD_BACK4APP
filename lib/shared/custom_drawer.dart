import 'package:flutter/material.dart';
import 'package:viacep/pages/lista_cep_cadastrado.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        InkWell(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: const Row(
              children: [
                Icon(Icons.abc),
                SizedBox(
                  width: 30,
                ),
                Text("Principal"),
              ],
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        InkWell(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: const Row(
              children: [
                Icon(Icons.abc),
                SizedBox(
                  width: 30,
                ),
                Text("Lista endereços"),
              ],
            ),
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => ListaCepCadastradoPage()));
          },
        ),
      ]),
    );
  }
}
