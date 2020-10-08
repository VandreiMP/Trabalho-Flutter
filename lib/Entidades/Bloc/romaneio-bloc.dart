import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:controle_romaneio/Entidades/classes/romaneio.dart';
import 'package:controle_romaneio/Util/Widgets/alert.dart';
import 'package:controle_romaneio/Util/Widgets/alertErro.dart';
import 'package:controle_romaneio/Util/Widgets/alertFuncao.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class RomaneioBloc extends BlocBase {
  BuildContext contextoAplicacao;

  RomaneioBloc(BuildContext contextoAplicacao);

  /*
  Aqui seta os valores recebidos no formulário para os controllers.
  */

  void setNumeroRomaneio(String value) =>
      _numeroRomaneioController.sink.add(value);
  void setObservacao(String value) => _observacaoController.add(value);
  void setModalidadeFrete(String value) =>
      _modalidadeFreteControllerr.add(value);
  void setDataSaidaViagem(String value) =>
      _dataSaidaViagemController.add(value);
  void setDataRetornoViagem(String value) =>
      _dataRetornoViagemController.add(value);
  void setCidadeSaida(String value) => _cidadeSaidaController.add(value);
  void setUfSaida(String value) => _ufSaidaController.add(value);
  void setCidadeDestino(String value) => _cidadeDestinoController.add(value);
  void setUfDestino(String value) => _ufDestinoController.add(value);
  void setPesoBruto(double value) => _pesoBrutoController.sink.add(value);
  void setPesoLiquido(double value) => _pesoLiquidoController.sink.add(value);
  void setCubagemCarga(double value) => _cubagemCargaController.sink.add(value);
  void setQuantidade(double value) => _quantidadeController.sink.add(value);
  void setPrecoLiquido(double value) => _precoLiquidoController.sink.add(value);
  void setTotalRomaneio(double value) => _totalCargaController.sink.add(value);

  /*
  Aqui seta os valores dos controllers para as variáveis de saída do BLOC.
  */

  var _numeroRomaneioController = BehaviorSubject<String>();
  Stream<String> get outCarga => _numeroRomaneioController.stream;

  var _observacaoController = BehaviorSubject<String>();
  Stream<String> get outObservacao => _observacaoController.stream;

  var _modalidadeFreteControllerr = BehaviorSubject<String>();
  Stream<String> get outModalidadeFrete => _modalidadeFreteControllerr.stream;

  var _dataSaidaViagemController = BehaviorSubject<String>();
  Stream<String> get outDataSaida => _dataSaidaViagemController.stream;

  var _dataRetornoViagemController = BehaviorSubject<String>();
  Stream<String> get outDataRetorno => _dataRetornoViagemController.stream;

  var _cidadeSaidaController = BehaviorSubject<String>();
  Stream<String> get outCidadeSaida => _cidadeSaidaController.stream;

  var _ufSaidaController = BehaviorSubject<String>();
  Stream<String> get outUfSaida => _ufSaidaController.stream;

  var _cidadeDestinoController = BehaviorSubject<String>();
  Stream<String> get outCidadeDestino => _cidadeDestinoController.stream;

  var _ufDestinoController = BehaviorSubject<String>();
  Stream<String> get outUfDestino => _ufDestinoController.stream;

  var _pesoBrutoController = BehaviorSubject<double>();
  Stream<double> get outPesoBruto => _pesoBrutoController.stream;

  var _pesoLiquidoController = BehaviorSubject<double>();
  Stream<double> get outPesoLiquido => _pesoLiquidoController.stream;

  var _cubagemCargaController = BehaviorSubject<double>();
  Stream<double> get outCubagemCarga => _cubagemCargaController.stream;

  var _quantidadeController = BehaviorSubject<double>();
  Stream<double> get outQuantidade => _quantidadeController.stream;

  var _precoLiquidoController = BehaviorSubject<double>();
  Stream<double> get outPrecoLiquido => _precoLiquidoController.stream;

  var _totalCargaController = BehaviorSubject<double>();
  Stream<double> get outTotalCarga => _totalCargaController.stream;

  /*
  Método que insere os dados do formulário na tabela do Firebase.
  Primeiro busca os valores inseridos nos controllers e seta os mesmos
  no objeto, que por sua vez, vai ser inserido na tabela pelo método do Firebase "setaData"
  sempre usando a carga e o código do romaneio como PK.
  */

  Future<void> insereDados(BuildContext contextoAplicacao) async {
    var romaneioCarga = RomaneioCarga();

    romaneioCarga.numeroRomaneio = _numeroRomaneioController.value;
    romaneioCarga.observacao = _observacaoController.value;
    romaneioCarga.modalidadeFrete = _modalidadeFreteControllerr.value;
    romaneioCarga.dataSaidaViagem = _dataSaidaViagemController.value;
    romaneioCarga.dataRetornoViagem = _dataRetornoViagemController.value;
    romaneioCarga.cidadeSaida = _cidadeSaidaController.value;
    romaneioCarga.ufSaida = _ufSaidaController.value;
    romaneioCarga.cidadeDestino = _cidadeDestinoController.value;
    romaneioCarga.ufDestino = _ufDestinoController.value;
    romaneioCarga.pesoBruto = _pesoBrutoController.value;
    romaneioCarga.pesoLiquido = _pesoLiquidoController.value;
    romaneioCarga.cubagemCarga = _cubagemCargaController.value;
    romaneioCarga.quantidade = _quantidadeController.value;
    romaneioCarga.precoLiquido = _precoLiquidoController.value;
    romaneioCarga.totalCarga = _totalCargaController.value;

    if (romaneioCarga.numeroRomaneio == '' ||
        romaneioCarga.numeroRomaneio == null) {
      alert(contextoAplicacao, 'Alerta',
          'Para salvar é necessário informar o código!');
    } else if (romaneioCarga.observacao == '' ||
        romaneioCarga.observacao == null) {
      alert(contextoAplicacao, 'Alerta',
          'Para salvar é necessário informar os detalhes!');
    } else if (romaneioCarga.cidadeSaida == '' ||
        romaneioCarga.cidadeSaida == null) {
      alert(contextoAplicacao, 'Alerta',
          'Para salvar é necessário informar a cidade de saída!');
    } else if (romaneioCarga.ufSaida == '' || romaneioCarga.ufSaida == null) {
      alert(contextoAplicacao, 'Alerta',
          'Para salvar é necessário informar a UF de saída!');
    } else if (romaneioCarga.cidadeDestino == '' ||
        romaneioCarga.cidadeDestino == null) {
      alert(contextoAplicacao, 'Alerta',
          'Para salvar é necessário informar a cidade de destino!');
    } else if (romaneioCarga.ufDestino == '' ||
        romaneioCarga.ufDestino == null) {
      alert(contextoAplicacao, 'Alerta',
          'Para salvar é necessário informar a UF de destino!');
    } else {
      try {
        await Firestore.instance
            .collection('romaneioCarga')
            .document(romaneioCarga.numeroRomaneio)
            .setData({
          'carga': romaneioCarga.numeroRomaneio,
          'observacao': romaneioCarga.observacao,
          'modalidadeFrete': romaneioCarga.modalidadeFrete,
          'dataSaidaViagem': romaneioCarga.dataSaidaViagem,
          'dataRetornoViagem': romaneioCarga.dataRetornoViagem,
          'cidadeSaida': romaneioCarga.cidadeSaida,
          'ufSaida': romaneioCarga.ufSaida,
          'cidadeDestino': romaneioCarga.cidadeDestino,
          'ufDestino': romaneioCarga.ufDestino,
          'pesoBruto': romaneioCarga.pesoBruto,
          'pesoLiquido': romaneioCarga.pesoLiquido,
          'cubagemCarga': romaneioCarga.cubagemCarga,
          'quantidade': romaneioCarga.quantidade,
          'precoLiquido': romaneioCarga.precoLiquido,
          'totalCarga': romaneioCarga.totalCarga
        }).then((value) async => await alert(
                contextoAplicacao, 'Sucesso', 'Formulário salvo com sucesso!'));
      } catch (on) {
        TextError('Erro ao salvar formulário!');
      }
    }
  }

  /*
  Método que apaga os dados do formulário na tabela do Firebase.
  Primeiro busca a identificação informada no formulário através dos controllers,
  para depois excluir o registro na tabela do Firebase filtrando pela
  identificação, que é a PK desta tabela.
  */

  Future<void> apagarDados(BuildContext contextoAplicacao) async {
    var romaneioCarga = RomaneioCarga();

    romaneioCarga.numeroRomaneio = _numeroRomaneioController.value;

    try {
      await Firestore.instance
          .collection('romaneioCarga')
          .document(romaneioCarga.numeroRomaneio)
          .delete()
          .then(alertFuncao(contextoAplicacao, 'Notificação',
              'Formulário apagado com sucesso!', () {
            Navigator.of(contextoAplicacao).pushNamed(
              '/FormularioRomaneio',
            );
          }))
          .catchError((ErrorAndStacktrace erro) {
        print(erro.error);
      });
    } catch (on) {
      TextError('Erro ao salvar formulário!');
    }
  }

  Future<void> atualizaDados(BuildContext contextoAplicacao) async {
    var romaneioCarga = RomaneioCarga();

    romaneioCarga.numeroRomaneio = _numeroRomaneioController.value;
    romaneioCarga.observacao = _observacaoController.value;
    romaneioCarga.modalidadeFrete = _modalidadeFreteControllerr.value;
    romaneioCarga.dataSaidaViagem = _dataSaidaViagemController.value;
    romaneioCarga.dataRetornoViagem = _dataRetornoViagemController.value;
    romaneioCarga.cidadeSaida = _cidadeSaidaController.value;
    romaneioCarga.ufSaida = _ufSaidaController.value;
    romaneioCarga.cidadeDestino = _cidadeDestinoController.value;
    romaneioCarga.ufDestino = _ufDestinoController.value;
    romaneioCarga.pesoBruto = _pesoBrutoController.value;
    romaneioCarga.pesoLiquido = _pesoLiquidoController.value;
    romaneioCarga.cubagemCarga = _cubagemCargaController.value;
    romaneioCarga.quantidade = _quantidadeController.value;
    romaneioCarga.precoLiquido = _precoLiquidoController.value;
    romaneioCarga.totalCarga = _totalCargaController.value;

    if (romaneioCarga.numeroRomaneio == '' ||
        romaneioCarga.numeroRomaneio == null) {
      alert(contextoAplicacao, 'Alerta',
          'Para salvar é necessário informar o código!');
    } else if (romaneioCarga.observacao == '' ||
        romaneioCarga.observacao == null) {
      alert(contextoAplicacao, 'Alerta',
          'Para salvar é necessário informar os detalhes!');
    } else if (romaneioCarga.cidadeSaida == '' ||
        romaneioCarga.cidadeSaida == null) {
      alert(contextoAplicacao, 'Alerta',
          'Para salvar é necessário informar a cidade de saída!');
    } else if (romaneioCarga.ufSaida == '' || romaneioCarga.ufSaida == null) {
      alert(contextoAplicacao, 'Alerta',
          'Para salvar é necessário informar a UF de saída!');
    } else if (romaneioCarga.cidadeDestino == '' ||
        romaneioCarga.cidadeDestino == null) {
      alert(contextoAplicacao, 'Alerta',
          'Para salvar é necessário informar a cidade de destino!');
    } else if (romaneioCarga.ufDestino == '' ||
        romaneioCarga.ufDestino == null) {
      alert(contextoAplicacao, 'Alerta',
          'Para salvar é necessário informar a UF de destino!');
    } else {
      try {
        await Firestore.instance
            .collection('romaneioCarga')
            .document(romaneioCarga.numeroRomaneio)
            .updateData({
          'carga': romaneioCarga.numeroRomaneio,
          'observacao': romaneioCarga.observacao,
          'modalidadeFrete': romaneioCarga.modalidadeFrete,
          'dataSaidaViagem': romaneioCarga.dataSaidaViagem,
          'dataRetornoViagem': romaneioCarga.dataRetornoViagem,
          'cidadeSaida': romaneioCarga.cidadeSaida,
          'ufSaida': romaneioCarga.ufSaida,
          'cidadeDestino': romaneioCarga.cidadeDestino,
          'ufDestino': romaneioCarga.ufDestino,
          'pesoBruto': romaneioCarga.pesoBruto,
          'pesoLiquido': romaneioCarga.pesoLiquido,
          'cubagemCarga': romaneioCarga.cubagemCarga,
          'quantidade': romaneioCarga.quantidade,
          'precoLiquido': romaneioCarga.precoLiquido,
          'totalCarga': romaneioCarga.totalCarga
        }).then((value) async => await alert(
                contextoAplicacao, 'Sucesso', 'Formulário salvo com sucesso!'));
      } catch (on) {
        TextError('Erro ao salvar formulário!');
      }
    }
  }

  @override
  void dispose() {}
}
