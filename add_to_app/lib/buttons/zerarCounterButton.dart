import 'package:flutter/material.dart';

class ZerarCounterButton extends StatelessWidget {
  final Function zerarCounter;
  const ZerarCounterButton({Key key, this.zerarCounter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 3),
      ),
      width: MediaQuery.of(context).size.width * 0.3,
      height: 30,
      
      child: FlatButton(onPressed: this.zerarCounter, child: Text("Zerar"),),
    );
  }
}