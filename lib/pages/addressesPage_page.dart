import 'package:flutter/material.dart';
import 'package:qr_reader/widgets/widgets.dart';

class AddressesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HistoryPage(type: 'http', dismissColor: Colors.red);
  }
}
