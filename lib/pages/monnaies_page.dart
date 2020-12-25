import 'package:flutter/material.dart';
import 'package:animated_dialog_box/animated_dialog_box.dart';

import 'package:bitcoin_converter/models/monnaie.dart';
import 'package:bitcoin_converter/provider/http_provider.dart';
import 'package:bitcoin_converter/models/bitcoin_model.dart';

class MonnaiesPage extends StatelessWidget {
  MonnaiesPage({this.monnaies, this.onDelete});

  final List<Monnaie> monnaies;
  final Function(int) onDelete;

  static double bitcoinBuy;
  static String sterlingPoundBuy;
  static String euroBuy;
  static String dollarBuy;
  static String yenBuy;

  static double bitcoinSell;
  static String sterlingPoundSell;
  static String euroSell;
  static String dollarSell;
  static String yenSell;

  static String sterlingPoundVariation;
  static String euroVariation;
  static String dollarVariation;
  static String yenVariation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[800],
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children : [
              FutureBuilder<BitcoinResponse>(
                future: getBitcoin(),
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    final datas = snapshot.data;

                    bitcoinSell = datas.results.currencies.btc.sell;
                    sterlingPoundSell = (bitcoinSell / (datas.results.currencies.gbp.buy*0.997)).toStringAsFixed(2);
                    euroSell = (bitcoinSell / datas.results.currencies.eur.sell).toStringAsFixed(2);
                    dollarSell = (bitcoinSell / datas.results.currencies.usd.sell).toStringAsFixed(2);
                    yenSell = (bitcoinSell / (datas.results.currencies.jpy.buy*0.997)).toStringAsFixed(2);

                    bitcoinBuy = datas.results.currencies.btc.buy;
                    sterlingPoundBuy = (bitcoinBuy / datas.results.currencies.gbp.buy).toStringAsFixed(2);
                    euroBuy = (bitcoinBuy / (datas.results.currencies.usd.buy)*0.84).toStringAsFixed(2);
                    dollarBuy = (bitcoinBuy / datas.results.currencies.usd.buy).toStringAsFixed(2);
                    yenBuy = (bitcoinBuy / datas.results.currencies.jpy.buy).toStringAsFixed(2);

                    sterlingPoundVariation = (datas.results.currencies.gbp.variation).toStringAsFixed(2);
                    euroVariation = (datas.results.currencies.eur.variation).toStringAsFixed(2);
                    dollarVariation = (datas.results.currencies.usd.variation).toStringAsFixed(2);
                    yenVariation = (datas.results.currencies.jpy.variation).toStringAsFixed(2);

                    return Text(
                        "\n\n Un Bitcoin vaut  : \n",
                            style: TextStyle(color: Colors.orangeAccent, fontSize: 25.0), textAlign: TextAlign.center,
                    );
                  } else if(snapshot.hasError){
                    return Text(snapshot.error.toString());
                  }
                  return CircularProgressIndicator();
                },
              ),

              Expanded(
                child: SizedBox(
                  height: 1000.0,
                    child:
                      ListView.separated(
                      itemCount: monnaies.length,
                      separatorBuilder: (BuildContext context, int index) => Divider(color: Colors.black),
                      itemBuilder: (context, index) {
                        final item = monnaies[index];
                        String assetPath = '1';
                        String name = 'Bitcoin';
                        String buy = "";
                        String sell = "";
                        String variation = "";
                        String symbol = "";
                        switch (item.devise) {
                          case Devise.GBP:
                            assetPath = 'images/symbole-GBP1.png';
                            symbol = 'GBP'; name = "Livres Sterling"; buy = "${sterlingPoundBuy}"; sell = sterlingPoundSell; variation = '${sterlingPoundVariation}';
                            break;
                          case Devise.EUR:
                            assetPath = 'images/symbole-EUR1.png';
                            symbol = 'EUR'; name = "Euros"; buy = '${euroBuy}'; sell = '${euroSell}'; variation = '${euroVariation}';
                            break;
                          case Devise.USD:
                            assetPath = 'images/symbole-USD1.png';
                            symbol = 'USD'; name = "Dollars États-Uniens"; buy = '${dollarBuy}'; sell = '${dollarSell}'; variation = '${dollarVariation}';
                            break;
                          case Devise.JPY:
                            assetPath = 'images/symbole-JPY1.png';
                            symbol = 'JPY'; name = "Yen Japonais - 円"; buy = '${yenBuy}'; sell = '${yenSell}'; variation = '${yenVariation}';
                            break;
                          default:
                            assetPath = 'images/symbole-BTC1.png';
                        }
                        return Center(
                          child: Container(
                            padding: EdgeInsets.only(top: 32.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 512,
                                  child: ListTile(
                                    title: Text("$buy $name",
                                      style: TextStyle(color: Colors.orangeAccent, fontSize: 20.0),
                                      textAlign: TextAlign.center,
                                    ),
                                    subtitle: Container(
                                      width: 256,
                                      padding: EdgeInsets.only(top: 8, left: 64, right: 64),
                                      child: MaterialButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(40),
                                        ),
                                        color: Colors.white,
                                        child: Text('Détails'),
                                        onPressed: () async {
                                          await animated_dialog_box.showRotatedAlert(
                                              title: Center(child: Text("Infos $name")), // IF YOU WANT TO ADD
                                              context: context,
                                              firstButton: MaterialButton(
                                                // FIRST BUTTON IS REQUIRED
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(0),
                                                ),
                                                child: Text('Fermer',),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              icon: Text("$symbol"),// IF YOU WANT TO ADD ICON
                                              yourWidget: Text( "Achat : $buy \n"
                                                          "Vente : $sell \n"
                                                          "Variation : $variation \n",
                                                    ),
                                            );
                                          },
                                      ),
                                    ),
                                    leading: Image(image: AssetImage(assetPath)),
                                    trailing: RaisedButton(
                                        child: Icon(Icons.clear, size: 20),
                                        onPressed: () => onDelete(index)),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        );
                      },
                  ),
                ),
              ),
            ],
          ),
    );

  }
}
