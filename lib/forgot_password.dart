import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './constants.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.colorGreenBSI1,
        title: Text("Esqueci minha senha"),
      ),
      body: ForgotPasswordForm(),
    );
  }
}

class ForgotPasswordForm extends StatefulWidget {
  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formState = GlobalKey<FormState>();

  final _pwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: Constants.insetsMedium,
        child: Form(
          key: _formState,
          child: Column(
            children: [
              Constants.boxMediumHeight,
              Text(
                "Não lembra a sua senha?",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: Constants.spaceSmall,
                  bottom: 1.5 * Constants.spaceMedium,
                ),
                child: Text(
                  "Sem problemas! Vamos facilitar sua vida. Defina uma nova senha para os futuros acessos.",
                  style: TextStyle(fontSize: 16.0, color: Colors.black54),
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: "Email"),
                validator: (value) =>
                    value.isEmpty ? "Informe o seu email" : null,
              ),
              Constants.boxSmallHeight,
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                controller: _pwdController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Nova senha"),
              ),
              Constants.boxSmallHeight,
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration:
                    const InputDecoration(labelText: "Repita a nova senha"),
                validator: (value) {
                  value.isEmpty || (value != _pwdController.text)
                      ? "As senhas precisam ser iguais"
                      : null;
                },
              ),
              Constants.boxMediumHeight,
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  onPressed: _alterarSenha,
                  child: Text("MUDAR SENHA"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _alterarSenha() {
    if (!_formState.currentState.validate()) return;
    Navigator.pop(context);
  }
}
