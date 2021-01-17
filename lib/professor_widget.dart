import 'package:dsi_app/infra.dart';
import 'package:dsi_app/professor.dart';
import 'package:flutter/material.dart';
import 'package:dsi_app/pessoa.dart';
import 'package:dsi_app/pessoa_widgets.dart';
import 'package:dsi_app/dsi_widgets.dart';
import 'package:dsi_app/constants.dart';

class ListProfessorPage extends StatefulWidget {
  @override
  DsiListPageState<Professor, ListProfessorPage> createState() =>
      DsiListPageState<Professor, ListProfessorPage>(
        title: 'Lista de Professores',
        listDataBuilder: () => professorController.getAll(),
        remover: (context, professor) => professorController.remove(professor),
        builder: (context, object) {
          return DsiFutureBuilder(
            key: UniqueKey(),
            target: object,
            builder: (context, professor) {
              String title =
                  professor == null ? "<Sem nome>" : professor.pessoa.nome;
              String subtitle = professor == null ? "-" : professor.disciplinas;
              // print(title + "" + subtitle);
              return ListTile(
                  title: Text(title),
                  subtitle: Text(subtitle),
                  onTap: () => dsiHelper.go(context, '/maintain_professor',
                      arguments: professor));
            },
          );
        },
        floatingActionButtonBuilder: (context) => FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => dsiHelper.go(context, '/maintain_professor'),
        ),
      );
}

class MaintainProfessorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Professor professor = dsiHelper.getRouteArgs(context);

    if (professor == null) {
      professor = Professor();
      professor.pessoa = Pessoa();
    }

    return DsiBasicFormPage(
      title: 'Professor',
      onSave: (context) {
        professorController
            .save(professor)
            .then((value) => dsiHelper.go(context, '/list_professor'));
      },
      body: Wrap(
        runSpacing: Constants.boxSmallHeight.height,
        children: [
          MaintainPessoaBody(professor.pessoa),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: "Código Professor*"),
            initialValue: professor.codigoProfessor,
            onSaved: (newValue) => professor.codigoProfessor = newValue,
            validator: (value) =>
                value.isEmpty ? 'Insira um código válido.' : null,
          ),
          Constants.boxMediumHeight,
          TextFormField(
            maxLines: 4,
            keyboardType: TextInputType.text,
            onSaved: (newValue) => professor.disciplinas = newValue,
            initialValue: professor.disciplinas,
            decoration: InputDecoration(
                labelText: "Disciplinas",
                hintText:
                    "Insira todas as disciplinas que o professor leciona separadas por vírgula."),
          ),
        ],
      ),
    );
  }
}
