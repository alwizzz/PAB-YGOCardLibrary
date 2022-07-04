import 'package:flutter/material.dart';
import 'package:ygo_card_library/model/ygo_card.dart';
import 'package:ygo_card_library/db/CardsDatabase.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Detail extends StatefulWidget {
  const Detail({Key? key}) : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  Map data = {};
  late Future<void> populated;
  late YGOCard ygoCard;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // this.populate();
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments as Map;

    var futures = <Future<dynamic>>[];
    this.populate();
    futures.add(this.populated);

    return FutureBuilder<void>(
        future: Future.wait(futures),
        // var cards = await Deck
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Scaffold(
              backgroundColor: Colors.grey[400],
              body: SpinKitWanderingCubes(
                color: Colors.white,
                size: 50,
              ),
            );
          } else {
            return Scaffold(
                appBar: AppBar(
                  title: Text(
                  'Card Detail',
                  style: TextStyle(
                    fontSize: 35.0
                  ),
                ),
                  centerTitle: true,
                  backgroundColor: Colors.grey[800],
                ),
                body: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        
                        // SizedBox(height: 10.0),
                        Image.network(ygoCard.image_url),
                        SizedBox(height: 18.0),
                        Text(
                          ygoCard.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 18.0),

                        Container(
                          padding: EdgeInsets.all(10),
                          color: Color.fromARGB(255, 255, 243, 206),
                          alignment: Alignment.centerLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              (() {
                                if (ygoCard.attribute != "NON MONSTER") {
                                  return Text(
                                    "Attribute: " + ygoCard.attribute,
                                    style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                } else {
                                  return SizedBox(height: 0);
                                }
                              })(),
                              Text(
                                "Type: " + ygoCard.type,
                                style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Race: " + ygoCard.race,
                                style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              (() {
                                if (ygoCard.level != -1) {
                                  return Text(
                                    "Level: " + ygoCard.level.toString(),
                                    style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                } else {
                                  return SizedBox(height: 0);
                                }
                              })(),
                              (() {
                                if (ygoCard.atk != -1) {
                                  return Text(
                                    "Attack: " + ygoCard.atk.toString(),
                                    style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                } else {
                                  return SizedBox(height: 0);
                                }
                              })(),
                              (() {
                                if (ygoCard.def != -1) {
                                  return Text(
                                    "Defense: " + ygoCard.def.toString(),
                                    style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                } else {
                                  return SizedBox(height: 0);
                                }
                              })(),
                              Text(
                                "Archetype: " + ygoCard.archetype,
                                style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Description: ",
                                style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "" + ygoCard.desc,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
          }
        });
  }

  void populate() async {
    this.populated = (() async {
      this.ygoCard = (await CardsDatabase.instance.readCard(data['id']))!;
      print('detail read successfuly');
    })();
  }
}
