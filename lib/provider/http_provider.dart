import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:bitcoin_converter/models/bitcoin_model.dart';

Future<BitcoinResponse> getBitcoin() async{
  final url = "https://api.hgbrasil.com/finance?format=json-cors";

  final response = await http.get(url);

  if(response.statusCode == 200){
    final jsonBitcoin = jsonDecode(response.body);
    return BitcoinResponse.fromJson(jsonBitcoin);
  }else{
    throw Exception();
  }

}