import 'album.dart';

class User {
  User({
    this.id,
    this.name,
    this.username,
    this.email,
    this.phone,
    this.albums,
  });

  String id;
  String name;
  String username;
  String email;
  String phone;
  List<Album> albums;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] == null ? null : json['id'],
        name: json['name'] == null ? null : json['name'],
        username: json['username'] == null ? null : json['username'],
        email: json['email'] == null ? null : json['email'],
        phone: json['phone'] == null ? null : json['phone'],
        albums: json['albums'] == null
            ? null
            : List<Album>.from(json['albums'].map((x) => Album.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'id': id == null ? null : id,
        'name': name == null ? null : name,
        'username': username == null ? null : username,
        'email': email == null ? null : email,
        'phone': phone == null ? null : phone,
        'albums': albums == null
            ? null
            : List<dynamic>.from(albums.map((x) => x.toJson())),
      };
}
