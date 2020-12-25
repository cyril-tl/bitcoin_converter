import 'package:flutter/material.dart';

import 'package:bitcoin_converter/models/monnaie.dart';

class NewMonnaiePage extends StatefulWidget {
  NewMonnaiePage({this.onMonnaieCreated}) : super();

  final Function(Monnaie) onMonnaieCreated;

  @override
  _NewMonnaiePageState createState() => _NewMonnaiePageState();
}

final snackBar = SnackBar(content: Text('Ajouté à la liste des résultats !'));

class _NewMonnaiePageState extends State<NewMonnaiePage> {
  Devise selectedDevise = Devise.GBP;

  updateDevise(Devise devise) {
    setState(() {
      selectedDevise = devise;
    });
  }

  createNewMonnaie(Devise devise) {
    final monnaie = Monnaie(devise);
    widget.onMonnaieCreated(monnaie);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[800],
        body: SingleChildScrollView(
          padding: EdgeInsets.all(32.0),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      " Monnaies consultables",
                      style: TextStyle(color: Colors.orangeAccent, fontSize: 25.0),
                  ),
                ],
              ),
              Divider(),
              Center(
                child: SizedBox(
                  width: 256.0,
                  child: ListTile(
                    title: const Text('Livre Sterling',
                      style: TextStyle(color: Colors.orangeAccent, fontSize: 20.0),),
                    leading: Radio(
                      value: Devise.GBP,
                      groupValue: selectedDevise,
                      activeColor: Colors.orangeAccent,
                      onChanged: updateDevise,
                    ),
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  width: 256.0,
                  child: ListTile(
                    title: const Text('Euros',
                      style: TextStyle(color: Colors.orangeAccent, fontSize: 20.0),),
                      leading: Radio(
                        value: Devise.EUR,
                        groupValue: selectedDevise,
                      activeColor: Colors.orangeAccent,
                      onChanged: updateDevise,
                      ),
                    ),
                ),
              ),
              Center(
                child: SizedBox(
                    width: 256.0,
                    child: ListTile(
                      title: const Text('Dollar États-Unien',
                        style: TextStyle(color: Colors.orangeAccent, fontSize: 20.0),),
                      leading: Radio(
                        value: Devise.USD,
                        groupValue: selectedDevise,
                      activeColor: Colors.orangeAccent,
                      onChanged: updateDevise,
                      ),
                    ),
                ),
              ),
              Center(
                child: SizedBox(
                    width: 256.0,
                    child:ListTile(
                      title: const Text('Yen Japonais',
                        style: TextStyle(color: Colors.orangeAccent, fontSize: 20.0),),
                      leading: Radio(
                        value: Devise.JPY,
                        groupValue: selectedDevise,
                      activeColor: Colors.orangeAccent,
                      onChanged: updateDevise,
                      ),
                    ),
                ),
              ),

              Divider(),
              Divider(),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                color: Colors.white,
                child: Text('Ajouter'),
                onPressed: () {
                  createNewMonnaie(this.selectedDevise);
                  Scaffold.of(context).showSnackBar(snackBar);
                },
              ),
            ]
          ),
        ),
    );
  }
}
