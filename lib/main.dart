import 'package:flutter/material.dart';
import 'package:okrs_control/telas/tela_visualizacao.dart';

void main() {
  runApp(OKRsAPP());
}

class OKRsAPP extends StatelessWidget {
  const OKRsAPP({super.key});

  @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'Controle de OKRs',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: TelaVisualizacao(),
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

