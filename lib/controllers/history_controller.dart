import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class HistoryController extends ChangeNotifier {
  static Database? _db;
  List<Map<String, dynamic>> _history = [];

  List<Map<String, dynamic>> get history => _history;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await openDatabase(
      join(await getDatabasesPath(), 'calculator_history.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE history(id INTEGER PRIMARY KEY AUTOINCREMENT, calculation TEXT, timestamp TEXT)',
        );
      },
      version: 1,
    );
    return _db!;
  }

  Future<void> addEntry(String calculation) async {
    final db = await database;
    // Teeme aja loetavaks: 2026-01-24 13:00
    final String timestamp = DateTime.now().toString().split('.')[0].substring(0, 16);
    
    await db.insert(
      'history',
      {'calculation': calculation, 'timestamp': timestamp},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    await loadHistory();
  }

  Future<void> loadHistory() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('history', orderBy: 'id DESC');
    _history = maps;
    notifyListeners();
  }

  Future<void> clearHistory() async {
    final db = await database;
    await db.delete('history');
    await loadHistory();
  }
}