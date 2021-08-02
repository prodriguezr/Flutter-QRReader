import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Launcher {
  static void launchURL(BuildContext context,
      {required String url, required String type}) async {
    if (type == 'http')
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
    else
      Navigator.pushNamed(context, 'map');
  }
}
