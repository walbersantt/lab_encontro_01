import 'package:flutter/material.dart';

import '../models/visita.dart';
import '../database/visita_dao.dart';

class VisitaViewModel extends ChangeNotifier {
  final VisitaDao _dao = VisitaDao();

  List<Visita> visitas = [];
  bool isLoading = false;

  // Carregar a lista do banco
  Future<void> carregarVisitas() async {
    isLoading = true;
    notifyListeners();

    visitas = await _dao.listar();

    isLoading = false;
    notifyListeners();
  }

  // Adicionar nova visita
  Future<void> adicionarVisita(Visita visita) async {
    await _dao.inserir(visita);
    await carregarVisitas(); // Recarrega a lista após inserir
  }

  // Deletar visita
  Future<void> deletarVisita(int id) async {
    await _dao.deletar(id);
    await carregarVisitas(); // Recarrega a lista após deletar
  }
}
