import 'package:currency_converter/cc_material_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'cc_cupertino_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp ({super.key});

  @override
  Widget build(BuildContext context){
    return const MaterialApp(
      home: CurrencyConverterMaterialPage(),
    );
  }
}

class MyCuppertinoApp extends StatelessWidget {
  const MyCuppertinoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      home: CurrencyConverterCuppertinoPage(),
    );
  }
}