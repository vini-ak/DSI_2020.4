import 'dart:async';
import 'pessoa.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Professor {
  String codigoProfessor, disciplinas, id;
  Pessoa pessoa;

  Professor({this.codigoProfessor, this.disciplinas, this.id, this.pessoa});

  Professor.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      codigoProfessor = json["codigoProfessor"];
      disciplinas = json["disciplinas"];
    }
  }

  Map<String, dynamic> toJson() => {
        'codigoProfessor': codigoProfessor,
        'disciplinas': disciplinas,
      };
}

ProfessorController professorController = ProfessorController();

class ProfessorController {
  CollectionReference professores;

  ProfessorController() {
    professores = FirebaseFirestore.instance.collection("professores");
  }

  DocumentReference getRef(String id) {
    return professores.doc(id);
  }

  Future<Professor> fromJson(DocumentSnapshot snapshot) async {
    Map<String, dynamic> data = snapshot.data();
    Professor professor = Professor.fromJson(data);
    professor.id = snapshot.id;

    DocumentReference reference = data["pessoa"];
    professor.pessoa = pessoaController.fromJson(await reference.get());

    return professor;
  }

  Map<String, dynamic> toJson(Professor professor) {
    DocumentReference reference = pessoaController.getRef(professor.pessoa.id);
    return professor.toJson()..putIfAbsent('pessoa', () => reference);
  }

  Future<List<Future<Professor>>> getAll() async {
    QuerySnapshot document = await professores.get();
    List<Future<Professor>> result =
        document.docs.map((e) => this.fromJson(e)).toList();
    return result;
  }

  Future<Professor> getById(String id) async {
    DocumentSnapshot documentSnapshot = await professores.doc(id).get();
    return fromJson(documentSnapshot);
  }

  // IMPLEMENTAR A REMOÇÃO E UPDATE
}
