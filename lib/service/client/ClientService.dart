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
  }

  // Méthode pour vérifier les identifiants de l'utilisateur
  Future<bool> verifierClient(String email, String motDePasse) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? storedPassword = prefs.getString('$email.motDePasse');
    return storedPassword == motDePasse; // Vérifier le mot de passe
  }

  // Méthode pour déconnecter l'utilisateur
  Future<void> deconnecterClient(String email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove('$email.nom');
    await prefs.remove('$email.email');
    await prefs.remove('$email.motDePasse');
    await prefs.remove('$email.sexe');
    await prefs.remove('$email.ville');
  }
}