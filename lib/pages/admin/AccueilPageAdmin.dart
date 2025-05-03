

import 'package:flutter/material.dart';
import 'package:wenze_prix/pages/admin/AjouterProduitPage.dart';
import 'package:wenze_prix/pages/admin/ProduitPage.dart';
import 'package:wenze_prix/pages/admin/ProfilPage.dart';



class AccueilPageAdmin extends StatefulWidget {
  @override
  _AccueilPageAdminState createState() => _AccueilPageAdminState();
}

class _AccueilPageAdminState extends State<AccueilPageAdmin> {
  int _selectedIndex = 0;

  // Liste des pages
  final List<Widget> _pages = [
    // Ajoutez vos pages ici
    HomeScreen(),
    ProduitScreen(),

    AjouterProduitScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:Text("Wenze", style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
          color: Colors.green
        ),),
        automaticallyImplyLeading: false, // Désactiver la flèche de retour
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
              child: CircleAvatar(
                backgroundImage: AssetImage('images/panier2.jpg'), // image profil
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Logique pour les notifications
            },
          ),
        ],
      ),
      body: _pages[_selectedIndex], // Afficher la page sélectionnée
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Produit',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Ajouter',
          ),

        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

// Exemple de pages
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Liste d'exemples des informations
  List<Map<String, String>> informations = [
    {
      "title": "Choux",
      "description": "Feuilles vertes, souvent utilisées dans les salades",
      "imageUrl": "images/choux2.png",
    },
    {
      "title": "Piments",
      "description": "Les piments sont des fruits de plante utilisés dans la cuisine",
      "imageUrl": "images/piment.jpg",
    },
    {
      "title": "Mais",
      "description": "Plante céréalière originaire d'amérique",
      "imageUrl": "images/mais2.jpg",
    },
  ];

  Future<void> _refreshData() async {
    // Simulez une opération d'actualisation
    await Future.delayed(Duration(seconds: 2));
    // Ajoutez ici la logique pour récupérer des données mises à jour si nécessaire
    setState(() {
      // Par exemple, vous pouvez ajouter un nouvel élément ou réinitialiser la liste
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: _refreshData, // Méthode d'actualisation
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            // Section de l'en-tête
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0), // Arrondi des coins
                image: DecorationImage(
                  image:AssetImage('images/panier2.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image:AssetImage('images/panier2.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Ingrédient\n100% Bio",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Liste des formations
            ...informations.map((formation) {
              return buildFormationCard(
                context,
                formation["title"]!,
                formation["description"]!,
                formation["imageUrl"]!,
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget buildFormationCard(BuildContext context, String title, String description, String imageUrl) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.white,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10), // Arrondi des coins
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    description,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProduitScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProduitPage();
  }
}


  class AjouterProduitScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  return AjouterProduitPage();
  }
}