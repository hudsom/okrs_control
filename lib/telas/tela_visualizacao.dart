import 'package:flutter/material.dart';
import '../modelos/okr.dart';
import 'package:intl/intl.dart';
import 'tela_criacao.dart';
import 'tela_edicao.dart';
import 'tela_confirmacao_exclusao.dart';


class TelaVisualizacao extends StatefulWidget {
  const TelaVisualizacao({super.key});

  @override
  _TelaVisualizacaoState createState() => _TelaVisualizacaoState();
}

class _TelaVisualizacaoState extends State<TelaVisualizacao> {
  List<OKR> listaOKRs = [];

  void adicionarOKR(OKR okr) {
    setState(() {
      listaOKRs.add(okr);
      listaOKRs.sort((a, b) => a.nome.compareTo(b.nome));
    });
  }

  void atualizarOKR(OKR okrAntigo, OKR okrNovo) {
    setState(() {
      listaOKRs.remove(okrAntigo);
      listaOKRs.add(okrNovo);
      listaOKRs.sort((a, b) => a.nome.compareTo(b.nome));
    });
  }

  void excluirOKR(OKR okr) {
    setState(() {
      listaOKRs.remove(okr);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OKRs'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              final novoOKR = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TelaCriacao(),
                ),
              );
              if (novoOKR != null) adicionarOKR(novoOKR);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: listaOKRs.length,
        itemBuilder: (context, index) {
          final okr = listaOKRs[index];
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
              onPressed: () async {
                final resultado = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TelaEdicao(
                      okr: okr,
                    ),
                  ),
                );
                if (resultado is OKR) {
                  atualizarOKR(okr, resultado);
                } else if (resultado == 'excluir') {
                  final confirmacao = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TelaConfirmacaoExclusao(okr: okr),
                    ),
                  );
                  if (confirmacao == true) excluirOKR(okr);
                }
              },
            ),
          );
        },
      ),
    );
  }
}