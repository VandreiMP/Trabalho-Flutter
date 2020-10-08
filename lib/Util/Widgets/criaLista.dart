import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {
  final List<String> valores;
  final Function retornaValor;

  const DropDown({
    this.valores, this.retornaValor,
  });
  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String valorSelecionado;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          DropdownButton<String>(
            items: widget.valores.map((
              String dropDownStringItem,
            ) {
              return DropdownMenuItem<String>(
                value: dropDownStringItem,
                child: Text(dropDownStringItem),
              );
            }).toList(),
            onChanged: (
              String novoValorSelecionado,
            ) {
              setState(() {
                this.valorSelecionado = novoValorSelecionado;
                retornaValor(novoValorSelecionado) async {
                  return novoValorSelecionado;
                };
              });
            },
            value: valorSelecionado,
          ),
          /* Text(
            "A cidade selecionada foi \n$_itemSelecionado",
            style: TextStyle(fontSize: 20.0),
          ),*/
        ],
      ),
    );
  }
}
