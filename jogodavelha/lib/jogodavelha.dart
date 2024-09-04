import 'package:flutter/material.dart';

class JogoDaVelha {
  List<int> tabuleiro = List<int>.filled(9, 0);
  int vez = 1; // 1 para "X", -1 para "O"
  String? resultado;

  bool jogar(int posicao) {
    if (tabuleiro[posicao] == 0 && resultado == null) {
      tabuleiro[posicao] = vez;
      vez *= -1; // Alterna entre "X" e "O"
      return true;
    }
    return false;
  }

  int obterEstadoPosicao(int posicao) {
    return tabuleiro[posicao];
  }

  bool verificarVencedor() {
    List<List<int>> vitorias = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], // Linhas
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // Colunas
      [0, 4, 8], [2, 4, 6] // Diagonais
    ];
    for (var linha in vitorias) {
      int soma =
          tabuleiro[linha[0]] + tabuleiro[linha[1]] + tabuleiro[linha[2]];
      if (soma == 3 || soma == -3) {
        resultado = soma == 3 ? 'Vitória de X' : 'Vitória de O';
        return true;
      }
    }
    return false;
  }

  bool tabuleiroCheio() {
    return !tabuleiro.contains(0);
  }

  void reset() {
    tabuleiro = List<int>.filled(9, 0);
    vez = 1;
    resultado = null;
  }
}

class Celula extends StatefulWidget {
  final JogoDaVelha jogo;
  final int posicao;
  final Function atualizar;

  Celula({required this.jogo, required this.posicao, required this.atualizar});

  @override
  _CelulaState createState() => _CelulaState();
}

class _CelulaState extends State<Celula> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _fazerJogada,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        alignment: Alignment.center,
        child: _buildContent(),
      ),
    );
  }

  void _fazerJogada() {
    if (widget.jogo.jogar(widget.posicao)) {
      if (widget.jogo.verificarVencedor()) {
        widget.atualizar();
      } else if (widget.jogo.tabuleiroCheio()) {
        setState(() {
          widget.jogo.resultado = 'Deu Velha';
        });
      }
      widget.atualizar();
    }
  }

  Widget _buildContent() {
    int estado = widget.jogo.obterEstadoPosicao(widget.posicao);
    return Text(
      estado == 1
          ? 'X'
          : estado == -1
              ? 'O'
              : '',
      style: TextStyle(fontSize: 36),
    );
  }
}
