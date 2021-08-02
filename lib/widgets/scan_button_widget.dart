import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/providers.dart';
import 'package:qr_reader/extensions/extensions.dart';

class ScanButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      onPressed: () async {
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            '#3D8BEF', 'Cancel', false, ScanMode.QR);

        if (barcodeScanRes != '-1') {
          final scanListProvider =
              Provider.of<ScanListProvider>(context, listen: false);

          final newScan = await scanListProvider.addScan(barcodeScanRes);

          newScan.launchUrl(context);
        }
      },
      child: Icon(Icons.filter_center_focus),
    );
  }
}
