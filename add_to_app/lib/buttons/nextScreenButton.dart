import 'package:flutter/material.dart';

class NextScreenButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      height: 30,
      child: RaisedButton(onPressed: () {}, child: Text("Próxima"), color: Colors.black26,),
    );
  }
}