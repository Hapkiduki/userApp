class Photo {
  Photo({
    this.id,
    this.title,
    this.url,
    this.thumbnailUrl,
  });

  String id;
  String title;
  String url;
  String thumbnailUrl;

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        id: json['id'] == null ? null : json['id'],
        title: json['title'] == null ? null : json['title'],
        url: json['url'] == null ? null : json['url'],
        thumbnailUrl:
            json['thumbnailUrl'] == null ? null : json['thumbnailUrl'],
      );

  Map<String, dynamic> toJson() => {
        'id': id == null ? null : id,
        'title': title == null ? null : title,
        'url': url == null ? null : url,
        'thumbnailUrl': thumbnailUrl == null ? null : thumbnailUrl,
      };
}
