import 'package:flutter/material.dart';
import '../modelos/okr.dart';
import 'package:intl/intl.dart';
import 'tela_criacao.dart';
import 'tela_edicao.dart';
import 'tela_confirmacao_exclusao.dart';
import 'package:provider/provider.dart';
import '../controleEstado/controle_estado.dart';


class TelaVisualizacao extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final okrs = context.watch<ControleEstado>().okrs;
    return Scaffold(
      appBar: AppBar(
        title: Text('OKRs'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TelaCriacao()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: okrs.length,
        itemBuilder: (context, index) {
          final okr = okrs[index];
          final dataFormatada = DateFormat('dd/MM/yyyy HH:mm').format(okr.dataCriacao);
          return ListTile(
            title: Text(
              okr.nome,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(okr.descricao),
                SizedBox(height: 4),
                Text('Data: $dataFormatada'),
                Text('Local: ${okr.localizacao}'),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TelaEdicao(okr: okr),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}