import 'package:flutter/material.dart';
import './inc/menu.dart';
import './pages/home/home.dart';

void main() async {
  runApp(MaterialApp(
    home: const StockHome(title: 'Testing'),
    theme: ThemeData(
        colorScheme: ColorScheme.dark(primary: Colors.indigo.shade700),
        brightness: Brightness.dark),
  ));
}

class StockHome extends StatefulWidget {
  const StockHome({super.key, required this.title});
  final String title;
  @override
  State<StockHome> createState() => _StockHomeState();
}

class _StockHomeState extends State<StockHome> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('IceStock'),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        drawer: const MenuDrawer(),
        body: const HomeWidget(),
      );
}
