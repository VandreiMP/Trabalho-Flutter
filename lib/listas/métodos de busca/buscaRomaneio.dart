import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:controle_romaneio/Util/Widgets/appText.dart';
import 'package:flutter/material.dart';

class BuscaRomaneio extends StatefulWidget {
  @override
  _BuscaRomaneioState createState() => _BuscaRomaneioState();
}

class _BuscaRomaneioState extends State<BuscaRomaneio> {
  @override
  Widget build(BuildContext context) {
    final Firestore firestore = Firestore.instance;
    return Row(
      children: [
        Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: firestore
                  .collection("romaneioCarga")
                  .orderBy("carga", descending: false)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData)
                  return Center(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Consultando registros...',
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 8),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CircularProgressIndicator(),
                    ],
                  ));

                final int romaneioContador = snapshot.data.documents.length;
                if (romaneioContador > 0) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: new Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              //padding: EdgeInsets.only(bottom: 15),
                              alignment: Alignment.topLeft,
                              width: 310,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: romaneioContador,
                                itemBuilder: (BuildContext context, int index) {
                                  final DocumentSnapshot document =
                                      snapshot.data.documents[index];
                                  final dynamic observacao =
                                      document['observacao'];
                                  final dynamic carga = document['carga'];

                                  return Container(
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pushNamed(
                                                '/FormularioRomaneio',
                                                arguments: carga);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              alignment: Alignment.topLeft,
                                              padding: EdgeInsets.all(10),
                                              width: 290,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5)),
                                                border: new Border.all(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              child: Text(observacao.toString()),
                                            ),
                                          ),
                                        ),
                                     //   SizedBox(height: 5),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            'Não há nenhum romaneio salvo.',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
