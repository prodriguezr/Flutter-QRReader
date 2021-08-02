import 'package:flutter/material.dart';
import 'package:qr_reader/widgets/widgets.dart';

class MapHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HistoryPage(type: 'geo', dismissColor: Colors.red);
  }
}
