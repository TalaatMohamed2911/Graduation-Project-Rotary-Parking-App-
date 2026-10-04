import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:rotary_parking/constants.dart';

mixin class LocationServices {
  final locationController = Location();

  static const foeh = LatLng(29.85123, 31.3421);
  static const hewlwanUni = LatLng(29.8714, 31.3198);

  LatLng? currentPosition;
  Map<PolylineId, Polyline> polylines = {};

  Future<List<LatLng>> fetchPolylinePoints() async {
    final polylinePoints = PolylinePoints(apiKey: googleMapsApiKey);
    final result = await polylinePoints.getRouteBetweenCoordinates(
        request: PolylineRequest(
            origin: PointLatLng(foeh.latitude, foeh.longitude),
            destination: PointLatLng(hewlwanUni.latitude, hewlwanUni.longitude),
            mode: TravelMode.transit));
    if (result.points.isNotEmpty) {
      return result.points
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();
    } else {
      debugPrint(result.errorMessage);
      return [];
    }
  }
}
