
import 'package:flutter/material.dart';


class AjouterProduitPage extends StatefulWidget {
  @override
  State<AjouterProduitPage> createState() => _AjouterProduitPageState();
}

class _AjouterProduitPageState extends State<AjouterProduitPage> {
  final _formKey = GlobalKey<FormState>();



  // Variables pour les champs de saisie
  String nom = '';

  String prix = '';
  String qte = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40,),
              Text("Ajouter un produit", style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),),
              SizedBox(height: 40,),

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField("Nom", (value) {
                      nom = value;
                    }),

                    SizedBox(height: 16),

                    SizedBox(height: 16),
                    _buildTextField("Prix", (value) {
                      prix = value;
                    }),
                    SizedBox(height: 16),
                    _buildTextField("Quantité", (value) {
                      qte = value;
                    }),

                    SizedBox(height: 16),


                    SizedBox(height: 16),
                    _buildSubmitButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Champ de texte personnalisé
  Widget _buildTextField(String label, Function(String) onChanged) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.blue),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.blueAccent),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Veuillez entrer votre $label';
        }
        return null;
      },
      onChanged: onChanged,
    );
  }

  // Dropdown personnalisé

  // Champ de date personnalisé


  // Bouton de soumission
  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          // Traitez les données du formulaire ici
          print("Nom: $nom");


          print("peix : $prix");
          print("quantite: $qte");
        }
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
      ),
      child: Text("Ajouter", style: TextStyle(fontSize: 25)),
    );
  }
}