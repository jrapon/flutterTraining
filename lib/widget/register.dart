import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:tapwa/utility/normal_dialog.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  List<String> positions = [
    'Account Manager',
    'Administrative Officer',
    'Direct Manager',
    'Project Manager',
    'Tester',
    'Programmer',
    'System Analysis'
  ];
  String choosePosition, name, user, password;
  double lat, long;
  File file;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findLatLng();
  }

  Future<Null> findLatLng() async {
    LocationData locationData = await findLocation();
    setState(() {
      lat = locationData.latitude;
      long = locationData.longitude;
      print('Lat =$lat , long=$long');
    });
  }

  Future<LocationData> findLocation() async {
    Location location = Location();
    try {
      return await location.getLocation();
    } catch (e) {
      print('e findLocation ==> ');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.cloud_upload),
            onPressed: () => uploadImage(),
          )
        ],
        backgroundColor: Colors.blue,
        title: Text('Register'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildAvatar(),
            buildName(),
            buildSizedBox(),
            buildPosition(),
            buildSizedBox(),
            buildUser(),
            buildSizedBox(),
            buildPassword(),
            buildSizedBox(),
            lat == null ? CircularProgressIndicator() : buildMap(),
            buildSizedBox(),
          ],
        ),
      ),
    );
  }

  Set<Marker> mySet() {
    return <Marker>[
      Marker(
        markerId: MarkerId('myId'),
        position: LatLng(lat, long),
        infoWindow: InfoWindow(
          title: 'คุณอยู่ที่นี่',
          snippet: 'lat=$lat,lng=$long',
        ),
      ),
    ].toSet();
  }

  Container buildMap() {
    CameraPosition cameraPosition = CameraPosition(
      target: LatLng(lat, long),
      zoom: 16,
    );

    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.width * 0.8,
      child: GoogleMap(
        initialCameraPosition: cameraPosition,
        mapType: MapType.normal,
        onMapCreated: (controller) {},
        markers: mySet(),
      ),
    );
  }

  SizedBox buildSizedBox() {
    return SizedBox(
      height: 16,
    );
  }

  Container buildPosition() => Container(
        width: 250,
        child: DropdownButton<String>(
          items: positions
              .map(
                (e) => DropdownMenuItem(
                  child: Text(e),
                  value: e,
                ),
              )
              .toList(),
          value: choosePosition,
          hint: Text('Choose Position'),
          onChanged: (value) {
            setState(() {
              choosePosition = value;
            });
          },
        ),
      );

  Container buildName() {
    return Container(
      width: 250,
      child: TextField(
        onChanged: (value) => name = value.trim(),
        decoration: InputDecoration(
          hintText: 'Display Name',
          prefixIcon: Icon(
            Icons.face,
            color: Color(0xFF40A6FF),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.blue)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.black26)),
        ),
      ),
    );
  }

  Container buildUser() {
    return Container(
      width: 250,
      child: TextField(
        onChanged: (value) => user = value.trim(),
        decoration: InputDecoration(
          hintText: 'User',
          prefixIcon: Icon(
            Icons.account_circle,
            color: Color(0xFF40A6FF),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.blue)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.black26)),
        ),
      ),
    );
  }

  Container buildPassword() {
    return Container(
      width: 250,
      child: TextField(
        onChanged: (value) => password = value.trim(),
        decoration: InputDecoration(
          hintText: 'Password',
          prefixIcon: Icon(
            Icons.lock,
            color: Color(0xFF40A6FF),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.blue)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.black26)),
        ),
      ),
    );
  }

  Future<Null> chooseAvatar(ImageSource source) async {
    try {
      var result = await ImagePicker().getImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
      );
      setState(() {
        file = File(result.path);
      });
    } catch (e) {}
  }

  Container buildAvatar() {
    return Container(
      margin: EdgeInsets.only(top: 16, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.add_a_photo),
            onPressed: () => chooseAvatar(ImageSource.camera),
          ),
          Container(
            width: 180,
            height: 180,
            child: file == null
                ? Image.asset('images/avatar.png')
                : Image.file(file),
          ),
          IconButton(
            icon: Icon(Icons.add_photo_alternate),
            onPressed: () => chooseAvatar(ImageSource.gallery),
          ),
        ],
      ),
    );
  }

  Future<Null> uploadImage() async {
    print('name= $name, user=$user, password=$password');
    if (file == null) {
      normalDialog(context, 'กรุณาเลือกรูปภาพ Profile');
    } else if (name == null ||
        name.isEmpty ||
        user == null ||
        user.isEmpty ||
        password == null ||
        password.isEmpty) {
      normalDialog(context, 'กรุณากรอกข้อมูลให้ครบทุกช่อง');
    } else if (choosePosition == null) {
      normalDialog(context, 'กรุณาเลือกตำแหน่ง');
    } else {}
  }
}
