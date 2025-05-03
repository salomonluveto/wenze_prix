import 'package:shared_preferences/shared_preferences.dart';

class ClientService {
  // Méthode pour enregistrer un nouvel utilisateur
  Future<void> inscrireClient(String nom, String email, String motDePasse, String sexe, String ville) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('$email.nom', nom);
    await prefs.setString('$email.email', email);
    await prefs.setString('$email.motDePasse', motDePasse);
    await prefs.setString('$email.sexe', sexe);
    await prefs.setString('$email.ville', ville);
    await prefs.setString("email", email);

    // Impressions pour le débogage
    print("Utilisateur inscrit : $nom, $email");
  }

  // Méthode pour vérifier les identifiants de l'utilisateur
  Future<bool> verifierClient(String email, String motDePasse) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Récupérer le mot de passe enregistré avec l'email
    String? storedPassword = prefs.getString('$email.motDePasse');

    // Vérifiez si le mot de passe stocké correspond au mot de passe fourni
    if (storedPassword == motDePasse) {
      return true; // Connexion réussie
    } else {
      return false; // Connexion échouée
    }
  }
  // Méthode pour déconnecter l'utilisateur
  Future<void> deconnecterClient(String email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove('$email.nom');
    await prefs.remove('$email.email');
    await prefs.remove('$email.motDePasse');
    await prefs.remove('$email.sexe');
    await prefs.remove('$email.ville');
    await prefs.remove("email");
  }
}