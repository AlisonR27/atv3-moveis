import 'package:atv3/inc/utils.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import '../pages/stock/stock.dart';

// ignore: must_be_immutable
Widget MenuDrawer(BuildContext context) {
  Widget buildHeader() => Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      );

  Widget buildItems() => Wrap(
        runSpacing: 16,
        children: [
          ListTile(
            leading: const Icon(Icons.currency_exchange_outlined),
            title: const Text('Coins conversor'),
            onTap: () {
              Navigator.of(context).pop();
              Utils.mainAppNav.currentState?.popAndPushNamed('/');
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_balance_wallet_outlined),
            title: const Text('Stock status'),
            onTap: () {
              Navigator.of(context).pop();
              Utils.mainAppNav.currentState?.popAndPushNamed('stocks');
            },
          ),
          ListTile(
              leading: const Icon(Icons.currency_bitcoin_outlined),
              title: const Text('Bitcoin'),
              onTap: () {
                Navigator.of(context).pop();
                Utils.mainAppNav.currentState?.popAndPushNamed('bitcoin');
              })
        ],
      );
  return Drawer(
    child: SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        buildHeader(),
        buildItems(),
      ],
    )),
  );
}
