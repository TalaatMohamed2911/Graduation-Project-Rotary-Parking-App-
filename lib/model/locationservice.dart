import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rotary_parking/constants.dart';

mixin class LocationServices {
  static const hewlwanUni = LatLng(29.8714, 31.3198);

  LatLng? currentPosition;

  Future<List<LatLng>?> fetchPolylinePoints() async {
    final polylinePoints = PolylinePoints(apiKey: googleMapsApiKey);

    final request = RoutesApiRequest(
        origin: PointLatLng(29.85123, 31.3421),
        destination: PointLatLng(hewlwanUni.latitude, hewlwanUni.longitude),
        travelMode: TravelMode.driving,
        routingPreference: RoutingPreference.trafficAware);

    RoutesApiResponse response =
        await polylinePoints.getRouteBetweenCoordinatesV2(request: request);

    if (response.routes.isNotEmpty) {
      List<PointLatLng> points = response.routes.first.polylinePoints ?? [];
      return points
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();
    }
    return null;
  }
}
