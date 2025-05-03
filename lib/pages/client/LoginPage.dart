import 'package:flutter/material.dart';
import 'package:wenze_prix/pages/admin/AccueilPageAdmin.dart';
import 'package:wenze_prix/pages/client/AccueilPage.dart';
import 'package:wenze_prix/pages/client/RegisterPage.dart';

import '../../service/client/ClientService.dart';


class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final ClientService clientService = ClientService(); // Instance du service
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                child: Image.asset(
                  "images/panier2.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 40),
              Text(
                "Connexion",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                ),
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    label: Text("Email"),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2.0,
                      ),
                    ),
                    prefixIcon: Icon(Icons.mail),
                  ),
                ),
              ),
              SizedBox(height: 7),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    label: Text("Mot de passe"),
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.visibility),
                      onPressed: () {
                        // Code pour contrôler la visibilité du mot de passe
                      },
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2.0,
                      ),
                    ),
                  ),
                  obscureText: true, // Pour masquer le mot de passe
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    _isLoading = true; // Démarrer le chargement
                  });

                  String email = _emailController.text;
                  String password = _passwordController.text;

                  // Vérifier les informations d'identification
                  bool success = await clientService.verifierClient(email, password);
                  setState(() {
                    _isLoading = false; // Arrêter le chargement
                  });

                  if(email =="salomon@gmail.com" && password == "123456"){

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => AccueilPageAdmin()),
                    );
                  }

               else   if (success) {
                    // Naviguer vers la page d'accueil
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => AccueilPage()),
                    );
                  } else {
                    // Afficher un message d'erreur
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Email ou mot de passe incorrect')),
                    );
                  }
                },
                child: _isLoading
                    ? CircularProgressIndicator()
                    : Text("Se connecter"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 95),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              // Texte pour s'inscrire sur la même ligne
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Pas de compte ? "),
                  GestureDetector(
                    onTap: () {
                      // Naviguer vers la page d'inscription
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    },
                    child: Text(
                      "Inscrivez-vous",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        decoration: TextDecoration.underline, // Souligner
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}