import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:qr_reader/models/models.dart';
import 'package:url_launcher/url_launcher.dart';

extension ScanModelExtensions on ScanModel {
  void launchUrl(BuildContext context) async {
    if (this.type == 'http')
      await canLaunch(this.value)
          ? await launch(this.value)
          : throw 'Could not launch $this.value';
    else
      Navigator.pushNamed(context, 'map', arguments: this);
  }

  LatLng getLatLng() {
    final latlng = this.value.substring(4).split(',');

    return LatLng(double.parse(latlng[0]), double.parse(latlng[1]));
  }
}
