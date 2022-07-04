import 'package:flutter/material.dart';
import 'package:ygo_card_library/model/ygo_card.dart';
import 'package:ygo_card_library/db/CardsDatabase.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<void> populated;
  late List<YGOCard> ygoCards;

  String searchFieldString = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.populate();
  }

  @override
  Widget build(BuildContext context) {
    var futures = <Future<dynamic>>[];
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
                  'Yu-Gi-Oh Card Library',
                  style: TextStyle(
                    fontSize: 35.0
                  ),
                ),
                centerTitle: true,
                backgroundColor: Colors.grey[800],
              ),
              body: Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
                      child: TextField(
                        onSubmitted: (text) {
                          print("text on search field is $text");
                          this.populate(text);
                        },
                        style: TextStyle(
                          fontSize: 20.0
                        ),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Search card by name..."),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 200.0,
                        child: ListView.builder(
                          itemCount: ygoCards.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                onTap: () {
                                  Navigator.pushNamed(context, '/detail',
                                      arguments: {'id': ygoCards[index].id});
                                  // Navigator.pushNamed(context, '/detail');
                                },
                                title: Text(
                                  ygoCards[index].name,
                                  style: TextStyle(
                                    fontSize: 25.0,
                                      
                                  ),
                                ),
                                leading: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Image.asset(
                                      'assets/images/card_small_bg.jpg'),
                                ),
                                tileColor: YGOCard.getColor(ygoCards[index].type),
                                
                                // tileColor: Colors.green,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }

  void populate([String name = ""]) async {
    if (name == "") {
      this.populated = (() async {
        this.ygoCards = await CardsDatabase.instance.readAllCard();
        print('ygoCards count = ${ygoCards.length}');
      })();

      setState(() {});

    } else {
      this.populated = (() async {
        this.ygoCards = await CardsDatabase.instance.readCardWithFuzzyName(name);
        print('ygoCards fuzzy count = ${ygoCards.length}');
      })();

      setState(() {});
    }
  }
}
