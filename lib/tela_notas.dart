import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TelaNotas extends StatefulWidget {
  final String token;
  TelaNotas({required this.token});

  @override
  _TelaNotasState createState() => _TelaNotasState();
}

class _TelaNotasState extends State<TelaNotas> {
  List<dynamic> _notas = [];
  List<dynamic> _notasFiltradas = [];

  @override
  void initState() {
    super.initState();
    _recuperarNotas();
  }

  Future<void> _recuperarNotas() async {
    var url = Uri.parse('https://mockable.io/');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      setState(() {
        _notas = jsonResponse;
        _notasFiltradas = _notas;
      });
    } else {
      print('Erro ao recuperar notas');
    }
  }

  void _filtrarNotas(int tipo) {
    setState(() {
      if (tipo == 1) {
        _notasFiltradas = _notas.where((aluno) => aluno['nota'] < 60).toList();
      } else if (tipo == 2) {
        _notasFiltradas = _notas.where((aluno) => aluno['nota'] >= 60 && aluno['nota'] < 100).toList();
      } else if (tipo == 3) {
        _notasFiltradas = _notas.where((aluno) => aluno['nota'] == 100).toList();
      } else {
        _notasFiltradas = _notas;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notas dos Alunos')),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(onPressed: () => _filtrarNotas(1), child: Text('Nota < 60')),
              ElevatedButton(onPressed: () => _filtrarNotas(2), child: Text('Nota >= 60')),
              ElevatedButton(onPressed: () => _filtrarNotas(3), child: Text('Nota = 100')),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _notasFiltradas.length,
              itemBuilder: (context, index) {
                var aluno = _notasFiltradas[index];
                Color corFundo;
                if (aluno['nota'] == 100) {
                  corFundo = Colors.green;
                } else if (aluno['nota'] >= 60) {
                  corFundo = Colors.blue;
                } else {
                  corFundo = Colors.yellow;
                }

                return Container(
                  color: corFundo,
                  child: ListTile(
                    title: Text('${aluno['nome']} - Nota: ${aluno['nota']}'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
