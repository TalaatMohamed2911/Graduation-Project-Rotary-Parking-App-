import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class PlacesApiGoogleMapSearch extends StatefulWidget {
  const PlacesApiGoogleMapSearch({super.key});

  @override
  State<PlacesApiGoogleMapSearch> createState() =>
      _PlacesApiGoogleMapSearchState();
}

class _PlacesApiGoogleMapSearchState extends State<PlacesApiGoogleMapSearch> {
  String tokenForSession = '37456';
  var uuid = const Uuid();
  List<dynamic> listForPlaces = [];
  final TextEditingController _controller = TextEditingController();
  void makeSuggestion(String input) async {
    String googlePlacesApiKey = 'AIzaSyAzSSxYEnHx3TL963hnYFftU8zPcXW9x5s';
    String groundURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$groundURL?input=$input&key=$googlePlacesApiKey&sessiontoken=$tokenForSession';
    'https://api.locationiq.com/v1/autocomplete?key=pk.53678ae066005d080513d152d92c1c0e&q=$input&limit=5&dedupe=1';

    var responseResult = await http.get(Uri.parse(request));
    // var resultdata = responseResult.body.toString();
    // print('Resultdata ');
    // print(resultdata);
    if (responseResult.statusCode == 200) {
      setState(() {
        listForPlaces = jsonDecode(responseResult.body.toString());
      });
    } else {
      throw Exception('Showing data failed, Try again');
    }
  }

  void onModify() {
    setState(() {
      tokenForSession = uuid.v4();
    });

    makeSuggestion(_controller.text);
    listForPlaces.clear();
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      onModify();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.purple],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple, Colors.blue],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            children: [
              TextFormField(
                controller: _controller,
                decoration: const InputDecoration(labelText: "Search"),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: listForPlaces.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () async {
                        // ignore: unused_local_variable
                        // List locations = await locationFromAddress(
                        //     listForPlaces[index]['display_name']);
                        //print(locations.last.latitude);
                        //print(locations.last.longitude);
                      },
                      title: Text(listForPlaces[index]['display_name']),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
