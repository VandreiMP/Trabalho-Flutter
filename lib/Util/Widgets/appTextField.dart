import 'package:controle_romaneio/Util/Widgets/requiredLabel.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String label;
  final bool required;
  final String hint;
  final double width;
  final double heigth;
  final bool enabled;
  final bool password;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onChanged;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Function onFieldSubmitted;
  final FocusNode focusNode;
  final FocusNode nextFocus;
  final int tamanhoMaximo;
  String valorInicial;

  AppTextField({
    this.label,
    this.onFieldSubmitted,
    this.required = false,
    this.hint,
    this.width,
    this.heigth,
    this.password = false,
    this.controller,
    this.validator,
    this.onChanged,
    this.keyboardType,
    this.textInputAction,
    this.focusNode,
    this.nextFocus,
    this.tamanhoMaximo,
    this.valorInicial,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RequiredLabel(label, required),
        _textField(context),
        SizedBox(
          height: 10,
        )
      ],
    );
  }

  _textField(context) {
    return Container(
      height: heigth,
      width: width ?? double.maxFinite,
      child: TextFormField(
        maxLengthEnforced: true,
        cursorColor: Colors.black,
        initialValue: valorInicial,
        controller: controller,
        enabled: enabled,
        obscureText: password,
        validator: validator,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        autofocus: false,
        onChanged: onChanged,
        onFieldSubmitted: (String text) {
          if (nextFocus != null) {
            FocusScope.of(context).requestFocus(nextFocus);
            onFieldSubmitted();
          }
        },
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
        decoration: InputDecoration(),
      ),
    );
  }
}
