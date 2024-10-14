class Profile {
  final int id;
  final String biographie;
  final String photo;
  final String typeProfile;

  Profile(
      {required this.id,
      required this.biographie,
      required this.photo,
      required this.typeProfile});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      biographie: json['Biographie'],
      photo: json['photo'],
      typeProfile: json['type_profile'],
    );
  }
}
