class Visita {
  final int? id;
  final String cliente;
  final String observacao;
  final String data;

  Visita({
    this.id,
    required this.cliente,
    required this.observacao,
    required this.data,
  });

  // Converter de Map (SQLite) para Objeto Visita
  factory Visita.fromMap(Map<String, dynamic> map) {
    return Visita(
      id: map['id'],
      cliente: map['cliente'],
      observacao: map['observacao'],
      data: map['data'],
    );
  }

  // Converter de Objeto Visita para Map (para salvar no SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cliente': cliente,
      'observacao': observacao,
      'data': data,
    };
  }
}
