import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key, @required this.data}) : super(key: key);
  final data;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<dynamic>? user;
  @override
  void initState() {
    user = widget.data;
    super.initState();
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
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: Text(
                  "Welcome ${user![0]['full_name']}",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
