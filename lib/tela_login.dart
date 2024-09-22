import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'tela_notas.dart';

class TelaLogin extends StatefulWidget {
  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  String _token = '';

  Future<void> _fazerLogin() async {
    var url = Uri.parse('https://mockable');
    var response = await http.post(url, body: {'nome': _nomeController.text, 'senha': _senhaController.text});

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      setState(() {
        _token = jsonResponse['token'];
      });
      Navigator.push(context, MaterialPageRoute(builder: (context) => TelaNotas(token: _token)));
    } else {
      print('Erro no login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tela de Login')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _senhaController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Login'),
              onPressed: _fazerLogin,
            ),
            SizedBox(height: 20),
            Text('Token: $_token'),
          ],
        ),
      ),
    );
  }
}
