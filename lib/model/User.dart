
import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  int id;
  String nom;
  String email;
  String genre;
  String ville;
  String password;

  User({
    required this.id,
    this.nom = "",
    this.email = "",
    this.genre = "",
    this.ville = "",
    this.password = ''
  });

  factory User.fromJson(Map json) => User(
    id: json["id"] ?? 0,
    nom: json["nom"] ?? "",
    email: json["email"] ?? "",
    genre: json["genre"] ?? "",
    ville: json["ville"] ?? "",
    password: json["password"] ?? "",

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nom": nom,
    "email": email,
    "genre" : genre,
    "ville" : ville,
    "password" : password

  };
}