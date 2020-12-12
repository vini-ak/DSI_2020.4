import 'package:flutter/material.dart';

class NextScreenButton extends StatelessWidget {
  final Function function;
  const NextScreenButton({Key key, this.function}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      height: 30,
      child: RaisedButton(onPressed: this.function, child: Text("Próxima"), color: Colors.black26,),
    );
  }
}