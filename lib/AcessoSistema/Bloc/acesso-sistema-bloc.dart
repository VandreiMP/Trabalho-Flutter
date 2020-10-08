import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:controle_romaneio/Util/Widgets/alert.dart';
import 'package:rxdart/rxdart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AcessoSistemaBloc extends BlocBase {
  var _controllerSelecionaCheckBox = BehaviorSubject<bool>(seedValue: false);
  var _controllerValidaAcesso = BehaviorSubject<bool>(seedValue: false);

  Stream<bool> get outSelecionaCheckBox => _controllerSelecionaCheckBox.stream;
  Stream<bool> get outValidaAcesso => _controllerValidaAcesso.stream;

  final BuildContext contextoAplicacao;

  AcessoSistemaBloc(this.contextoAplicacao);

  Future<void> eventoCliqueCheckBox(
      bool valor, TextEditingController senha) async {
    if (senha.text.isEmpty) {
      _controllerValidaAcesso.add(false);
      alert(contextoAplicacao, 'Alerta',
          'Para realizar esta operação é necessário preencher a senha!');
    } else {
      _controllerSelecionaCheckBox.add(!_controllerSelecionaCheckBox.value);
    }
  }

  Future<void> validaAcessoUsuario(
      TextEditingController usuario, TextEditingController senha) async {
    usuario.text;
    if (usuario.text.isEmpty || senha.text.isEmpty) {
      _controllerValidaAcesso.add(false);
      alert(contextoAplicacao, 'Alerta',
          'Para acessar o sistema é necessário preencher as credencias');
    } else {
      /*
      Autenticação do usuário feita via e-mail e senha que devem criados pelo administrador
      do sistema.
      */

      final instanciaFirebaseAuth = FirebaseAuth.instance;

      /*
      Passa "false" para o último parâmetro da classe de autenticação de modo 
      que só acesse o sistema, caso o usuário seja validado com sucesso pelo Firebase,
      onde o parâmetro será retornado com o valor "true". 
      */

      try {
        await instanciaFirebaseAuth
            .signInWithEmailAndPassword(
                email: usuario.text, password: senha.text)
            .then((value) async {
          _controllerValidaAcesso.add(!_controllerValidaAcesso.value);
          await Future.delayed(Duration(seconds: 2));
          _controllerValidaAcesso.add(!_controllerValidaAcesso.value);

          Navigator.of(contextoAplicacao).pushNamed(
            '/ListaRomaneios',
          );
        });
      } catch (on) {
        alert(contextoAplicacao, 'Alerta',
            'Erro ao efetuar o acesso ao sistema!');
      }
    }
  }

  @override
  void dispose() {
    _controllerValidaAcesso.close();
    _controllerSelecionaCheckBox.close();
  }
}
