import 'package:flutter/material.dart';
import 'package:wenze_prix/pages/client/AccueilPage.dart';

import '../../service/client/ClientService.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  String? _sexe;
  List<String> _sexeOptions = ['Homme', 'Femme'];

  // Variables pour les champs de saisie
  String nom = '';
  String email = '';
  String ville = '';
  String password = '';

  final ClientService clientService = ClientService(); // Instance du service

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            "Inscription",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildTextField("Nom", (value) {
                  nom = value;
                }),
                SizedBox(height: 16),
                _buildDropdown("Sexe", _sexeOptions, (value) {
                  setState(() {
                    _sexe = value;
                  });
                }),
                SizedBox(height: 16),
                _buildTextField("Email", (value) {
                  email = value;
                }),
                SizedBox(height: 16),
                _buildTextField("Ville", (value) {
                  ville = value;
                }),
                SizedBox(height: 16),
                _buildTextField("Password", (value) {
                  password = value;
                }),
                SizedBox(height: 16),
                _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

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

  Widget _buildDropdown(String label, List<String> options, Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
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
      value: _sexe,
      items: options.map((String sexe) {
        return DropdownMenuItem<String>(
          value: sexe,
          child: Text(sexe),
        );
      }).toList(),
      onChanged: onChanged,
      validator: (value) {
        if (value == null) {
          return 'Veuillez sélectionner votre sexe';
        }
        return null;
      },
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          // Traitez les données du formulaire ici
          await clientService.inscrireClient(nom, email, password, _sexe!, ville);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Inscription réussie !')),
          );

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AccueilPage()),
            );
        }
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
      ),
      child: Text("S'inscrire", style: TextStyle(fontSize: 25)),
    );
  }
}