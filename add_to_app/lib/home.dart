import 'package:flutter/material.dart';

// Buttons
import './buttons/zerarCounterButton.dart';
import './buttons/nextScreenButton.dart';

class Home extends StatefulWidget {
  final String title;
  const Home({Key key, this.title}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _pontuacao;

  @override
  void initState() {
    super.initState();
    _pontuacao = 0;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black, title: Text(widget.title),),
      floatingActionButton: FloatingActionButton(onPressed: _increasePontuacao, backgroundColor: Colors.grey, child: Icon(Icons.add),),
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(text: TextSpan(children: [
                TextSpan(text: "O valor atual do contador é:\n"),
                TextSpan(text: "$_pontuacao", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold))
              ], style: TextStyle(color: Colors.black)), textAlign: TextAlign.center,),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              ZerarCounterButton(zerarCounter: _zerarContador),
              NextScreenButton(),
            ],),
          ),
        ],
      )
      ),
    );
  }

  _increasePontuacao() {
    // Função que incrementa o valor do contador.
    setState(() {
      _pontuacao++;
    });
  }

  _zerarContador() {
    setState(() {
      _pontuacao = 0;
    });
  }

}