import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:controle_romaneio/BarraFerramentas/Bloc/barra-ferramentas-bloc.dart';
import 'package:flutter/material.dart';

class BarraFerramentas extends StatelessWidget {
  final String chaveConsulta;

  const BarraFerramentas(this.chaveConsulta);
  @override
  Widget build(BuildContext context) {
    return BlocProvider<BarraFerramentasBloc>(
      bloc: BarraFerramentasBloc(context, chaveConsulta),
      child: Container(
        width: 330,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: new Border.all(
            color: Colors.blue[900],
          ),
        ),
        child: CriaBarraFerramentas(chaveConsulta),
      ),
    );
  }
}

class CriaBarraFerramentas extends StatelessWidget {
  final String chaveConsulta;

  const CriaBarraFerramentas(this.chaveConsulta);
  @override
  Widget build(BuildContext context) {
    BarraFerramentasBloc blocBarraFerramentas =
        BlocProvider.of<BarraFerramentasBloc>(context);
    return StreamBuilder<BarraFerramentasBloc>(
        stream: null,
        builder: (context, snapshot) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        '/ListaRomaneios',
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[900],
                        borderRadius: BorderRadius.all(
                          Radius.circular(2.0),
                        ),
                      ),
                      child: Icon(
                        Icons.home,
                        size: 25.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      blocBarraFerramentas.eventoCliqueBotaoSalvar();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[900],
                        borderRadius: BorderRadius.all(
                          Radius.circular(2.0),
                        ),
                      ),
                      child: Icon(
                        Icons.save,
                        size: 25.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      blocBarraFerramentas.eventoCliqueBotaoApagarDados();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[900],
                        borderRadius: BorderRadius.all(
                          Radius.circular(2.0),
                        ),
                      ),
                      child: Icon(
                        Icons.delete,
                        size: 25.0,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }
}
