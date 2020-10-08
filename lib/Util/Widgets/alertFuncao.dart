import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

alertFuncao(BuildContext context, String texto, String msg, Function callback) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Text("$texto"),
          content: Text("$msg"),
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                callback();
              },
            )
          ],
        ),
      );
    },
  );
}

alertConfirm(BuildContext context, String texto, String msg,
    {Function confirmCallback}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Text(texto),
          content: Text(msg),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancelar"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text("Confirmar"),
              onPressed: () {
                Navigator.pop(context);
                if (confirmCallback != null) {
                  confirmCallback();
                }
              },
            )
          ],
        ),
      );
    },
  );
}
