// ignore_for_file: unused_element, prefer_typing_uninitialized_variables

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';

class CryptoPage extends StatefulWidget {
  const CryptoPage({Key? key}) : super(key: key);

  @override
  State<CryptoPage> createState() => _CryptoPageState();
}

class _CryptoPageState extends State<CryptoPage> {
  String? encryptStats, md5Result;
  TextEditingController _textController = TextEditingController();
  TextEditingController _resultController = TextEditingController();

  final _key = encrypt.Key.fromUtf8('thisis_encryptkeythisis_encryptk');
  final _iv = encrypt.IV.fromLength(16);
  var _tempEncrypted;

  void _encrypt(String input) {
    final encrypter = encrypt.Encrypter(encrypt.AES(_key));
    final encrypted = encrypter.encrypt(input, iv: _iv);

    setState(() {
      _resultController.text = encrypted.base64.toString();
      _tempEncrypted = encrypted;

      encryptStats = 'Encrypted';
    });
  }

  void _decrypt(encrypt.Encrypted hash) {
    final encrypter = encrypt.Encrypter(encrypt.AES(_key));
    final decrypted = encrypter.decrypt(hash, iv: _iv);

    setState(() {
      _resultController.text = decrypted.toString();
      encryptStats = 'Decrypted';
    });
  }

  @override
  void initState() {
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
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _textController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Input',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.grey)),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _resultController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Result',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.grey)),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        MaterialButton(
                          onPressed: () {
                            _encrypt(_textController.text.toString());
                          },
                          color: Colors.black45,
                          child: Text(
                            "Encrypt",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Spacer(),
                        MaterialButton(
                          onPressed: () {
                            _decrypt(_tempEncrypted);
                          },
                          color: Colors.black45,
                          child: Text(
                            "Decrypt",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Spacer(),
                        MaterialButton(
                          onPressed: () {
                            setState(() {
                              _textController.text = "";
                              _resultController.text = "";
                            });
                          },
                          color: Colors.red[300],
                          child: Text(
                            "Clear",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    (encryptStats == null) ? "" : encryptStats.toString(),
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
