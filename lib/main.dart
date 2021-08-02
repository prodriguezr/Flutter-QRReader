import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/pages/pages.dart';
import 'package:qr_reader/providers/providers.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final themeColor = Colors.deepPurple;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UIProvider()),
        ChangeNotifierProvider(create: (_) => new ScanListProvider())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'QR Reader',
          initialRoute: 'home',
          routes: {
            'home': (_) => HomePage(),
            'map': (_) => MapPage(),
          },
          theme: ThemeData(
              primaryColor: themeColor,
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: themeColor,
              ))),
    );
  }
}
