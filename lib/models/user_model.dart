class UserModel {
  String lat;
  String lng;
  String path;
  String name;
  String position;

  UserModel({this.lat, this.lng, this.path, this.name, this.position});

  UserModel.fromJson(Map<String, dynamic> json) {
    lat = json['Lat'];
    lng = json['lng'];
    path = json['Path'];
    name = json['name'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Lat'] = this.lat;
    data['lng'] = this.lng;
    data['Path'] = this.path;
    data['name'] = this.name;
    data['position'] = this.position;
    return data;
  }
}
