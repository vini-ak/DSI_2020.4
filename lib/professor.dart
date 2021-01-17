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
    professores = FirebaseFirestore.instance.collection('professores');
  }

  DocumentReference getRef(String id) {
    return professores.doc(id);
  }

  FutureOr<Professor> fromJson(DocumentSnapshot snapshot) async {
    Map<String, dynamic> data = snapshot.data();
    Professor professor = Professor.fromJson(data);
    professor.id = snapshot.id;
    DocumentReference reference = data["pessoa"];
    professor.pessoa = pessoaController.fromJson(await reference.get());
    // professor.codigoProfessor = data["codigoProfessor"];
    // professor.disciplinas = data["disciplinas"];
    return professor;
  }

  Map<String, dynamic> toJson(Professor professor) {
    DocumentReference reference = pessoaController.getRef(professor.pessoa.id);
    print("Referência para a pessoa" + reference.toString());
    return professor.toJson()..putIfAbsent('pessoa', () => reference);
  }

  FutureOr<List<FutureOr<Professor>>> getAll() async {
    QuerySnapshot documents = await professores.get();
    FutureOr<List<FutureOr<Professor>>> result =
        documents.docs.map(fromJson).toList();
    return result;
  }

  Future<Professor> getById(String id) async {
    DocumentSnapshot documentSnapshot = await professores.doc(id).get();
    return fromJson(documentSnapshot);
  }

  Future<void> remove(FutureOr<Professor> professor) async {
    Professor p = await professor;
    Future<void> result = professores
        .doc(p.id)
        .delete()
        .then((value) => pessoaController.remove(p.pessoa));
    return result;
  }

  Future<Professor> save(FutureOr<Professor> professor) async {
    Professor p = await professor;

    p.pessoa = await pessoaController.save(p.pessoa);
    Map<String, dynamic> data = toJson(p);

    if (p.id == null) {
      DocumentReference reference = await professores.add(data);
      return fromJson(await reference.get());
    } else {
      professores.doc(p.id).update(data);
      return p;
    }
  }
}
