import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Register'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(icon: Icon(Icons.add_a_photo), onPressed: null),
          Container(
            width: 180,
            height: 180,
            child: Image.asset('images/avatar.png'),
          ),
          IconButton(icon: Icon(Icons.add_photo_alternate), onPressed: null),
        ],
      ),
    );
  }
}
