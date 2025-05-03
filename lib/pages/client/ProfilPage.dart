import 'package:flutter/material.dart';
import 'package:wenze_prix/pages/client/LoginPage.dart';
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

    // Récupérer l'email enregistré
    String? storedEmail = prefs.getString("email");

    if (storedEmail != null) {
      setState(() {
        email = storedEmail;
        nom = prefs.getString("$email.nom") ?? 'Inconnu';
        genre = prefs.getString("$email.sexe") ?? 'Inconnu';
        ville = prefs.getString("$email.ville") ?? 'Inconnu';
      });
    } else {
      // Gérer le cas où l'email n'est pas trouvé
      setState(() {
        email = 'Inconnu';
        nom = 'Inconnu';
        genre = 'Inconnu';
        ville = 'Inconnu';
      });
    }
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
              ClipOval(
                child: Image.asset(
                  imageUrl,
                  width: 220,
                  height: 220,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20),
              buildInfoCard("Nom:", nom),
              buildInfoCard("Genre:", genre),
              buildInfoCard("Ville:", ville),
              buildInfoCard("Email:", email),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                        (Route<dynamic> route) => false,
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