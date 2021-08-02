import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_reader/models/models.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qr_reader/extensions/extensions.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();
  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    final ScanModel scanModel =
        ModalRoute.of(context)?.settings.arguments as ScanModel;

    //Markers
    Set<Marker> markers = Set<Marker>();
    markers.add(Marker(
        markerId: MarkerId('geoLocation'), position: scanModel.getLatLng()));

    final CameraPosition initialPoint = CameraPosition(
      target: scanModel.getLatLng(),
      zoom: 17.5,
      tilt: 50,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
        actions: [
          IconButton(
              onPressed: () async {
                final controller = await _controller.future;

                controller.animateCamera(CameraUpdate.newCameraPosition(
                    CameraPosition(
                        target: scanModel.getLatLng(), zoom: 17.5, tilt: 50)));
              },
              icon: Icon(
                Icons.location_city_outlined,
              ))
        ],
      ),
      body: GoogleMap(
          mapType: mapType,
          initialCameraPosition: initialPoint,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: markers),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.layers),
        onPressed: () {
          setState(() {
            mapType =
                mapType == MapType.normal ? MapType.satellite : MapType.normal;
          });
        },
      ),
    );
  }
}
