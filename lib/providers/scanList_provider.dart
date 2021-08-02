import 'package:flutter/material.dart';
import 'package:qr_reader/models/models.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> list = [];
  String selectedType = 'http';

  Future<ScanModel> addScan(String value) async {
    final newScan = ScanModel(value: value);

    final id = await DBProvider.db.insertScan(newScan);

    newScan.id = id;

    if (this.selectedType == newScan.type) {
      this.list.add(newScan);
      notifyListeners();
    }

    return newScan;
  }

  loadScans() async {
    final scans = await DBProvider.db.getAllScans();

    this.list = [...scans];

    notifyListeners();
  }

  loadScansByType(String type) async {
    final scans = await DBProvider.db.getScanByType(type);

    this.list = [...scans];
    this.selectedType = type;

    notifyListeners();
  }

  deleteAllScansByType(String type) async {
    await DBProvider.db.deleteAllScanByType(type);

    this.selectedType = type;

    loadScansByType(this.selectedType);

    notifyListeners();
  }

  deleteAllScans() async {
    await DBProvider.db.deleteAllScans();

    loadScansByType(this.selectedType);

    notifyListeners();
  }

  deleteScanById(int id) async {
    await DBProvider.db.deleteScanById(id);

    loadScansByType(this.selectedType);
  }
}
