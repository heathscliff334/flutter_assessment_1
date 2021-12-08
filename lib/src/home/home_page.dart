import 'package:assessment_flutter_1/src/crypto/crypto_page.dart';
import 'package:assessment_flutter_1/src/geolocation/geolocation_page.dart';
import 'package:assessment_flutter_1/src/login/login_page.dart';
import 'package:assessment_flutter_1/src/phone_number/phone_number_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              height: double.infinity,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MaterialButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    color: Colors.black45,
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CryptoPage()));
                    },
                    color: Colors.black45,
                    child: Text(
                      "Decrypt / Encrypt",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => GeolocationPage()));
                    },
                    color: Colors.black45,
                    child: Text(
                      "Geolocation",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PhoneNumberPage()));
                    },
                    color: Colors.black45,
                    child: Text(
                      "Phone Number",
                      style: TextStyle(color: Colors.white),
                    ),
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
