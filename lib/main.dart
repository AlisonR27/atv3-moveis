import 'package:atv3/inc/utils.dart';
import 'package:atv3/pages/stock/stock.dart';
import 'package:flutter/material.dart';
import './inc/menu.dart';
import './pages/home/home.dart';
import 'dart:developer';

GlobalKey<NavigatorState> mainAppNav = GlobalKey();
void main() async {
  runApp(MaterialApp(
    home: Base(title: 'Testing'),
    theme: ThemeData(
        colorScheme: ColorScheme.dark(primary: Colors.indigo.shade700),
        brightness: Brightness.dark),
  ));
}

// ignore: must_be_immutable
class Base extends StatelessWidget {
  final String title;
  Base({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    log('Navigator da base: ${Navigator.of(context)}');
    return Scaffold(
        appBar: AppBar(
          title: const Text('Conversor de Moedas'),
          backgroundColor: Theme.of(context).colorScheme.primary,
          automaticallyImplyLeading: true,
        ),
        drawer: MenuDrawer(context),
        body: Navigator(
          key: Utils.mainAppNav,
          initialRoute: '/',
          onGenerateRoute: (settings) {
            log('Route name: ${settings.name}');
            Widget page;
            switch (settings.name) {
              case 'stocks':
                page = const Stock();
                break;
              default:
                page = const HomeWidget();
                break;
            }

            return PageRouteBuilder(
                pageBuilder: (_, __, ___) => page,
                transitionDuration: const Duration(seconds: 0));
          },
        ));
  }
}
