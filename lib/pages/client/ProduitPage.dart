import 'package:flutter/material.dart';

// Classe pour représenter une liste
class Liste {
  final String nom;

  final String image;
  final String prix;

  Liste({required this.nom,  required this.image, required this.prix});
}

class ProduitPage extends StatefulWidget {
  @override
  State<ProduitPage> createState() => _ProduitPageState();
}

class _ProduitPageState extends State<ProduitPage> {
  var _listes = <Liste>[]; // Liste d'articles
  var _filteredListes = <Liste>[];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchListes(); // Récupérer les articles statiques
    _searchController.addListener(_filterListe);
  }

  Future<void> _fetchListes() async {
    // Création d'une liste d'articles statiques
    final articles = [
      Liste(
        nom: "Piments",

        image: "images/panier2.jpg",
        prix: "Prix : 200 fc",
      ),
      Liste(
        nom: "Choux",

        image: "images/panier2.jpg",
        prix: "Prix : 200 fc",
      ),
      Liste(
        nom: "Mais",

        image: "images/panier2.jpg",
        prix: "Prix : 200 fc",
      ),
      Liste(
        nom: "Piments",

        image: "images/panier2.jpg",
        prix: "Prix : 200 fc",
      ),
      Liste(
        nom: "Piments",

        image: "images/panier2.jpg",
        prix: "Prix : 200 fc",
      ),
    ];

    setState(() {
      _listes = articles;
      _filteredListes = articles; // Initialisation avec tous les articles
    });
  }

  void _filterListe() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredListes = _listes.where((article) {
        return article.nom.toLowerCase().contains(query); // Filtrage par nom
      }).toList();
    });
  }

  Future<void> _refreshData() async {
    // Appeler la méthode pour récupérer les articles à nouveau
    await _fetchListes();
  }

  @override
  void dispose() {
    _searchController.dispose(); // Libération des ressources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Barre de recherche
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Rechercher par nom...",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                _filterListe(); // Filtre les articles lorsque le texte change
              },
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshData, // Méthode d'actualisation
              child: ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: _filteredListes.length,
                itemBuilder: (context, index) {
                  final article = _filteredListes[index];
                  return buildNewsCard(article.nom,  article.image, article.prix);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNewsCard(String nom,  String imageUrl, String prix) {
    return InkWell(
      onTap: () {
        // Action lors du clic sur la carte
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        color: Colors.white,
        child: Row(
          children: [
            ClipOval( // Utilisation de ClipOval pour une image circulaire
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("$imageUrl"),
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
                      nom,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),

                    SizedBox(height: 5),
                    Text(
                      prix,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}