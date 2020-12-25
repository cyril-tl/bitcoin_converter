import 'dart:collection';
import 'package:flutter/material.dart';

import 'package:bitcoin_converter/models/monnaie.dart';

class MonnaiesModel extends ChangeNotifier{
  final List<Monnaie> _monnaies = [];
  UnmodifiableListView<Monnaie> get monnaies => UnmodifiableListView<Monnaie>(_monnaies);

  void add(Monnaie monnaie){
    var present = false;
    for(var i=0; i<_monnaies.length; i++) {
      if(monnaie.getDevise() == _monnaies[i].getDevise()) {
        present=true;
        break;
      }
    }

    if(present){
      print('${monnaie.getDevise()} est déjà préent dans la liste $_monnaies');
    } else {
      _monnaies.add(monnaie);
      notifyListeners();
      print('${monnaie.getDevise()} ajouté à la liste $_monnaies');
    }
  }

  void remove(int index){
    _monnaies.removeAt(index);
    notifyListeners();
  }
}
