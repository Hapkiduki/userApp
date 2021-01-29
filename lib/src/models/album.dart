import 'photo.dart';

class Album {
  Album({
    this.id,
    this.title,
    this.photos,
  });

  String id;
  String title;
  List<Photo> photos;

  factory Album.fromJson(Map<String, dynamic> json) => Album(
        id: json['id'] == null ? null : json['id'],
        title: json['title'] == null ? null : json['title'],
        photos: json['photos']['data'] == null
            ? null
            : List<Photo>.from(
                json['photos']['data'].map((x) => Photo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'id': id == null ? null : id,
        'title': title == null ? null : title,
        'photos': photos == null
            ? null
            : List<dynamic>.from(photos.map((x) => x.toJson())),
      };
}
