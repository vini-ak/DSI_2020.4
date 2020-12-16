import 'package:flutter/material.dart';
import './constants.dart';

class CadastroPessoa extends StatefulWidget {
  @override
  _CadastroPessoaState createState() => _CadastroPessoaState();
}

class _CadastroPessoaState extends State<CadastroPessoa> {
  final _formState = GlobalKey<FormState>();
  String _ufEscolhida;

  final _ufs =  [
      'AC',
      'AL',
      'AP',
      'AM',
      'BA',
      'CE',
      'DF',
      'ES',
      'GO',
      'MA',
      'MT',
      'MS',
      'MG',
      'PA',
      'PB',
      'PR',
      'PE',
      'PI',
      'RJ',
      'RN',
      'RS',
      'RO',
      'RR',
      'SC',
      'SP',
      'SE',
      'TO',
    ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ufEscolhida = _ufs[0];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(
      title:  Text("Cadastro"),
      backgroundColor: Constants.colorGreenBSI1,
    );
  }

  String _isValidField(String fieldValue) {
    var response = fieldValue.isEmpty ? "Essa informação é obrigatória" : null;
    return response;
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Container(
        padding: Constants.insetsMedium,
        child: Form(
          key: this._formState,
          child: Column(children: [
            Text(
                  "Cadastre uma nova pessoa",
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
                    "Forneça as informações abaixo para efetuar o cadastro das pessoas.",
                    style: TextStyle(fontSize: 16.0, color: Colors.black54),
                  ),
                ),
                TextFormField(decoration: InputDecoration(labelText: "CPF *", helperText: "Insira apenas os dígitos do seu CPF, sem traços ou pontos.", helperMaxLines: 10, helperStyle: TextStyle(fontSize: 14)), validator: (value) => this._isValidField(value)),
                Constants.boxMediumHeight,
                TextFormField(decoration: InputDecoration(labelText: "Nome *",), validator: (value) => this._isValidField(value),),
                Constants.boxMediumHeight,
                Constants.boxMediumHeight,
                Container(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("Endereço", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                  Padding(
                  padding: const EdgeInsets.only(
                    top: Constants.spaceSmall,
                    bottom: 1.5  * Constants.spaceMedium,
                  ),
                  child: Text(
                    "Insira as informações referentes à moradia desta pessoa.",
                    style: TextStyle(fontSize: 14.0, color: Colors.black54),
                  ),
                ),
                  Constants.boxSmallHeight,
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Expanded(child: TextFormField(decoration: InputDecoration(labelText: "Número *"),  validator: (value) => this._isValidField(value)),), 
                    Constants.boxMediumWidth,
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Estado", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                          Constants.boxSmallHeight,
                          Container(
                            decoration: ShapeDecoration(
                              color: Colors.grey[100],
                              shape: RoundedRectangleBorder(borderRadius: Constants.defaultBorderRadius, side: BorderSide(width: 1, color: Colors.grey))
                            ),
                            child: DropdownButton(
                              value: _ufEscolhida,
                              isExpanded: true,
                              isDense: true,
                              items: this._ufs.map(
                                (e) => DropdownMenuItem(child: Center(child: Text(e)), value: e,)).toList(), 
                                onChanged: (newUF) {
                                  setState(() {
                                    _ufEscolhida = newUF;
                                  });
                                }, 
                            ),
                          ),
                        ],
                      ), 
                  ),],),
                  Constants.boxSmallHeight,
                  TextFormField(decoration: InputDecoration(labelText: "CEP *"),  validator: (value) => this._isValidField(value)),
                  Constants.boxSmallHeight,
                  TextFormField(decoration: InputDecoration(labelText: "Cidade"),),
                  Constants.boxSmallHeight,
                  TextFormField(decoration: InputDecoration(labelText: "Bairro"),),

      ],),
                  padding: Constants.insetsMedium,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Constants.boxMediumHeight,
                SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  onPressed: this._finalizarCadastro,
                  child: Text("CADASTRAR"),
                ),
              )
          ]),
        ),
      ),
    );
  }

  _finalizarCadastro() {
    if (!_formState.currentState.validate()) return;
    Navigator.pop(context);
  }
}