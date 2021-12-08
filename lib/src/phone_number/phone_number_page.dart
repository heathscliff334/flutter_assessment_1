import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sms_autofill/sms_autofill.dart';

class PhoneNumberPage extends StatefulWidget {
  PhoneNumberPage({Key? key}) : super(key: key);

  @override
  _PhoneNumberPageState createState() => _PhoneNumberPageState();
}

class _PhoneNumberPageState extends State<PhoneNumberPage> {
  String? _phoneNumber;
  final SmsAutoFill _autoFill = SmsAutoFill();
  Future getNumber() async {
    if (!mounted) return;
    try {
      final autoFill = SmsAutoFill();
      final phone = await autoFill.hint;
      if (phone == null) return;
      if (!mounted) return;
      _phoneNumber = phone;
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text("Failed to get mobile number because of: ${e.message}")));
    }
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
                      getNumber();
                    },
                    color: Colors.black54,
                    child: Text(
                      "Get Number",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Text((_phoneNumber != null) ? "" : ""),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
