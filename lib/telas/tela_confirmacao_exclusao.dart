import 'package:flutter/material.dart';
import '../modelos/okr.dart';

class TelaConfirmacaoExclusao extends StatelessWidget {
  final OKR okr;
  const TelaConfirmacaoExclusao({super.key, required this.okr});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Deseja realmente excluir o OKR "${okr.nome}"?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () => Navigator.pop(context, false),
                    child: Text('Não'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () => Navigator.pop(context, true),
                    child: Text('Sim'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}