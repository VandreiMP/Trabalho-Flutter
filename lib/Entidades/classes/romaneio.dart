import 'package:cloud_firestore/cloud_firestore.dart';
import '../../shared/base_model.dart';

class RomaneioCarga extends BaseModel {
  String numeroRomaneio;
  String observacao;
  String modalidadeFrete;
  String dataSaidaViagem;
  String dataRetornoViagem;
  String cidadeSaida;
  String ufSaida;
  String cidadeDestino;
  String ufDestino;
  double pesoBruto;
  double pesoLiquido;
  double cubagemCarga;
  double quantidade;
  double precoLiquido;
  double totalCarga;

  RomaneioCarga();

  RomaneioCarga.fromMap(DocumentSnapshot document) {
    this.numeroRomaneio = document.data['numeroRomaneio'];
    this.observacao = document['observacao'];
    this.modalidadeFrete = document['modalidade'];
    this.dataSaidaViagem = document['dataSaidaViagem'];
    this.dataRetornoViagem = document['dataRetornoViagem'];
    this.cidadeSaida = document['cidadeSaida'];
    this.ufSaida = document['ufSaida'];
    this.cidadeDestino = document['cidadeDestino'];
    this.ufDestino = document['ufDestino'];
    this.pesoBruto = document.data['pesoBruto'];
    this.pesoLiquido = document.data['pesoLiquido'];
    this.cubagemCarga = document.data['cubagemCarga'];
    this.quantidade = document.data['quantidade'];
    this.precoLiquido = document.data['precoLiquido'];
    this.totalCarga = document.data['totalCarga'];

    @override
    toMap() {
      var map = new Map<String, dynamic>();
      map['numeroRomaneio'] = this.numeroRomaneio;
      map['observacao'] = this.observacao;
      map['modalidadeFrete'] = this.modalidadeFrete;
      map['dataSaidaViagem'] = this.dataSaidaViagem;
      map['dataRetornoViagem'] = this.dataRetornoViagem;
      map['cidadeSaida'] = this.cidadeSaida;
      map['ufSaida'] = this.ufSaida;
      map['cidadeDestino'] = this.cidadeDestino;
      map['ufDestino'] = this.ufDestino;
      map['pesoBruto'] = this.pesoBruto;
      map['pesoLiquido'] = this.pesoLiquido;
      map['cubagemCarga'] = this.cubagemCarga;
      map['quantidade'] = this.quantidade;
      map['precoLiquido'] = this.precoLiquido;
      map['totalCarga'] = this.totalCarga;

      return map;
    }

    @override
    //   String documentId() => _documentId;
    // }

    @override
    String documentId() {
      // TODO: implement documentId
      throw UnimplementedError();
    }
  }

  @override
  String documentId() {
    // TODO: implement documentId
    throw UnimplementedError();
  }

  @override
  toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }
}
