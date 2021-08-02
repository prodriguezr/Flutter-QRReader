import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import 'package:qr_reader/models/scan_model.dart';
export 'package:qr_reader/models/scan_model.dart';

class DBProvider {
  static Database? _database;

  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initDB();

    return _database!;
  }

  Future<Database?> initDB() async {
    // Get db path
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScansDB.db');

    print(path);

    // Create DB
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE Scans(
          id INTEGER PRIMARY KEY,
          type TEXT,
          value TEXT
        );
      ''');
    });
  }

  Future<int> newScanRaw(ScanModel scanModel) async {
    final db = await database;

    final id = scanModel.id;
    final type = scanModel.type;
    final value = scanModel.value;

    final response = db.rawInsert('''
      INSERT INTO Scans (id, type, value) 
      VALUES ($id, '$type', '$value');
    ''');

    return response;
  }

  Future<int> insertScan(ScanModel scanModel) async {
    final db = await database;

    final response = await db.insert('Scans', scanModel.toJson());

    print(response);

    return response;
  }

  Future<ScanModel?> getScanById(int id) async {
    final db = await database;

    final response = await db.query('Scans', where: 'id = ? ', whereArgs: [id]);

    return response.isNotEmpty ? ScanModel.fromJson(response.first) : null;
  }

  Future<List<ScanModel>> getAllScans() async {
    final db = await database;

    final response = await db.query('Scans');

    return response.isNotEmpty
        ? response.map((s) => ScanModel.fromJson(s)).toList()
        : [];
  }

  Future<List<ScanModel>> getScanByType(String type) async {
    final db = await database;

    final response =
        await db.query('Scans', where: 'type = ?', whereArgs: [type]);

    return response.isNotEmpty
        ? response.map((s) => ScanModel.fromJson(s)).toList()
        : [];
  }

  Future<int> updateScan(ScanModel scanModel) async {
    final db = await database;

    final response = db.update('Scans', scanModel.toJson(),
        where: 'id = ?', whereArgs: [scanModel.id]);

    return response;
  }

  Future<int> deleteScanById(int id) async {
    final db = await database;

    final response = db.delete('Scans', where: 'id = ?', whereArgs: [id]);

    return response;
  }

  Future<int> deleteAllScans() async {
    final db = await database;

    final response = db.delete('Scans');

    return response;
  }

  Future<int> deleteAllScanByType(String type) async {
    final db = await database;

    final response = db.delete('Scans', where: 'type = ?', whereArgs: [type]);

    return response;
  }
}
