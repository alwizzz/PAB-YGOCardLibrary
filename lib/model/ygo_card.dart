import 'package:flutter/material.dart';

final String tableYGOCards = 'YGOcards';

class YGOCardFields {
  static final List<String> all = [
    id,
    api_id,
    name,
    type,
    desc,
    atk,
    def,
    level,
    race,
    attribute,
    archetype,
    image_url,
    image_url_small
  ];

  static final String id = '_id';
  static final String api_id = 'api_id';
  static final String name = 'name';
  static final String type = 'type';
  static final String desc = 'desc';
  static final String atk = 'atk';
  static final String def = 'def';
  static final String level = 'level';
  static final String race = 'race';
  static final String attribute = 'attribute';
  static final String archetype = 'archetype';
  static final String image_url = 'image_url';
  static final String image_url_small = 'image_url_small';
}

class YGOCard {
  final int? id;
  final int api_id;
  final String name;
  final String type;
  final String desc;
  final int atk;
  final int def;
  final int level;
  final String race;
  final String attribute;
  final String archetype;
  final String image_url;
  final String image_url_small;

  const YGOCard({
    this.id,
    required this.api_id,
    required this.name,
    required this.type,
    required this.desc,
    required this.atk,
    required this.def,
    required this.level,
    required this.race,
    required this.attribute,
    required this.archetype,
    required this.image_url,
    required this.image_url_small,
  });

  Map<String, Object?> toJson() => {
        YGOCardFields.id: id,
        YGOCardFields.api_id: api_id,
        YGOCardFields.name: name,
        YGOCardFields.type: type,
        YGOCardFields.desc: desc,
        YGOCardFields.atk: atk,
        YGOCardFields.def: def,
        YGOCardFields.level: level,
        YGOCardFields.race: race,
        YGOCardFields.attribute: attribute,
        YGOCardFields.archetype: archetype,
        YGOCardFields.image_url: image_url,
        YGOCardFields.image_url_small: image_url_small,
      };

  YGOCard copy(
          {int? id,
          int? api_id,
          String? name,
          String? type,
          String? desc,
          int? atk,
          int? def,
          int? level,
          String? race,
          String? attribute,
          String? archetype,
          String? image_url,
          String? image_url_small}) =>
      YGOCard(
        id: id ?? this.id,
        api_id: api_id ?? this.api_id,
        name: name ?? this.name,
        type: type ?? this.type,
        desc: desc ?? this.desc,
        atk: atk ?? this.atk,
        def: def ?? this.def,
        level: level ?? this.level,
        race: race ?? this.race,
        attribute: attribute ?? this.attribute,
        archetype: archetype ?? this.archetype,
        image_url: image_url ?? this.image_url,
        image_url_small: image_url_small ?? this.image_url_small,
      );

  static YGOCard fromJson(Map<String, Object?> json) => YGOCard(
        id: json[YGOCardFields.id] as int?,
        api_id: json[YGOCardFields.api_id] as int,
        name: json[YGOCardFields.name] as String,
        type: json[YGOCardFields.type] as String,
        desc: json[YGOCardFields.desc] as String,
        atk: json[YGOCardFields.atk] as int,
        def: json[YGOCardFields.def] as int,
        level: json[YGOCardFields.level] as int,
        race: json[YGOCardFields.race] as String,
        attribute: json[YGOCardFields.attribute] as String,
        archetype: json[YGOCardFields.archetype] as String,
        image_url: json[YGOCardFields.image_url] as String,
        image_url_small: json[YGOCardFields.image_url_small] as String,
      );

  static Color getColor(String type) {
    // print(type);
    if (type == "Spell Card") {
      return Color.fromARGB(255, 73, 213, 150);
    } else if (type == "Trap Card") {
      return Color.fromARGB(255, 200, 93, 161);
    } else if (type == "Normal Monster") {
      return Color.fromARGB(255, 183, 148, 94);
    } else if (type == "Effect Monster" || type == "Flip Effect Monster" || 
        type == "Flip Tuner Effect Monster" || type == "Gemini Monster" || type == "Tuner Monster") {
      return Color.fromARGB(255, 197, 129, 40);
    } else if (type == "Fusion Monster") {
      return Color.fromARGB(255, 154, 113, 199);
    } else if (type == "Ritual Monster" || type == "Ritual Effect Monster") {
      return Color.fromARGB(255, 139, 195, 255);
    } else if (type == "Synchro Monster") {
      return Color.fromARGB(255, 199, 198, 198);
    } else if (type == "Link Monster") {
      return Color.fromARGB(255, 39, 129, 255);
    } else if (type == "XYZ Monster") {
      return Color.fromARGB(255, 156, 156, 156);
    } else {
      return Color.fromARGB(255, 173, 206, 6);
    }
  }
}
