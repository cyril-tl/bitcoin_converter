import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bitcoin_converter/models/monnaies_model.dart';
import 'package:bitcoin_converter/pages/converter.dart';
import 'package:bitcoin_converter/pages/monnaies_page.dart';
import 'package:bitcoin_converter/pages/new_monnaie_page.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => MonnaiesModel(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  static const String _title = 'Bitcoin Converter';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        hintColor: Colors.white,
        primaryColor: Colors.orangeAccent,
      ),
      home: MyStatelessWidget(),
    );
  }
}

/// Une SnackBar
final SnackBar snackBar = const SnackBar(content: Text('Ça se passe sur la page suivante'));
final SnackBar snackBar2 = const SnackBar(content: Text('IconButton + snackbar'));

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class MyStatelessWidget extends StatelessWidget {
  MyStatelessWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.blueGrey[800],
      appBar: AppBar(
        title: const Text('Bitcoin App'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_alert),
            tooltip: 'Cliquez sur la flèche pour commencer',
            onPressed: () {
              scaffoldKey.currentState.showSnackBar(snackBar);
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 40,),
            child: IconButton(
              icon: const Icon(Icons.arrow_forward),
              tooltip: 'Page Suivante',
              onPressed: () {
                openPage(context);
              },
            ),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(64.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Image.asset(
                  '/images/symbole-BTC1.png',
                  //height: 42.0,
                ),
                onPressed: () {
                  scaffoldKey.currentState.showSnackBar(snackBar2);
                  print('IconButton is pressed');
                },
                iconSize: 128,
              ),
              Text(
                'The Bitcoin Observer',
                //style: Theme.of(context).textTheme.headline2,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 42,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'Cette application vous permet de consulter le cours du Bitcoin dans plusieurs devises',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 32,
              ),
              RaisedButton(
                padding: EdgeInsets.all(20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                color: Colors.orangeAccent,
                child: Text('COMMENCER', style: TextStyle( color: Colors.white,fontSize: 20,),
                ),
                onPressed: () {
                  openPage(context);
                },
              ),
              SizedBox(
                height: 32,
              ),
              RaisedButton(
                padding: EdgeInsets.all(20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(90),
                ),
                color: Colors.orangeAccent,
                child: Text('ALLER AU MULTI-CONVERTISSEUR', style: TextStyle( color: Colors.white, fontSize: 20,)
                ),
                onPressed: () {
                  Navigator.of(context).push(_createRoute(Converter()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Route _createRoute(widget) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => widget,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.easeInCirc;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
    transitionDuration: Duration(milliseconds: 2000),
  );
}

/// Pages de fonctionnalités
void openPage(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(
    builder: (BuildContext context) {
      return Scaffold(
        body: Center(
            child: DefaultTabController(
              length: 2,
              initialIndex: 0,
              child: Scaffold(
                appBar: AppBar(
                  title: Text("Accueil"),
                  bottom: TabBar(
                    tabs: [
                      Tab(text: "Ajout"),
                      Tab(text: "Résultats"),
                    ],
                  ),
                ),
                body: SafeArea(
                  bottom: false,
                  child: TabBarView(
                    children: [
                      NewMonnaiePage(
                        onMonnaieCreated: (monnaie) {
                          Provider.of<MonnaiesModel>(context, listen: false).add(monnaie);
                        },
                      ),
                      Consumer<MonnaiesModel>(
                        builder: (context, monnaiesModel, child) {
                          return MonnaiesPage(
                            monnaies: monnaiesModel.monnaies,
                            onDelete: (index) => monnaiesModel.remove(index),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
        ),
      );
    },
  ));
}





