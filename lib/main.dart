import 'package:controle_romaneio/AcessoSistema/Widget/acesso-sistema-widget.dart';
import 'package:controle_romaneio/Telas/telaRomaneio.dart';
import 'package:controle_romaneio/listas/tabelas/tabelaRomaneio.dart';
import 'package:flutter/material.dart';

void main() async => runApp(Main());

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/AcessoSistema',
      routes: {
        /*
        Acesso e Visão Geral
        */
        '/AcessoSistema': (context) => AcessoSistemaWidget(),
        /*
        Listas de Registros
        */
        '/ListaRomaneios': (context) => ListaRomaneios(),
        /*
        Formulários Detalhados
        */
        '/FormularioRomaneio': (context) => TelaRomaneio(),
      },
    );
  }
}
