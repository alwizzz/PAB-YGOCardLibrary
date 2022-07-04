import 'package:path/path.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:sqflite/sqflite.dart';

import 'package:ygo_card_library/model/ygo_card.dart';

class CardsDatabase {
  static final instance = CardsDatabase._init();
  static Database? _database;

  CardsDatabase._init();

  Future<Database> get database async {
    await Sqflite.setDebugModeOn(true);
    if (_database != null) {
      return _database!;
    }

    _database = await initDB('decks.db');
    return _database!;
  }

  Future<Database> initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final integerType = 'INTEGER NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';

    // CREATE CARD TABLE
    await db.execute('''
      CREATE TABLE $tableYGOCards (
        ${YGOCardFields.id} $idType,
        ${YGOCardFields.api_id} $integerType,
        ${YGOCardFields.name} $textType,
        ${YGOCardFields.type} $textType,
        ${YGOCardFields.desc} $textType,
        ${YGOCardFields.atk} $integerType,
        ${YGOCardFields.def} $integerType,
        ${YGOCardFields.level} $integerType,
        ${YGOCardFields.race} $textType,
        ${YGOCardFields.attribute} $textType,
        ${YGOCardFields.archetype} $textType,
        ${YGOCardFields.image_url} $textType,
        ${YGOCardFields.image_url_small} $textType
      )
    ''');

    await _seedCards(db);
  }

  Future _seedCards(Database db) async {

    List<String> archetypes = [
      "Blue-Eyes",
      "Dark Magician",
      "Exodia",
      "Sky Striker",
      "Red-eyes"
    ];

    archetypes.forEach((archetype) async {
      // String archetype = "Blue-eyes";
      Response rsp = await get(Uri.parse(
          'https://db.ygoprodeck.com/api/v7/cardinfo.php?archetype=$archetype'));

      Map dt = jsonDecode(rsp.body);
      // print(dt['data'][0].runtimeType);
      List cards = dt['data'];
      cards.forEach((element) async {
        Map data = element as Map;
        print("oy oy ");
        print(data);

        int atk = (data.containsKey('atk')) ? data['atk'] : -1;
        int def = (data.containsKey('def')) ? data['def'] : -1;
        int level = (data.containsKey('level')) ? data['level'] : -1;
        String attribute = (data.containsKey('attribute')) ? data['attribute'] : "NON MONSTER";

        await createCardSeeding(
            db,
            new YGOCard(
              api_id: data['id'],
              name: data['name'],
              type: data['type'],
              desc: data['desc'],
              atk: atk,
              def: def,
              level: level,
              race: data['race'],
              attribute: attribute,
              archetype: data['archetype'],
              image_url: data['card_images'][0]['image_url'],
              image_url_small: data['card_images'][0]['image_url_small'],
            ));
      });
    });
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }

  // CARD CRUD

  Future<YGOCard> createCard(YGOCard card) async {
    final db = await instance.database;

    final id = await db.insert(tableYGOCards, card.toJson());

    return card.copy(id: id);
  }

  Future<YGOCard> createCardSeeding(Database db, YGOCard card) async {
    // final db = await instance.database;

    final id = await db.insert(tableYGOCards, card.toJson());

    return card.copy(id: id);
  }

  Future<YGOCard?> readCard(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableYGOCards,
      columns: YGOCardFields.all,
      where: '${YGOCardFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return YGOCard.fromJson(maps.first);
    } else {
      // throw Exception('ID $id not found');
      return null;
    }
  }

  Future<List<YGOCard>> readAllCard() async {
    final db = await instance.database;

    final orderBy = '${YGOCardFields.name} ASC';
    final result = await db.query(tableYGOCards, orderBy: orderBy);

    return result.map((json) => YGOCard.fromJson(json)).toList();
  }

  Future<List<YGOCard>> readCardWithFuzzyName(String fuzzy_name) async {
    final db = await instance.database;

    final orderBy = '${YGOCardFields.name} ASC';
    final result = await db.query(tableYGOCards,
        columns: YGOCardFields.all,
        where: '${YGOCardFields.name} LIKE \'%$fuzzy_name%\'',
        // whereArgs: [fuzzy_name],
        orderBy: orderBy);

    return result.map((json) => YGOCard.fromJson(json)).toList();
  }
}
