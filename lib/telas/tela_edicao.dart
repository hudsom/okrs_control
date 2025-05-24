import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:okrs_control/telas/tela_confirmacao_exclusao.dart';
import '../modelos/okr.dart';
import 'package:provider/provider.dart';
import '../controleEstado/controle_estado.dart';

class TelaEdicao extends StatefulWidget {
  final OKR okr;
  const TelaEdicao({required this.okr});

  @override
  _TelaEdicaoState createState() => _TelaEdicaoState();
}

class _TelaEdicaoState extends State<TelaEdicao> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nomeController;
  late TextEditingController _descricaoController;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.okr.nome);
    _descricaoController = TextEditingController(text: widget.okr.descricao);
  }

  Future<String> _obterLocalizacao() async {
    Position posicao = await Geolocator.getCurrentPosition();
    return 'Lat: ${posicao.latitude}, Long: ${posicao.longitude}';
  }

  void _salvarEdicao() async {
    if (_formKey.currentState!.validate()) {
      String novaLocalizacao = await _obterLocalizacao();
      OKR okrAtualizado = OKR(
        nome: _nomeController.text,
        descricao: _descricaoController.text,
        dataCriacao: DateTime.now(),
        localizacao: novaLocalizacao,
      );
      context.read<ControleEstado>().atualizar(widget.okr, okrAtualizado);
      Navigator.pop(context);
    }
  }

  void _confirmarExclusao() async {
    final confirmacao = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaConfirmacaoExclusao(okr: widget.okr),
      ),
    );
    if (confirmacao == true) {
      context.read<ControleEstado>().excluir(widget.okr);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar OKR'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) => value!.isEmpty ? 'Informe o nome do OKR' : null,
              ),
              TextFormField(
                controller: _descricaoController,
                decoration: InputDecoration(labelText: 'Descrição'),
                validator: (value) => value!.isEmpty ? 'Informe a descrição' : null,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: _salvarEdicao,
                    child: Text('Salvar'),
                  ),
                  ElevatedButton(
                    onPressed: _confirmarExclusao,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: Text('Excluir'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}