import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Stock extends StatefulWidget {
  const Stock({super.key});

  @override
  _StockState createState() => _StockState();
}

class _StockState extends State<Stock> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
      child: Column(
        children: <Widget>[
          TextField(
            controller: searchController,
            textInputAction: TextInputAction.search,
            decoration: const InputDecoration(
                label: Text("Pesquisar ação"),
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigoAccent))),
          ),
          FutureBuilder<Map>(
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return const Text('Carregando');
                case ConnectionState.done:
                  return const Text('Carregou');
              }
            },
            future: null,
          )
        ],
      ));
}
