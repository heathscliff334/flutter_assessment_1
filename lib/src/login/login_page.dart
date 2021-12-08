import 'package:assessment_flutter_1/src/login/profile_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false, _secureText = true;
  final _key = GlobalKey<FormState>();
  Response? _response;
  Dio _dio = Dio();
  String? email = "", password = "";

  void _login() async {
    try {
      _response = await _dio
          .post('http://laurenscodes.space:5001/api/online_att/auth', data: {
        "email": email,
        "password": password,
      });
      setState(() {
        isLoading = false;
      });
      if (_response!.data['success']) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProfilePage(data: _response!.data['data'])));
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Login success")));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(_response!.data['message'])));
      }
    } on DioError catch (e) {
      // print(e.error);
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: ${e.error}")));
    }
  }

  check() {
    final form = _key.currentState;
    if (form!.validate()) {
      form.save();

      _login();
    } else {
      setState(() {
        isLoading = false;
      });
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
                // margin: EdgeInsets.only(top: 27),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverList(
                      delegate: SliverChildListDelegate([
                        // TUlisan Hello.
                        Row(
                          children: const <Widget>[
                            // SizedBox(width: 16),
                            Expanded(
                                child: Divider(
                              thickness: 3,
                              color: Colors.white,
                            )),
                            SizedBox(width: 5),
                            Text(
                              '.Welcome',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 45,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1.5),
                            ),
                          ],
                        ),
                        // Tulisan welcome back
                        Text(
                          'Sign in to continue!',
                          style: TextStyle(
                            color: Colors.grey[200],
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                            letterSpacing: 3,
                          ),
                        ),
                        SizedBox(height: 20),
                        Hero(
                          tag: 'hero',
                          child: CircleAvatar(
                              backgroundColor: Colors.white24,
                              radius: 60,
                              child: Image.asset("assets/images/Octocat.png")),
                        ),
                        SizedBox(height: 20),
                        Form(
                            key: _key,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Email',
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(height: 8),
                                TextFormField(
                                  validator: (e) {
                                    if (e!.isEmpty) {
                                      return "Please insert email";
                                    }
                                  },
                                  onSaved: (e) => email = e,
                                  key: Key(email!),
                                  // initialValue: "kevin@gmail.com",
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      hintText: 'Email',
                                      fillColor: Colors.white,
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      contentPadding: EdgeInsets.fromLTRB(
                                          10.0, 15.0, 10.0, 15.0),
                                      prefixIcon: Icon(Icons.email_outlined)),
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'Password',
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(height: 8),
                                StatefulBuilder(builder: (BuildContext context,
                                    StateSetter setPasswordState) {
                                  return TextFormField(
                                    validator: (e) {
                                      if (e!.isEmpty) {
                                        return "Please insert password";
                                      }
                                    },
                                    onSaved: (e) => password = e,
                                    autofocus: false,
                                    obscureText: _secureText,
                                    key: Key(password!),
                                    // initialValue: "admin",
                                    decoration: InputDecoration(
                                      hintText: 'Password',
                                      fillColor: Colors.white,
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      contentPadding: EdgeInsets.fromLTRB(
                                          10.0, 15.0, 10.0, 15.0),
                                      prefixIcon: Icon(Icons.lock_open),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setPasswordState(() {
                                            _secureText = !_secureText;
                                          });
                                        },
                                        icon: Icon(_secureText
                                            ? Icons.visibility_off
                                            : Icons.visibility),
                                      ),
                                    ),
                                  );
                                }),
                                SizedBox(height: 15),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black54,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  // padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child: (isLoading == true)
                                      ? _loadingButton()
                                      : _loginButton(context),
                                ),
                              ],
                            )),
                        SizedBox(height: 5),
                        Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Expanded(
                                child: Divider(
                              thickness: 1,
                              color: Colors.white,
                            )),
                            SizedBox(height: 20),
                            Text(
                              'OR',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(height: 20),
                            Expanded(
                                child: Divider(
                              thickness: 1,
                              color: Colors.white,
                            )),
                          ],
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          child: MaterialButton(
                            onPressed: () {},
                            child: Text('Register'),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            color: Colors.white70,
                            elevation: 0,
                            padding: EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text("email: kevin@gmail.com",
                            style: TextStyle(color: Colors.white70)),
                        Text("password: admin",
                            style: TextStyle(color: Colors.white70)),
                      ]),
                    ),
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Container(
                        // color: Colors.green,
                        alignment: Alignment.bottomCenter,
                        margin: EdgeInsets.only(bottom: 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Need a help?",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(height: 2),
                            GestureDetector(
                              onTap: () async {},
                              child: Text(
                                'Contact Us',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  MaterialButton _loginButton(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      height: 42.0,
      onPressed: () {
        setState(() {
          isLoading = true;
        });
        check();
        // check(context);
        // final form = _key.currentState;
        // if (form!.validate()) {
        //   form.save();

        //   // _login();
        //   final _requestedData = LoginRequest(
        //       email: email.toString(), password: password.toString());
        //   context.read<AuthCubit>().signInUser(_requestedData);
        // } else {
        //   setState(() {
        //     isLoading = false;
        //   });
        // }
        // final _requestedData = LoginRequest(
        //     email: email.toString(), password: password.toString());
        // context.read<AuthCubit>().signInUser(_requestedData);
      },
      child: Text('Login', style: TextStyle(color: Colors.white)),
    );
  }

  MaterialButton _loadingButton() {
    return MaterialButton(
      minWidth: double.infinity,
      height: 42.0,
      onPressed: null,

      // child: CircularProgressIndicator(),
      child:
          Container(height: 30, width: 30, child: CircularProgressIndicator()),
    );
  }
}
