import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:controle_romaneio/AcessoSistema/Bloc/acesso-sistema-bloc.dart';
import 'package:controle_romaneio/Util/Widgets/scroll.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AcessoSistemaWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AcessoSistemaBloc>(
      bloc: AcessoSistemaBloc(context),
      child: Material(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              color: Colors.blue,
            ),
            _FormularioLogin(),
          ],
        ),
      ),
    );
  }
}

class _FormularioLogin extends StatelessWidget {
  /*
  Controllers
  */
  final tUsuario = TextEditingController();
  final tSenha = TextEditingController();

  bool escondeSenha = true;

  @override
  Widget build(BuildContext context) {
    AcessoSistemaBloc blocAcesso = BlocProvider.of<AcessoSistemaBloc>(context);
    return Scroll(
      child: Container(
        padding:
            EdgeInsets.only(top: 135.0, bottom: 60.0, left: 3.0, right: 10.0),
        child: Scroll(
          width: double.infinity,
          child: Card(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5)),
                border: new Border.all(
                  color: Colors.black,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        /*
                        Campo Usuário
                        */
                        Container(
                          width: 310,
                          height: 30,
                          child: Form(
                            child: TextFormField(
                              controller: tUsuario,
                              enabled: true,
                              decoration: InputDecoration(
                                fillColor: Colors.black,
                                icon: Icon(
                                  FontAwesomeIcons.user,
                                  color: Colors.black,
                                ),
                                enabled: true,
                              ),
                            ),
                          ),
                        ),
                        /*
                        Campo Senha
                        */
                        StreamBuilder<Object>(
                            stream: blocAcesso.outSelecionaCheckBox,
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 30.0),
                                child: Container(
                                  width: 310,
                                  height: 30,
                                  child: Form(
                                    child: TextFormField(
                                      controller: tSenha,
                                      obscureText: escondeSenha,
                                      //   enabled: true,
                                      decoration: InputDecoration(
                                        icon: Icon(
                                          FontAwesomeIcons.key,
                                          color: Colors.black,
                                        ),
                                        enabled: true,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                        /*
                        Checkbox Senha
                        */
                        Container(
                          width: 300.0,
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              StreamBuilder<Object>(
                                initialData: false,
                                stream: blocAcesso.outSelecionaCheckBox,
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Checkbox(
                                        visualDensity: VisualDensity(
                                            horizontal: 2.0, vertical: 2.0),
                                        value: snapshot.data,
                                        onChanged: (bool novoValor) {
                                          blocAcesso.eventoCliqueCheckBox(
                                              novoValor, tSenha);
                                          escondeSenha = snapshot.data;
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 10.0,
                                ),
                                child: Container(
                                  child: Text(
                                    'Exibir Senha',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        /*
                        Botão de Acesso
                        */
                        StreamBuilder<Object>(
                          stream: blocAcesso.outValidaAcesso,
                          initialData: false,
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            return AnimatedCrossFade(
                              firstChild: Padding(
                                padding: const EdgeInsets.all(30.0),
                                child: RaisedButton.icon(
                                  textColor: Colors.white,
                                  color: Colors.blueAccent[700],
                                  icon: Icon(FontAwesomeIcons.unlock),
                                  label: Text('Liberar Acesso'),
                                  onPressed: () {
                                    blocAcesso.validaAcessoUsuario(
                                        tUsuario, tSenha);
                                  },
                                ),
                              ),
                              secondChild: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: CircularProgressIndicator(),
                              ),
                              duration: Duration(milliseconds: 500),
                              crossFadeState: snapshot.data
                                  ? CrossFadeState.showSecond
                                  : CrossFadeState.showFirst,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
