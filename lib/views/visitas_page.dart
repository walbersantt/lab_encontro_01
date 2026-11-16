import 'package:flutter/material.dart';

import '../viewmodels/visita_viewmodel.dart';
import '../models/visita.dart';
import 'formulario_visita_page.dart'; // Vamos criar este arquivo no próximo passo

class VisitasPage extends StatefulWidget {
  const VisitasPage({super.key});

  @override
  State<VisitasPage> createState() => _VisitasPageState();
}

class _VisitasPageState extends State<VisitasPage> {
  final VisitaViewModel _viewModel = VisitaViewModel();

  @override
  void initState() {
    super.initState();
    _viewModel.carregarVisitas(); // Carrega as visitas ao abrir a tela
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Visitas (SQLite)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _viewModel.carregarVisitas(),
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: _viewModel,
        builder: (context, child) {
          if (_viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (_viewModel.visitas.isEmpty) {
            return const Center(child: Text('Nenhuma visita cadastrada.'));
          }

          return ListView.builder(
            itemCount: _viewModel.visitas.length,
            itemBuilder: (context, index) {
              final visita = _viewModel.visitas[index];
              return Dismissible(
                key: Key(visita.id.toString()),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (direction) {
                  _viewModel.deletarVisita(visita.id!);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${visita.cliente} excluída!')),
                  );
                },
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(visita.cliente),
                  subtitle: Text('${visita.data} - ${visita.observacao}'),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          // Navega para o formulário e espera o retorno
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FormularioVisitaPage(),
            ),
          );

          // Se o formulário retornar true (salvou), recarrega a lista
          if (result == true) {
            _viewModel.carregarVisitas();
          }
        },
      ),
    );
  }
}
