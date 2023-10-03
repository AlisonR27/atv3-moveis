import 'package:atv3/inc/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Exchanger extends StatefulWidget {
  const Exchanger({super.key});

  @override
  State<StatefulWidget> createState() => _ExchangerState();
}

Future<Map> getData() async {
  http.Response response = await http.get(Uri.parse(Utils.apiURL("general")));
  return json.decode(response.body);
}

class _ExchangerState extends State<StatefulWidget> {
  final usdController = TextEditingController();
  final eurController = TextEditingController();
  final brlController = TextEditingController();

  double dolar = 0;
  double euro = 0;

  void _clear() {
    usdController.text = "";
    eurController.text = "";
    brlController.text = "";
  }

  void _handleUpdate(String text, String prefix) {
    if (text.isEmpty) {
      _clear();
      return;
    }
    double curr = double.parse(text);
    if (prefix == "BRL") {
      usdController.text = (curr / dolar).toStringAsFixed(2);
      eurController.text = (curr / euro).toStringAsFixed(2);
    } else if (prefix == "USD") {
      brlController.text = (curr * dolar).toStringAsFixed(2);
      eurController.text = (curr * dolar / euro).toStringAsFixed(2);
    } else if (prefix == "EUR") {
      usdController.text = (curr * euro).toStringAsFixed(2);
      eurController.text = (curr * euro / dolar).toStringAsFixed(2);
    }
  }

  @override
  Widget build(BuildContext context) => Container(
        child: FutureBuilder<Map>(
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return const Center(
                      child: SpinKitChasingDots(
                    color: Colors.white,
                    size: 30.0,
                  ));
                default:
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Erro.'),
                    );
                  } else {
                    dolar =
                        snapshot.data!["results"]["currencies"]["USD"]["buy"];
                    euro =
                        snapshot.data!["results"]["currencies"]["EUR"]["buy"];
                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(15.0),
                      child: Wrap(runSpacing: 20.0, children: <Widget>[
                        buildTextForm("Reais (R\$)", "BRL", brlController),
                        buildTextForm("Dólar (US\$)", "USD", usdController),
                        buildTextForm("Euro", "EUR", eurController),
                      ]),
                    );
                  }
              }
            },
            future: getData()),
      );

  Widget buildTextForm(
      String label, String prefix, TextEditingController ctrl) {
    return TextField(
      onChanged: (String value) {
        _handleUpdate(value, prefix);
      },
      controller: ctrl,
      decoration: InputDecoration(
        isDense: true,
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white, fontSize: 18.0),
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.all(15.0),
        prefixText: "$prefix  ",
        prefixStyle: const TextStyle(color: Colors.blueGrey, fontSize: 20.0),
      ),
      style: const TextStyle(
        fontSize: 20.0,
      ),
      textAlign: TextAlign.left,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
    );
  }
}
