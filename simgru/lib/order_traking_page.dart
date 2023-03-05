import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_mao/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

Location _location = Location();
const googleApiKey = 'AIzaSyAANoL7RuFvk6xdF6mj-7VmXHQfzRuZ82I';

class OrderTrackingPage extends StatefulWidget {
  const OrderTrackingPage({Key? key}) : super(key: key);

  @override
  State<OrderTrackingPage> createState() => OrderTrackingPageState();
}

class OrderTrackingPageState extends State<OrderTrackingPage> {
  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng sourceLocation = LatLng(32.651313, -115.473294);
  static const LatLng destination = LatLng(32.631051, -115.445935);

  List<LatLng> polylineCoordinates = [];
  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey,
        PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
        PointLatLng(destination.latitude, destination.longitude));

    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );

      setState(() {});
    }
  }

  // New marker position
  LatLng currentMarkerPosition = sourceLocation;

  @override
  void initState() {
    getPolyPoints();
    // Call _moveMarker function every second
    Timer.periodic(Duration(milliseconds: 1000), (_) => _moveMarker());
    super.initState();
  }

  // Move marker to the next position in polylineCoordinates
  void _moveMarker() {
    int nextIndex = polylineCoordinates.indexOf(currentMarkerPosition) + 1;
    if (nextIndex < polylineCoordinates.length) {
      currentMarkerPosition = polylineCoordinates[nextIndex];
    } else {
      polylineCoordinates = List.from(polylineCoordinates.reversed);
      currentMarkerPosition = polylineCoordinates[0];
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "GPbuS",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      body: FutureBuilder<LatLng>(
        future: _getCurrentLocation(),
        builder: (BuildContext context, AsyncSnapshot<LatLng> snapshot) {
          if (snapshot.hasData) {
            LatLng currentLocation = snapshot.data!;
            return GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: currentLocation, zoom: 14.5),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              polylines: {
                Polyline(
                  polylineId: PolylineId("route"),
                  points: polylineCoordinates,
                  color: primaryColor,
                  width: 6,
                )
              },
              markers: _getMarkers(context, currentLocation),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Set<Marker> _getMarkers(BuildContext context, LatLng currentLocation) {
    Set<Marker> markers = {};
    // ignore: prefer_const_constructors
    markers.add(Marker(
      markerId: const MarkerId('source'),
      position: sourceLocation,
      infoWindow: const InfoWindow(title: 'Source'),
    ));
    markers.add(const Marker(
      markerId: MarkerId('destination'),
      position: destination,
      infoWindow: InfoWindow(title: 'Destination'),
    ));
    markers.add(Marker(
      markerId: const MarkerId('current'),
      position: currentLocation,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      infoWindow: const InfoWindow(title: 'You are here'),
    ));
    markers.add(
      Marker(
        markerId: const MarkerId('moving'),
        position: currentMarkerPosition,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
        infoWindow: const InfoWindow(title: 'Bus route moving'),
        onTap: () {
          showBusRouteInfoSheet(context);
        },
      ),
    );
    return markers;
  }

  void showBusRouteInfoSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          child: Container(
            height: 220,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const SizedBox(height: 16),
                const Text(
                  'Ruta de Camion',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Route Name: Ruta 09 2.0',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Tiempo de llegada a destino: 17 minutos',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Numero de Unidades: 5',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Tiempo entre Unidades: 10 minutes',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _checkLocationPermission() async {
    PermissionStatus permission = await _location.requestPermission();
    if (permission == PermissionStatus.denied) {
      permission = await _location.requestPermission();
    }
    if (permission != PermissionStatus.granted) {
      // Handle the case where the user has not granted permission
    }
  }

  Future<LatLng> _getCurrentLocation() async {
    LocationData locationData = await _location.getLocation();
    return LatLng(locationData.latitude!, locationData.longitude!);
  }
}
