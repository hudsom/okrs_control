import 'package:flutter/material.dart';
import '../modelos/okr.dart';

class ControleEstado extends ChangeNotifier {
  final List<OKR> _okrs = [];

  List<OKR> get okrs => List.unmodifiable(_okrs);

  void adicionar(OKR okr) {
    _okrs.add(okr);
    _okrs.sort((a, b) => a.nome.compareTo(b.nome));
    notifyListeners();
  }

  void atualizar(OKR antigo, OKR novo) {
    final index = _okrs.indexOf(antigo);
    if (index != -1) {
      _okrs[index] = novo;
      _okrs.sort((a, b) => a.nome.compareTo(b.nome));
      notifyListeners();
    }
  }

  void excluir(OKR okr) {
    _okrs.remove(okr);
    notifyListeners();
  }
}