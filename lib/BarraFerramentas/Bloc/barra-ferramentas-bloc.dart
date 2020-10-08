import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:controle_romaneio/Entidades/Bloc/romaneio-bloc.dart';
import 'package:flutter/material.dart';
class BarraFerramentasBloc extends BlocBase {
  final BuildContext contextoAplicacao;
  final String chaveConsulta;

  BarraFerramentasBloc(this.contextoAplicacao, this.chaveConsulta);

  Future<void> eventoCliqueBotaoSalvar() async {
    if (chaveConsulta == null) {
      RomaneioBloc blocRomaneio =
          BlocProvider.of<RomaneioBloc>(contextoAplicacao);
      await blocRomaneio.insereDados(contextoAplicacao);
    } else {
      RomaneioBloc blocRomaneio =
          BlocProvider.of<RomaneioBloc>(contextoAplicacao);
      await blocRomaneio.atualizaDados(contextoAplicacao);
    }
  }

  Future<void> eventoCliqueBotaoApagarDados() async {
    RomaneioBloc blocRomaneio =
        BlocProvider.of<RomaneioBloc>(contextoAplicacao);
    await blocRomaneio.apagarDados(contextoAplicacao);
  }

  Future<void> eventoCliqueVoltar() async {
    Navigator.of(contextoAplicacao).pushNamed(
      '/ListaRomaneios',
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
