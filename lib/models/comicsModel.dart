class SuperHero {
  int id;
  final String name;
  final String gender;
  final String intelligence;
  final String imageUrl;
  bool isFavorite;

  SuperHero(
      {required this.id,
      required this.name,
      required this.gender,
      required this.intelligence,
      required this.imageUrl,
      this.isFavorite = false});

  factory SuperHero.fromJson(Map<String, dynamic> json) {
    return SuperHero(
        id: int.parse(json['id']),
        name: json['name'],
        gender: json['appearance']['gender'],
        intelligence: json['powerstats']['intelligence'],
        imageUrl: json['image']['url']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'gender': gender,
      'intelligence': intelligence,
      'imageUrl': imageUrl
    };
  }

  SuperHero.fromDatabaseMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        gender = map['gender'],
        intelligence = map['intelligence'],
        imageUrl = map['imageUrl'],
        isFavorite = false;

  Map<String, dynamic> toDatabaseMap() {
    return {
      'id': id,
      'name': name,
      'gender': gender,
      'intelligence': intelligence,
      'imageUrl': imageUrl
    };
  }
}
