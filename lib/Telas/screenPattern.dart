import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:controle_romaneio/AcessoSistema/Bloc/acesso-sistema-bloc.dart';
import 'package:controle_romaneio/Util/Widgets/alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ScreenPattern extends StatelessWidget {
  const ScreenPattern({
    this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Colors.blueGrey[800],
        title: BlocProvider<AcessoSistemaBloc>(
          child: Row(
            children: [
              Text(
                'Controle de Romaneio',
                style: TextStyle(color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: GestureDetector(
                  onTap: () {
                    final instanciaFirebaseAuth = FirebaseAuth.instance;
                    try {
                      alertConfirm(context, 'Questionamento',
                          'Deseja desconectar do sistema?', confirmCallback: () {
                        instanciaFirebaseAuth.signOut().then((value) =>
                            Navigator.of(context).pushNamed('/AcessoSistema'));
                      });
                    } catch (on) {
                      alert(context, 'Alerta', 'Erro ao desconectar do sistema!');
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[800],
                      borderRadius: BorderRadius.all(
                        Radius.circular(2.0),
                      ),
                    ),
                    child: Icon(
                      Icons.exit_to_app,
                      size: 38.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Row(
        children: <Widget>[
          child,
        ],
      ),
    );
  }
}

class BotaoSair extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Icon(Icons.exit_to_app, color: Colors.white),
    );
  }
}
