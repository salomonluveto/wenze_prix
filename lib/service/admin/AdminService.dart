import 'package:shared_preferences/shared_preferences.dart';
import '../../pages/admin/ProduitPage.dart';


class AdminService {
  // Méthode pour enregistrer un produit
  Future<void> enregistrerProduit(String nom, String prix, String qte) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Utiliser le nom comme clé pour stocker le produit
    await prefs.setString('$nom.nom', nom);
    await prefs.setString('$nom.prix', prix);
    await prefs.setString('$nom.qte', qte);
  }

  // Méthode pour récupérer tous les produits
  Future<List<Liste>> recupererProduits() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Liste> produits = [];

    // Parcourir les clés pour récupérer les produits
    for (String key in prefs.getKeys()) {
      if (key.endsWith('.nom')) { // Vérifier si c'est une clé de produit
        String nom = prefs.getString(key)!;
        String prix = prefs.getString('${nom}.prix') ?? '';
        produits.add(Liste(nom: nom, image: "images/panier2.jpg", prix: prix));
      }
    }

    return produits; // Retourner la liste de produits
  }
}