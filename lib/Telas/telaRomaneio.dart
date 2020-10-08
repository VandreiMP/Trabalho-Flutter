import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:controle_romaneio/Entidades/Bloc/romaneio-bloc.dart';
import 'package:controle_romaneio/Util/F%C3%B3rmulas%20e%20C%C3%A1lculos/calculaTotalCarga.dart';
import 'package:controle_romaneio/Util/Widgets/appText.dart';
import 'package:controle_romaneio/Util/Widgets/appTextField.dart';
import 'package:controle_romaneio/Util/Widgets/scroll.dart';
import 'package:controle_romaneio/BarraFerramentas/Widget/barra_ferramentas.dart';
import 'package:controle_romaneio/constantes/mascaras.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import 'screenPattern.dart';

class TelaRomaneio extends StatefulWidget {
  @override
  _TelaRomaneio createState() => _TelaRomaneio();
}

class _TelaRomaneio extends State<TelaRomaneio> {
  @override
  Widget build(BuildContext context) {
    return ScreenPattern(
      child: Body(),
    );
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RomaneioBloc>(
      bloc: RomaneioBloc(context),
      child: Scroll(
        height: double.infinity,
        child: Container(
          padding: EdgeInsets.only(top: 4.0, left: 4.0),
          child: Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[900],
                      ),
                      alignment: Alignment.bottomCenter,
                      child: BarraFerramentas(
                        ModalRoute.of(context).settings.arguments,
                      ),
                    ),
                  ),
                  CriaCardFormulario(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CriaCardFormulario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tNumeroRomaneio = TextEditingController();
    final tObservacao = TextEditingController();
    final tModalidadeFrete = TextEditingController();
    final tDataSaida = MaskedTextController(mask: mascaraData);
    final tDataRetorno = MaskedTextController(mask: mascaraData);
    final tCidadeSaida = TextEditingController();
    final tUfSaida = TextEditingController();
    final tCidadeDestino = TextEditingController();
    final tUfDestino = TextEditingController();
    final tPesoBruto = TextEditingController();
    final tPesoLiquido = TextEditingController();
    final tCubagemCarga = TextEditingController();
    final tQuantidade = TextEditingController();
    final tPrecoLiquido = TextEditingController();
    final tTotalCarga = TextEditingController();

    String numeroRomaneio = ModalRoute.of(context).settings.arguments;
    RomaneioBloc blocRomaneio = BlocProvider.of<RomaneioBloc>(context);
    final Firestore firestore = Firestore.instance;
    bool campoHabilitado = true;

    if (numeroRomaneio != null) {
      campoHabilitado = false;
    }

    /*
    Aqui consulta os dados e seta o retorno da tabela nos controllers
    para exibir no formulário. Também seta no objeto através dos setters
    para atualizar os dados no banco, caso sejam alterados.
    */

    Future consultaDados(DocumentSnapshot coluna) async {
      print(numeroRomaneio);
      if (numeroRomaneio.isNotEmpty) {
        tNumeroRomaneio.text = numeroRomaneio;
      }
      tObservacao.text = coluna.data['observacao'];
      tDataSaida.text = coluna.data['dataSaidaViagem'];
      tDataRetorno.text = coluna.data['dataRetornoViagem'];
      tCidadeSaida.text = coluna.data['cidadeSaida'];
      tUfSaida.text = coluna.data['ufSaida'];
      tCidadeDestino.text = coluna.data['cidadeDestino'];
      tUfDestino.text = coluna.data['ufDestino'];
      tPesoBruto.text = coluna.data['pesoBruto'].toString();
      tPesoLiquido.text = coluna.data['pesoLiquido'].toString();
      tCubagemCarga.text = coluna.data['cubagem'].toString();
      tQuantidade.text = coluna.data['quantidade'].toString();
      tPrecoLiquido.text = coluna.data['precoLiquido'].toString();
      tTotalCarga.text = coluna.data['totalCarga'].toString();

      blocRomaneio.setNumeroRomaneio(tNumeroRomaneio.text);
      blocRomaneio.setObservacao(tObservacao.text);
      blocRomaneio.setDataSaidaViagem(tDataSaida.text);
      blocRomaneio.setDataRetornoViagem(tDataRetorno.text);
      blocRomaneio.setCidadeSaida(tCidadeSaida.text);
      blocRomaneio.setUfSaida(tUfSaida.text);
      blocRomaneio.setCidadeDestino(tCidadeDestino.text);
      blocRomaneio.setUfDestino(tUfDestino.text);
      blocRomaneio.setPesoBruto(double.tryParse(tPesoBruto.text));
      blocRomaneio.setPesoLiquido(double.tryParse(tPesoLiquido.text));
      blocRomaneio.setCubagemCarga(double.tryParse(tCubagemCarga.text));
      blocRomaneio.setQuantidade(double.tryParse(tQuantidade.text));
      blocRomaneio.setPrecoLiquido(double.tryParse(tPrecoLiquido.text));
    }

    if (numeroRomaneio != null) {
      firestore
          .collection("romaneioCarga")
          .document(numeroRomaneio)
          .get()
          .then((coluna) async => consultaDados(coluna));
    }
    return StreamBuilder<RomaneioBloc>(
        stream: null,
        builder: (context, snapshot) {
          return Scroll(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topRight,
                  child: Card(
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        border: new Border.all(
                          color: Colors.black,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: AppText(
                              'Cabeçalho',
                              bold: true,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: [
                              Container(
                                //height: 150.0,
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  border: new Border.all(
                                    color: Colors.black,
                                  ),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            constroiCampo(
                                              labelCampo: 'Código',
                                              largura: 80,
                                              enabled: campoHabilitado,
                                              altura: 30,
                                              controller: tNumeroRomaneio,
                                              onChanged: (String valor) {
                                                blocRomaneio.setNumeroRomaneio(
                                                    tNumeroRomaneio.text);
                                              },
                                              obrigaCampo: true,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            constroiCampo(
                                              labelCampo: 'Detalhes',
                                              largura: 240,
                                              keyboardType:
                                                  TextInputType.multiline,
                                              altura: 30,
                                              controller: tObservacao,
                                              onChanged: (String valor) {
                                                blocRomaneio.setObservacao(
                                                    tObservacao.text);
                                              },
                                              obrigaCampo: true,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            child: AppText(
                              'Informações da Viagem',
                              bold: true,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  border: new Border.all(
                                    color: Colors.black,
                                  ),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            constroiCampo(
                                              labelCampo: 'Data Saída',
                                              largura: 90,
                                              keyboardType:
                                                  TextInputType.datetime,
                                              altura: 30,
                                              obrigaCampo: false,
                                              controller: tDataSaida,
                                              onChanged: (String valor) {
                                                blocRomaneio.setDataSaidaViagem(
                                                    tDataSaida.text);
                                              },
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 25.0),
                                              child: constroiCampo(
                                                labelCampo: 'Data Retorno',
                                                largura: 90,
                                                altura: 30,
                                                keyboardType:
                                                    TextInputType.datetime,
                                                obrigaCampo: false,
                                                controller: tDataRetorno,
                                                onChanged: (String valor) {
                                                  blocRomaneio
                                                      .setDataRetornoViagem(
                                                          tDataRetorno.text);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            constroiCampo(
                                              labelCampo: 'Cidade/UF Saída',
                                              largura: 220,
                                              controller: tCidadeSaida,
                                              onChanged: (String valor) {
                                                blocRomaneio.setCidadeSaida(
                                                    tDataSaida.text);
                                              },
                                              altura: 30,
                                              obrigaCampo: true,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 25.0),
                                              child: constroiCampo(
                                                largura: 40,
                                                altura: 30,
                                                controller: tUfSaida,
                                                onChanged: (String valor) {
                                                  blocRomaneio.setUfSaida(
                                                      tUfSaida.text);
                                                },
                                                obrigaCampo: false,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            constroiCampo(
                                              labelCampo: 'Cidade/UF Destino',
                                              largura: 220,
                                              altura: 30,
                                              controller: tCidadeDestino,
                                              onChanged: (String valor) {
                                                blocRomaneio.setCidadeDestino(
                                                    tCidadeDestino.text);
                                              },
                                              obrigaCampo: true,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 25.0),
                                              child: constroiCampo(
                                                largura: 40,
                                                altura: 30,
                                                controller: tUfDestino,
                                                onChanged: (String valor) {
                                                  blocRomaneio.setUfDestino(
                                                      tUfDestino.text);
                                                },
                                                obrigaCampo: false,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            child: AppText(
                              'Informações da Carga',
                              bold: true,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  border: new Border.all(
                                    color: Colors.black,
                                  ),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            constroiCampo(
                                              labelCampo: 'Peso Bruto',
                                              largura: 85,
                                              altura: 30,
                                              obrigaCampo: false,
                                              keyboardType: TextInputType
                                                  .numberWithOptions(
                                                      decimal: true),
                                              controller: tPesoBruto,
                                              onChanged: (String valor) {
                                                blocRomaneio.setPesoBruto(
                                                    double.tryParse(
                                                        tPesoBruto.text));
                                              },
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 25.0),
                                              child: constroiCampo(
                                                labelCampo: 'Peso Líquido',
                                                largura: 85,
                                                altura: 30,
                                                obrigaCampo: false,
                                                keyboardType: TextInputType
                                                    .numberWithOptions(
                                                        decimal: true),
                                                controller: tPesoLiquido,
                                                onChanged: (String valor) {
                                                  blocRomaneio.setPesoLiquido(
                                                      double.tryParse(
                                                          tPesoLiquido.text));
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            constroiCampo(
                                              labelCampo: 'Cubagem',
                                              largura: 85,
                                              keyboardType: TextInputType
                                                  .numberWithOptions(
                                                      decimal: true),
                                              controller: tCubagemCarga,
                                              onChanged: (String valor) {
                                                blocRomaneio.setCubagemCarga(
                                                    double.tryParse(
                                                        tCubagemCarga.text));
                                              },
                                              altura: 30,
                                              obrigaCampo: false,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 25.0),
                                              child: constroiCampo(
                                                labelCampo: 'Quantidade',
                                                largura: 85,
                                                altura: 30,
                                                keyboardType:
                                                    TextInputType.number,
                                                controller: tQuantidade,
                                                onChanged: (String valor) {
                                                  blocRomaneio.setQuantidade(
                                                      double.tryParse(
                                                          tQuantidade.text));
                                                  tTotalCarga.text =
                                                      calculaValorTotalCarga(
                                                              double.tryParse(
                                                                  tPrecoLiquido
                                                                      .text),
                                                              double.tryParse(
                                                                  tQuantidade
                                                                      .text))
                                                          .toString();

                                                  blocRomaneio.setTotalRomaneio(
                                                      double.tryParse(
                                                          tTotalCarga.text));
                                                },
                                                obrigaCampo: false,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            constroiCampo(
                                              labelCampo: 'Preço Líq.',
                                              largura: 85,
                                              altura: 30,
                                              keyboardType: TextInputType
                                                  .numberWithOptions(
                                                      decimal: true),
                                              controller: tPrecoLiquido,
                                              onChanged: (String valor) {
                                                blocRomaneio.setPrecoLiquido(
                                                    double.tryParse(
                                                        tPrecoLiquido.text));
                                                tTotalCarga.text =
                                                    calculaValorTotalCarga(
                                                            double.tryParse(
                                                                tPrecoLiquido
                                                                    .text),
                                                            double.tryParse(
                                                                tQuantidade
                                                                    .text))
                                                        .toString();
                                                blocRomaneio.setTotalRomaneio(
                                                    double.tryParse(
                                                        tTotalCarga.text));
                                              },
                                              obrigaCampo: false,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 25.0),
                                              child: constroiCampo(
                                                labelCampo: 'Total Carga',
                                                largura: 85,
                                                altura: 30,
                                                controller: tTotalCarga,
                                                obrigaCampo: false,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

Widget constroiCampo({
  String labelCampo,
  double largura,
  double altura,
  Function onChanged,
  bool obrigaCampo,
  bool enabled,
  onFieldSubmitted,
  TextInputType keyboardType,
  TextEditingController controller,
}) {
  return Form(
    child: AppTextField(
      controller: controller,
      onFieldSubmitted: onFieldSubmitted,
      keyboardType: keyboardType,
      enabled: enabled,
      label: labelCampo,
      width: largura,
      onChanged: onChanged,
      heigth: altura,
      required: obrigaCampo,
    ),
  );
}
