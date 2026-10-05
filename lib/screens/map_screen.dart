import 'dart:async';
import 'dart:developer';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rotary_parking/model/consts.dart';
import 'package:rotary_parking/model/locationservice.dart';
import 'package:rotary_parking/model/slotsnumber.dart';
import 'package:rotary_parking/screens/reservation.dart';
import 'dart:ui' as ui;

import 'package:rotary_parking/model/custommarker.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen>
    with LocationServices, CustomMarker {
  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) async => await _determinePosition()); //initializeMap()
    onLoadData();
  }

  // Future<void> initializeMap() async {
  //   await _determinePosition();
  //   final coordinates = await fetchPolylinePoints();
  //   generatePolyLineFromPoints(coordinates);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(29.85123, 31.3421),
              zoom: 12,
            ),
            markers: Set<Marker>.of(myMarkers),
            polylines: Set<Polyline>.of(polylines.values),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            padding: EdgeInsets.only(top: 20),
            onMapCreated: (GoogleMapController controller) {
              //_googleMapController.complete(controller);
              _customInfoWindowController.googleMapController = controller;
            },
            onTap: (position) {
              _customInfoWindowController.hideInfoWindow!();
            },
            onCameraMove: (position) {
              _customInfoWindowController.onCameraMove!();
            },
          ),
          Container(
            width: 320,
            decoration: BoxDecoration(
              border: Border.all(
                  color: const ui.Color.fromARGB(255, 235, 220, 220),
                  width: 1.5),
              color: const Color.fromARGB(255, 248, 246, 246),
              borderRadius: const BorderRadius.all(Radius.circular(23)),
            ),
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            //padding: EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: "search",
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  tooltip: "Account",
                  color: Colors.blueAccent,
                  onPressed: () {
                    FirebaseAuth.instance
                        .authStateChanges()
                        .listen((User? user) {
                      if (user == null) {
                        Navigator.of(context).pushNamed("login");
                      } else {
                        Navigator.of(context).pushNamed("profile");
                      }
                    });
                  },
                  icon: const Icon(Icons.person),
                )
              ],
            ),
          ),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            height: 165,
            width: 239,
            offset: 38,
          ),
        ],
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Location services are disabled");
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> generatePolyLineFromPoints(
      List<LatLng> polylinesCoordinates) async {
    const id = PolylineId('polylone');
    final polyline = Polyline(
      polylineId: id,
      color: Colors.blueAccent,
      points: polylinesCoordinates,
      width: 6,
    );
    setState(() => polylines[id] = polyline);
  }

  Future<void> getCurrentPositionStream() async {
    Stream<Position> positionStream = Geolocator.getPositionStream(
        locationSettings: LocationSettings(
      distanceFilter: 10,
    ));
    positionStream.listen(
      (position) {
        log("Lat: ${position.latitude},Lng: ${position.longitude}");
        setState(() {
          currentPosition = LatLng(position.latitude, position.longitude);
        });
      },
    );
  }

  Future<void> onLoadData() async {
    for (int a = 0; a < positions.length; a++) {
      final Uint8List iconMaker = await getImagesFromMarkers(images[a], 94);
      myMarkers.add(
        Marker(
          markerId: MarkerId(a.toString()),
          position: positions[a],
          icon: BitmapDescriptor.bytes(iconMaker),
          onTap: () async {
            _customInfoWindowController.addInfoWindow!(
              Container(
                height: 165,
                width: 220,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 239,
                        height: 120,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/parking.jpg"),
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high,
                          ),
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(11),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          StreamBuilder(
                            stream: SlotsNumbers.getSlots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  "Free Slots: ${snapshot.data[a]["slots"]}",
                                  style: const TextStyle(
                                      fontSize: 15.5,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),
                                );
                              } else {
                                return const Text("Loading...");
                              }
                            },
                          ),
                          MaterialButton(
                            height: 28,
                            minWidth: 43,
                            color: Colors.blue,
                            textColor: Colors.white,
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const ReservationPage(),
                              ));
                            },
                            child: const Text("Book"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              positions[a],
            );
          },
        ),
      );
      setState(() {});
    }
  }
}
