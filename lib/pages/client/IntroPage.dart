import 'package:flutter/material.dart';
import 'LoginPage.dart';

class IntroPage extends StatefulWidget {
  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    Future.delayed(Duration(seconds: 3), () {
      // Naviguer vers la LoginPage après 3 secondes
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Image en arrière-plan
          Positioned.fill(
            child: Image.asset(
              "images/panier.jpeg",
              fit: BoxFit.cover, // Ajustement de l'image
            ),
          ),
          // Contenu au premier plan
          Center( // Centrer le contenu
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Centrer verticalement
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Bienvenue à la plateforme digitale du Wenze_prix",
                  style: TextStyle(
                    color: Colors.white, // Couleur du texte
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black.withOpacity(0.7),
                        offset: Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center, // Centrer le texte
                ),
                SizedBox(height: 80), // Espace en bas
              ],
            ),
          ),
        ],
      ),
    );
  }
}