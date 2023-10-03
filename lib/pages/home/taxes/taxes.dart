import 'package:atv3/inc/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Taxes extends StatefulWidget {
  const Taxes({super.key});

  @override
  _TaxesState createState() => _TaxesState();
}

Future<Map> getTaxes() async {
  http.Response response = await http.get(Uri.parse(Utils.apiURL("taxes")));
  return json.decode(response.body);
}

class _TaxesState extends State<Taxes> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Taxas:'),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0),
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
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return const Text(
                      "Erro!",
                      style: TextStyle(color: Colors.red),
                    );
                  } else {
                    double cdi = snapshot.data!["results"][0]["cdi"];
                    double selic = snapshot.data!["results"][0]["selic"];
                    double dailyFactor =
                        snapshot.data!["results"][0]["daily_factor"];
                    double selicDaily =
                        snapshot.data!["results"][0]["selic_daily"];
                    double cdiDaily = snapshot.data!["results"][0]["cdi_daily"];
                    return SingleChildScrollView(
                        child: Container(
                            height: 200,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: <Widget>[
                                customCard("CDI:", cdi),
                                customCard("Selic (%):", selic),
                                customCard("Fator Diário:", dailyFactor),
                                customCard("Selic Diária (%):", selicDaily),
                                customCard("CDI Diária (%):", cdiDaily),
                              ],
                            )));
                  }
                default:
                  return const Text("haha");
              }
            },
            future: getTaxes(),
          ),
        )
      ],
    );
  }
}

Widget customCard(String title, double value) {
  return Card(
    child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
        width: 200.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              textAlign: TextAlign.left,
              style: TextStyle(color: Colors.grey.shade400),
            ),
            Text(
              value.toStringAsFixed(2),
              style: TextStyle(fontSize: 40.0),
            )
          ],
        )),
  );
}
