import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ygo_card_library/db/CardsDatabase.dart';
import 'package:ygo_card_library/model/ygo_card.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String time = "loading...";
  void setupWorldTime() async {
    var db = await CardsDatabase.instance.database;
    setState(() {
      time = "oy oy";
    });
    // print("hello");
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: SpinKitWanderingCubes(
        color: Colors.white,
        size: 50,
      ),
    );
  }
}
