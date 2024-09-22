import 'package:flutter/material.dart';
import 'tela_login.dart';

class TelaInicial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tela Inicial')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.school, size: 100),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Ir para Login'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => TelaLogin()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
