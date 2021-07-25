import 'package:flutter/material.dart';
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
            onPressed: () {},
            icon: Icon(Icons.delete_forever),
          )
        ],
      ),
      body: Center(
        child: Text('Home Page'),
      ),
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
