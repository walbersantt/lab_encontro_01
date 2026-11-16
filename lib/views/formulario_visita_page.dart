import 'package:flutter/material.dart';

import '../models/visita.dart';
import '../database/visita_dao.dart';

class FormularioVisitaPage extends StatefulWidget {
  const FormularioVisitaPage({super.key});

  @override
  State<FormularioVisitaPage> createState() => _FormularioVisitaPageState();
}

class _FormularioVisitaPageState extends State<FormularioVisitaPage> {
  final _formKey = GlobalKey<FormState>();
  final _clienteController = TextEditingController();
  final _observacaoController = TextEditingController();
  final _dataController = TextEditingController();

  final VisitaDao _dao = VisitaDao();
  bool _isSaving = false;

  @override
  void dispose() {
    _clienteController.dispose();
    _observacaoController.dispose();
    _dataController.dispose();
    super.dispose();
  }

  Future<void> _salvar() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isSaving = true);

      final novaVisita = Visita(
        cliente: _clienteController.text,
        observacao: _observacaoController.text,
        data: _dataController.text,
      );

      await _dao.inserir(novaVisita);

      if (mounted) {
        Navigator.pop(context, true); // Retorna true para avisar que salvou
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nova Visita')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _clienteController,
                decoration: const InputDecoration(labelText: 'Nome do Cliente'),
                validator: (value) =>
                    value!.isEmpty ? 'Informe o cliente' : null,
              ),
              TextFormField(
                controller: _dataController,
                decoration: const InputDecoration(
                  labelText: 'Data (ex: 2026-11-16)',
                ),
                validator: (value) => value!.isEmpty ? 'Informe a data' : null,
              ),
              TextFormField(
                controller: _observacaoController,
                decoration: const InputDecoration(labelText: 'Observação'),
                validator: (value) =>
                    value!.isEmpty ? 'Informe a observação' : null,
              ),
              const SizedBox(height: 24),
              _isSaving
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _salvar,
                      child: const Text('Salvar Visita'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
