import 'package:flutter/material.dart';
import 'jogodavelha.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: JogoDaVelhaPage(),
    );
  }
}

class JogoDaVelhaPage extends StatefulWidget {
  @override
  _JogoDaVelhaPageState createState() => _JogoDaVelhaPageState();
}

class _JogoDaVelhaPageState extends State<JogoDaVelhaPage> {
  JogoDaVelha jogo = JogoDaVelha();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jogo da Velha'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Define 3 colunas
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                return Celula(
                  jogo: jogo,
                  posicao: index,
                  atualizar: _atualizarEstado,
                );
              },
            ),
            SizedBox(height: 20),
            Text(
              jogo.resultado != null ? jogo.resultado! : '',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _reiniciarJogo,
              child: Text('Reiniciar Jogo'),
            ),
          ],
        ),
      ),
    );
  }

  void _atualizarEstado() {
    setState(() {});
  }

  void _reiniciarJogo() {
    setState(() {
      jogo.reset();
    });
  }
}
