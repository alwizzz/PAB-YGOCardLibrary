import 'package:ygo_card_library/db/CardsDatabase.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sqflite/sqflite.dart';

import 'pages/home.dart';
import 'pages/loading.dart';
import 'pages/detail.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // List<Deck> dummy = await CardsDatabase.instance.readAllDeck();
  var db = await CardsDatabase.instance.initDB('decks.db');

  return runApp(MaterialApp(
    theme: ThemeData(
      fontFamily: 'YuGiOh Caps'
    ),
    initialRoute: '/',
    routes: {
      '/': (context) => Loading(),
      '/home': (context) => Home(),
      '/detail': (context) => Detail(),
    },
  ));
}
