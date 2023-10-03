import 'package:flutter/material.dart';

class Utils {
  static GlobalKey<NavigatorState> mainAppNav = GlobalKey();
  static String apiURL(String type) {
    switch (type) {
      case 'general':
        return "https://api.hgbrasil.com/finance?format=json-cors&key=2a34b926";
      case 'bitcoin':
        return "https://api.hgbrasil.com/finance?array_limit=1&fields=only_results,bitcoin&key=SUA-CHAVE";
      case 'taxes':
        return "https://api.hgbrasil.com/finance/taxes?key=SUA-CHAVE";
      default:
        return "https://api.hgbrasil.com/finance?format=json-cors&key=2a34b926";
    }
  }
}
