import 'dart:async';
import 'dart:typed_data';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:rotary_parking/model/consts.dart';
import 'package:rotary_parking/model/locationservice.dart';
import 'package:rotary_parking/model/slotsnumber.dart';
import 'package:rotary_parking/screens/reservation.dart';
import 'dart:ui' as ui;

import 'package:rotary_parking/view/custommarker.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen>
    with LocationServices, CustomMarker {
  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  //final Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) async => await fetchLocationUpdates()); //initializeMap()
    onLoadData();
  }

  Future<void> initializeMap() async {
    await fetchLocationUpdates();
    final coordinates = await fetchPolylinePoints();
    generatePolyLineFromPoints(coordinates);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: //currentPosition == null
          //? const Center(child: CircularProgressIndicator()) :
          SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              padding: const EdgeInsets.only(top: 20),
              mapType: MapType.normal,
              initialCameraPosition: const CameraPosition(
                target: LocationServices.foeh,
                zoom: 12,
              ),
              markers:
                  //{
                  Set<Marker>.of(myMarkers),
              /*Marker(
                          markerId: const MarkerId("currentLocation"),
                          icon: BitmapDescriptor.defaultMarker,
                          position: currentPosition!),
                    },*/
              polylines: Set<Polyline>.of(polylines.values),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
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
                  SizedBox(
                    //padding: const EdgeInsets.only(bottom: 13.5),
                    width: 265,
                    height: 60,

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
      ),
    );
  }

  Future<void> fetchLocationUpdates() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    serviceEnabled = await locationController.serviceEnabled();
    if (serviceEnabled) {
      serviceEnabled = await locationController.requestService();
    } else {
      return;
    }
    permissionGranted = await locationController.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await locationController.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    locationController.onLocationChanged.listen((currentLocation) {
      setState(() {
        currentPosition = LatLng(
          currentLocation.latitude,
          currentLocation.longitude,
        );
      });
    });
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

  onLoadData() async {
    for (int a = 0; a < positions.length; a++) {
      final Uint8List iconMaker = await getImagesFromMarkers(images[a], 94);
      myMarkers.add(
        Marker(
          markerId: MarkerId(a.toString()),
          position: positions[a],
          //icon: BitmapDescriptor.fromBytes(iconMaker),
          icon: BitmapDescriptor.bytes(iconMaker),
          //infoWindow: ,
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
                            image: AssetImage("images/parking.jpg"),
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(11),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                return const CircularProgressIndicator();
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
//https://us1.locationiq.com/v1/directions/driving/lat1,lng1;lat2,lng2?key=Your_API_Access_Token&steps=true&alternatives=true&geometries=polyline&overview=full
