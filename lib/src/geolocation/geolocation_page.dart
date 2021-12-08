// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GeolocationPage extends StatefulWidget {
  const GeolocationPage({Key? key}) : super(key: key);

  @override
  _GeolocationPageState createState() => _GeolocationPageState();
}

class _GeolocationPageState extends State<GeolocationPage> {
  bool? serviceEnabled;
  LocationPermission? permission;
  Position? position;
  double? _lat, _long;

  getLocation() async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled!) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Location services are disabled")));
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Location permissions are denied")));
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              "Location permissions are permanently denied, we cannot request permissions. Please do a manual setting.")));
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions. Please do a manual setting.');
    }
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position);
    print("Location get success");
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Location get success")));
    setState(() {
      _lat = position!.latitude;
      _long = position!.longitude;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  // ignore: prefer_const_literals_to_create_immutables
                  colors: [
                    const Color(0xFF00CCFF),
                    const Color(0xFF4E0134),
                  ],
                  begin: const FractionalOffset(0.0, 1.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: const [0.0, 1.0],
                  tileMode: TileMode.clamp,
                ),
              ),
            ),
            SafeArea(
                child: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    onPressed: () {
                      getLocation();
                    },
                    color: Colors.black54,
                    child: Text(
                      "Get Location",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Text(
                    (_lat != null) ? "Lat: $_lat, Long: $_long" : "",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
