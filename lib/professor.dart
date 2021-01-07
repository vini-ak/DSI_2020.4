import 'package:dsi_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:dsi_app/pessoa.dart';
import 'package:dsi_app/dsi_widgets.dart';
import 'package:dsi_app/infra.dart';
import 'package:flutter/services.dart';

class Professor extends Pessoa {
  String disciplina, codigoProfessor, email;
  Professor(
      {cpf, nome, endereco, this.disciplina, this.codigoProfessor, this.email})
      : super(cpf: cpf, nome: nome, endereco: endereco);
}

ProfessorController professorController = ProfessorController();

class ProfessorController {
  List<Professor> getAll() {
    return pessoaController.getAll().whereType<Professor>().toList();
  }

  Professor save(professor) {
    return pessoaController.save(professor);
  }

  bool remove(professor) {
    return pessoaController.remove(professor);
  }
}

class ListProfessorPage extends StatefulWidget {
  @override
  _ListProfessorPageState createState() => _ListProfessorPageState();
}

class _ListProfessorPageState extends State<ListProfessorPage> {
  var _listProfessor = professorController.getAll();

  @override
  void setState(fn) {
    super.setState(fn);
    _listProfessor = professorController.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return DsiScaffold(
        title: "Listagem de Professores",
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => dsiHelper.go(context, '/maintain_professor'),
        ),
        body: ListView.builder(
          shrinkWrap: true,
          itemCount: _listProfessor.length,
          itemBuilder: _buildListTileProfessor,
        ));
  }

  Widget _buildListTileProfessor(context, index) {
    Professor professor = _listProfessor[index];
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        setState(() {
          _listProfessor.remove(professor);
          professorController.remove(professor);
        });
        dsiHelper.showMessage(
            context: context,
            message: "O professor ${professor.nome} foi excluído.");
      },
      child: ListTile(
        title: Text(professor.nome),
        subtitle: Text(professor.codigoProfessor),
        onTap: () =>
            dsiHelper.go(context, "/maintain_professor", arguments: professor),
      ),
    );
  }
}

class MaintainProfessorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Professor professor = dsiHelper.getRouteArgs(context);
    if (professor == null) {
      professor = Professor();
    }
    return DsiBasicFormPage(
        title: "Cadastrar Professor",
        onSave: () {
          professorController.save(professor);
          dsiHelper.go(context, '/list_professor');
        },
        body: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "CPF*"),
              validator: _validateCPF,
              initialValue: professor.cpf,
              onSaved: (newValue) => professor.cpf = newValue,
            ),
            Constants.spaceSmallHeight,
            TextFormField(
              keyboardType: TextInputType.name,
              decoration: InputDecoration(labelText: "Nome*"),
              validator: _validateNome,
              initialValue: professor.nome,
              onSaved: (newValue) => professor.nome = newValue,
            ),
            Constants.spaceSmallHeight,
            TextFormField(
              keyboardType: TextInputType.streetAddress,
              decoration: InputDecoration(labelText: "Endereço*"),
              validator: _validateEndereco,
              initialValue: professor.endereco,
              onSaved: (newValue) => professor.endereco = newValue,
            ),
            Constants.spaceSmallHeight,
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Código professor*"),
              validator: _validateCodigoProfessor,
              initialValue: professor.codigoProfessor,
              onSaved: (newValue) => professor.codigoProfessor = newValue,
            ),
            Constants.spaceSmallHeight,
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(labelText: "Email*"),
              validator: _validateEmail,
              initialValue: professor.email,
              onSaved: (newValue) => professor.email = newValue,
            ),
            Constants.spaceSmallHeight,
            TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              initialValue: professor.disciplina,
              decoration: InputDecoration(
                labelText: "Disciplinas",
                helperMaxLines: 9999,
                helperText:
                    "Insira todas as disciplinas que o professor leciona separadas por vírgula. Ex: Cálculo 1, DSI, Projeto III...",
              ),
            ),
            Constants.spaceSmallHeight,
          ],
        ));
  }

  String _validateCPF(String value) {
    if (value.isEmpty || value.length != 11) {
      return "Informe um CPF Válido";
    }
    return null;
  }

  String _validateNome(String value) {
    return value.isEmpty ? 'Insira um nome válido' : null;
  }

  String _validateEndereco(String value) {
    return value.isEmpty ? 'Insira um endereço válido' : null;
  }

  String _validateCodigoProfessor(String value) {
    return value.isEmpty ? "Código inválido" : null;
  }

  bool _isEmailValid(String email) {
    RegExp reg = new RegExp(r"^[^@]+@[^@]+\.[^@]+$");
    return reg.hasMatch(email);
  }

  String _validateEmail(String value) {
    return value.isEmpty || !_isEmailValid(value)
        ? 'Insira um email válido.'
        : null;
  }
}
