
import 'dart:convert';

Produit produitFromJson(String str) => Produit.fromJson(json.decode(str));

String produitToJson(Produit data) => json.encode(data.toJson());

class Produit {
  int id;

  String nom;
  String prix;
  String quantite;


  Produit({
    required this.id,
    this.prix = "",
    this.quantite = "",
    this.nom = "",

  });

  factory Produit.fromJson(Map json) => Produit(
    id: json["id"],
    prix: json["prix"] ?? "",
    quantite: json["quantite"] ?? "",
    nom: json["nom"] ?? "",

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "prix": prix,
    "quantite": quantite,
    "nom" : nom,

  };
}