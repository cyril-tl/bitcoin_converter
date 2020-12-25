import 'package:flutter/material.dart';

import 'package:bitcoin_converter/provider/http_provider.dart';
import 'package:bitcoin_converter/models/bitcoin_model.dart';

class HttpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[800],
      body: FutureBuilder<BitcoinResponse>(
          future: getBitcoin(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              final datas = snapshot.data;
              double bitcoin = datas.results.currencies.btc.buy;
              double gbp = double.parse((bitcoin / datas.results.currencies.gbp.buy).toStringAsFixed(2));
              double eur = double.parse((bitcoin / datas.results.currencies.eur.buy).toStringAsFixed(2));
              double usd = double.parse((bitcoin / datas.results.currencies.usd.buy).toStringAsFixed(2));
              double jpy = double.parse((bitcoin / datas.results.currencies.jpy.buy).toStringAsFixed(2));
              return Text(
                  "Un Bitcoin vaut  :"
                      " ${gbp} GBP "
                      " ${eur} EUR "
                      " ${usd} USD "
                      " ${jpy} JPY "
              );

            }else if(snapshot.hasError){
              return Text(snapshot.error.toString());
            }

            return CircularProgressIndicator();
          },
        ),
    );
  }
}