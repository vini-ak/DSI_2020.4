import 'package:flutter/material.dart';
import 'package:dsi_app/pessoa.dart';

class Professor extends Pessoa {
  String disciplina, codigoProfessor;
  Professor({cpf, nome, endereco, this.disciplina, this.codigoProfessor})
      : super(cpf: cpf, nome: nome, endereco: endereco);
}

class ListProfessorPage extends StatefulWidget {
  @override
  _ListProfessorPageState createState() => _ListProfessorPageState();
}

class _ListProfessorPageState extends State<ListProfessorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

class MaintainProfessorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
