import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance?format=json-cors";

class Converter extends StatefulWidget {
  @override
  _ConverterState createState() => _ConverterState();
}

Future<Map> fetchDatas() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class _ConverterState extends State<Converter> {
  final bitcoinController = TextEditingController();
  final sterlingPoundController = TextEditingController();
  final euroController = TextEditingController();
  final dollarController = TextEditingController();
  final yenController = TextEditingController();

  double bitcoinBuy;
  double sterlingPoundBuy;
  double euroBuy;
  double dollarBuy;
  double yenBuy;

  void _clearAll() {
    bitcoinController.text = "";
    sterlingPoundController.text = "";
    euroController.text = "";
    dollarController.text = "";
    yenController.text = "";
  }

  void _bitcoinChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double bitcoin = double.parse(text);
    sterlingPoundController.text = (bitcoin * this.bitcoinBuy / sterlingPoundBuy).toStringAsFixed(2);
    euroController.text = (bitcoin * this.bitcoinBuy / euroBuy).toStringAsFixed(2);
    dollarController.text = (bitcoin * this.bitcoinBuy / dollarBuy).toStringAsFixed(2);
    yenController.text = (bitcoin * this.bitcoinBuy / yenBuy).toStringAsFixed(2);
  }

  void _sterlingPoundChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double sterling = double.parse(text);
    bitcoinController.text = (sterling * this.sterlingPoundBuy / bitcoinBuy).toStringAsFixed(8);
    dollarController.text = (sterling * this.sterlingPoundBuy / dollarBuy).toStringAsFixed(2);
    euroController.text = (sterling * this.sterlingPoundBuy / euroBuy).toStringAsFixed(2);
    yenController.text = (sterling * this.sterlingPoundBuy / yenBuy).toStringAsFixed(2);
  }

  void _euroChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double euro = double.parse(text);
    bitcoinController.text = (euro * this.euroBuy / bitcoinBuy).toStringAsFixed(8);
    sterlingPoundController.text = (euro * this.euroBuy / sterlingPoundBuy).toStringAsFixed(2);
    dollarController.text = (euro * this.euroBuy / dollarBuy).toStringAsFixed(2);
    yenController.text = (euro * this.euroBuy / yenBuy).toStringAsFixed(2);
  }

  void _dollarChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double dollar = double.parse(text);
    bitcoinController.text = (dollar * this.dollarBuy / bitcoinBuy).toStringAsFixed(8);
    sterlingPoundController.text = (dollar * this.dollarBuy / sterlingPoundBuy).toStringAsFixed(2);
    euroController.text = (dollar * this.dollarBuy / euroBuy).toStringAsFixed(2);
    yenController.text = (dollar * this.dollarBuy / yenBuy).toStringAsFixed(2);
  }

  void _yenChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double yen = double.parse(text);
    int decimal = 5;
    if (yen >= 10) decimal = 4;
    else if (yen >= 100) decimal = 3;
    else if (yen >= 1000) decimal = 2;
    bitcoinController.text = (yen * this.yenBuy / bitcoinBuy).toStringAsFixed(6+decimal);
    sterlingPoundController.text = (yen * this.yenBuy / sterlingPoundBuy).toStringAsFixed(decimal);
    euroController.text = (yen * this.yenBuy / euroBuy).toStringAsFixed(decimal);
    dollarController.text = (yen * this.yenBuy / dollarBuy).toStringAsFixed(decimal);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[800],
      appBar: AppBar(
        title: Text('Multi-Convertisseur',),
      ),

      body: FutureBuilder(
          future: fetchDatas(),
          //snapshot of the context/getData
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                    child: Text(
                      "Chargement...",
                      style: TextStyle(color: Colors.orangeAccent, fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ));
              default:
                if (snapshot.hasError) {
                  return Center(
                      child: Text(
                        "Erreur :(",
                        style: TextStyle(color: Colors.orangeAccent, fontSize: 25.0),
                        textAlign: TextAlign.center,
                      ));
                } else {
                  //here we pull the us and eu rate
                  bitcoinBuy = snapshot.data["results"]["currencies"]["BTC"]["buy"];
                  sterlingPoundBuy = snapshot.data["results"]["currencies"]["GBP"]["buy"];
                  euroBuy = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                  dollarBuy = snapshot.data["results"]["currencies"]["USD"]["buy"];
                  yenBuy = snapshot.data["results"]["currencies"]["JPY"]["buy"];
                  return SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.monetization_on,
                                size: 150.0, color: Colors.orangeAccent),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: buildTextField(
                                  "Bitcoin", "₿ ", bitcoinController, _bitcoinChanged),
                            ),
                            Divider(),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: buildTextField(
                                  "Livre Anglaise", "£ ", sterlingPoundController, _sterlingPoundChanged),
                            ),
                            Divider(),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: buildTextField(
                                  "Euros", "€ ", euroController, _euroChanged),
                            ),
                            Divider(),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: buildTextField(
                                  "Dollars États-Uniens", "\$ ", dollarController, _dollarChanged),
                            ),
                            Divider(),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: buildTextField(
                                  "Yen Japonais 円", "¥ ", yenController, _yenChanged),
                            ),
                          ]
                      )
                  );
                }
            }
          }),
    );
  }
}

Widget buildTextField( String label, String prefix, TextEditingController controller, Function computeOnChange) {
  return Container(
      width: 256.0,
      child:
      TextField(
        controller: controller,
        decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(color: Colors.orangeAccent),
            prefixText: prefix,
            border: OutlineInputBorder()
        ),
        style: TextStyle(color: Colors.orangeAccent, fontSize: 25.0),
        onChanged: computeOnChange,
        keyboardType: TextInputType.numberWithOptions(decimal: true),
      )
  );
}
