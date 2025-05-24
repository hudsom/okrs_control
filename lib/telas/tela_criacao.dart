import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../modelos/okr.dart';
import 'package:provider/provider.dart';
import '../controleEstado/controle_estado.dart';


class TelaCriacao extends StatefulWidget {

  @override
  _TelaCriacaoState createState() => _TelaCriacaoState();
}

class _TelaCriacaoState extends State<TelaCriacao> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _descricaoController = TextEditingController();

  Future<String> _obterLocalizacao() async {
    Position posicao = await Geolocator.getCurrentPosition();
    return 'Lat: ${posicao.latitude}, Long: ${posicao.longitude}';
  }

  void _salvarOKR() async {
    if (_formKey.currentState!.validate()) {
      String localizacao = await _obterLocalizacao();
      OKR novoOKR = OKR(
        nome: _nomeController.text,
        descricao: _descricaoController.text,
        dataCriacao: DateTime.now(),
        localizacao: localizacao,
      );
      context.read<ControleEstado>().adicionar(novoOKR);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar OKR'),
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
              ElevatedButton(
                onPressed: _salvarOKR,
                child: Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}