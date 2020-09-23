import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tapwa/utility/normal_dialog.dart';
import 'package:tapwa/widget/my_service.dart';
import 'package:tapwa/widget/register.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  bool statusRedEye = true;
  String user = '', password = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkStatus();
  }

  Future<Null> checkStatus() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance.authStateChanges().listen((event) {
        if (event != null) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => MyService(),
              ),
              (route) => false);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.5),
            colors: [Colors.blue.shade200, Colors.blue.shade300],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildContainer(),
                buildText(),
                buildContainerUser(),
                buildContainerPassword(),
                buildLogin(),
                buildFlatButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  FlatButton buildFlatButton() {
    return FlatButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Register(),
            ));
      },
      child: Text(
        'New Register',
        style: TextStyle(color: Colors.pink),
      ),
    );
  }

  Container buildLogin() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: 250,
      child: RaisedButton(
        color: Colors.blue.shade700,
        onPressed: () async {
          await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: user, password: password)
              .then((value) => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyService(),
                  ),
                  (route) => false))
              .catchError((value) {
            String string = value.message;
            normalDialog(context, string);
          });
        },
        child: Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Container buildContainerUser() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: 250,
      color: Colors.blue.shade200,
      child: TextField(
        onChanged: (value) => user = value.trim(),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: 'User :',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Container buildContainerPassword() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: 250,
      color: Colors.blue.shade200,
      child: TextField(
        onChanged: (value) => password = value.trim(),
        obscureText: statusRedEye,
        decoration: InputDecoration(
          labelText: 'Password :',
          border: OutlineInputBorder(),
          suffixIcon: IconButton(
              icon: Icon(Icons.remove_red_eye),
              onPressed: () {
                setState(() {
                  statusRedEye = !statusRedEye;
                });
              }),
        ),
      ),
    );
  }

  Text buildText() => Text(
        'Ta PWA',
        style: GoogleFonts.prompt(
            textStyle: TextStyle(
          fontSize: 30,
          color: Colors.white,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
        )),
      );

  Container buildContainer() {
    return Container(
      width: 200,
      child: Image.asset('images/logo.png'),
    );
  }
}
