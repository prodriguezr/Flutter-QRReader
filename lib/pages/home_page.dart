import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:qr_reader/pages/pages.dart';
import 'package:qr_reader/providers/providers.dart';
import 'package:qr_reader/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  // Put your code here to create your variables

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              final uiProvider =
                  Provider.of<UIProvider>(context, listen: false);

              final currentTab =
                  uiProvider.getSelectedOption == 0 ? 'geo' : 'http';

              Provider.of<ScanListProvider>(context, listen: false)
                  .deleteAllScansByType(currentTab);
            },
            icon: Icon(Icons.delete_forever),
          )
        ],
      ),
      body: _HomePageBody(),
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context);

    final currentTab = uiProvider.getSelectedOption;

    final scanListProvider = Provider.of<ScanListProvider>(context);

    switch (currentTab) {
      case 0:
        scanListProvider.loadScansByType('geo');

        return HistoryPage(
          type: 'geo',
          dismissColor: Colors.red,
        );
      case 1:
        scanListProvider.loadScansByType('http');

        return HistoryPage(
          type: 'http',
          dismissColor: Colors.red,
        );
      default:
        return MapHistoryPage();
    }
  }
}
