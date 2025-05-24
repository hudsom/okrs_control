import 'package:flutter/material.dart';
import 'package:okrs_control/telas/tela_visualizacao.dart';
import 'package:okrs_control/modelos/okr.dart';
import 'package:provider/provider.dart';
import 'package:okrs_control/controleEstado/controle_estado.dart';

void main() {
  runApp(OKRsAPP());
}

class OKRsAPP extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ControleEstado(),
      child: MaterialApp(
        title: 'Gerenciador de OKRs',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: TelaVisualizacao(),
      ),
    );
  }
}

  //definição dos modelos
class OKR {
  String nome;
  String descricao;
  DateTime dataCriacao;
  String localizacao;

  OKR({required this.nome, required this.descricao, required this.dataCriacao, required this.localizacao});
}

