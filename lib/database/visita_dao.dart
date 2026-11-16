import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/visita.dart';

class VisitaDao {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'visitas.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE visitas (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            cliente TEXT NOT NULL,
            observacao TEXT NOT NULL,
            data TEXT NOT NULL
          )
        ''');
      },
    );
  }

  // Inserir Visita
  Future<int> inserir(Visita visita) async {
    final db = await database;
    return await db.insert('visitas', visita.toMap());
  }

  // Listar Visitas
  Future<List<Visita>> listar() async {
    final db = await database;
    // A linha abaixo estava com erro de sintaxe. O tipo correto é List<Map<String, dynamic>>
    final List<Map<String, dynamic>> maps = await db.query('visitas');

    return List.generate(maps.length, (i) {
      return Visita.fromMap(maps[i]);
    });
  }

  // Deletar Visita
  Future<int> deletar(int id) async {
    final db = await database;
    return await db.delete('visitas', where: 'id = ?', whereArgs: [id]);
  }
}
