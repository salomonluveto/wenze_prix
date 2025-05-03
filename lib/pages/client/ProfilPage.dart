import 'package:flutter/material.dart';
import 'package:wenze_prix/pages/client/LoginPage.dart';
// Importer le ClientService
import 'package:shared_preferences/shared_preferences.dart';

import '../../service/client/ClientService.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final String imageUrl = 'images/panier2.jpg'; // Chemin vers l'image
  final ClientService clientService = ClientService(); // Instance du service

  String nom = '';
  String genre = '';
  String ville = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    _loadUserData(); // Charger les données utilisateur
  }

  Future<void> _loadUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nom = prefs.getString('${prefs.getString("email")}.nom') ?? 'Inconnu';
      genre = prefs.getString('${prefs.getString("email")}.sexe') ?? 'Inconnu';
      ville = prefs.getString('${prefs.getString("email")}.ville') ?? 'Inconnu';
      email = prefs.getString('${prefs.getString("email")}.email') ?? 'Inconnu';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Image de profil en cercle
              ClipOval(
                child: Image.asset(
                  imageUrl,
                  width: 220,
                  height: 220,
                  fit: BoxFit.cover,
                ),
              ),

              SizedBox(height: 20),

              // Informations supplémentaires
              buildInfoCard("Nom:", nom),
              buildInfoCard("Genre:", genre),
              buildInfoCard("Ville:", ville),
              buildInfoCard("Email:", email),

              SizedBox(height: 20),

              // Bouton de déconnexion
              ElevatedButton(
                onPressed: () async {
                  // Déconnexion de l'utilisateur
                  // Exemple d'appel dans ProfilePage
                  await clientService.deconnecterClient(email);

                  // Naviguer vers la page de connexion
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                        (Route<dynamic> route) => false, // Supprime toutes les routes précédentes
                  );
                },
                child: Text("Se déconnecter"),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoCard(String label, String value) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      color: Colors.white,
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 10),
            Text(
              value,
              style: TextStyle(fontSize: 15, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}