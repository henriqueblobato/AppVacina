import 'package:flutter/material.dart';

// https://image.flaticon.com/icons/png/128/101/101960.png

void main() {
  runApp(run());
}

// hot reload
MaterialApp run() {
  return MaterialApp(
  home: Scaffold(
    body: ListaVacinas(),
  )
);
}

class ListaVacinas extends StatefulWidget {
    
  final List<Vacina> _listaVacinas = List();
  // _listaVacinas.add(Vacina('HepatiteB', 'Primeira dose'));
  // _listaVacinas.add(Vacina('HepatiteB', 'Primeira dose'));
  // _listaVacinas.add(Vacina('Hepatite B', 'Segunda dose'));
  // _listaVacinas.add(Vacina('Febre Amarela', 'Primeira dose'));
  // _listaVacinas.add(Vacina('Pneumococo', 'Dose única'));

  State<StatefulWidget> createState() {
    return ListVacinasState();
  }
}

class ListVacinasState extends State<ListaVacinas> {
  
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: Text('App Vacina'),
          ),
          body: ListView.builder(
            itemCount: widget._listaVacinas.length,
            itemBuilder: (context, indice){
              final vacina = widget._listaVacinas[indice];
              return ItemVacina(vacina);
            },
          ),
            
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          final Future<Vacina> future = Navigator.push(context, MaterialPageRoute(builder: (context){
            return FormularioCriacaoVacina();
          }));
          future.then((vacinaRecebida){
            setState(() {
                widget._listaVacinas.add(vacinaRecebida);
                });
          });
        },
      ),
    );
  }

}

class ItemVacina extends StatelessWidget {
  final Vacina _vacina;
  ItemVacina(this._vacina);
  Widget build(BuildContext context) {
    return Card(
          child: ListTile(
            leading: Icon(Icons.check_circle),
            title: Text(this._vacina.nome.toString()),
            subtitle: Text(this._vacina.descricao.toString()),
          ),
        );
  }

}

class Vacina {
  final String nome;
  final String descricao;
  
  Vacina(this.nome, this.descricao);

  String toString(){
    return 'Vacina{nome: $nome, descricao: $descricao}';
  }
}

class FormularioCriacaoVacina extends StatelessWidget {
  
  final TextEditingController _controllerCampoVacinaNome = TextEditingController();
  final TextEditingController _controllerCampoVacinaDescricao = TextEditingController();
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Criação de vacina'),),
      body: Column(
        children: [
          Editor(_controllerCampoVacinaNome, 'Nome', 'Nome da vacina', Icons.colorize),
          Editor(_controllerCampoVacinaDescricao, 'Descrição', 'Descrição das doses', Icons.mode_comment),
          RaisedButton(
            onPressed: (){
              criaVacina(context);
            },
            child: Text('Cadastrar'),
          ),
        ],
      ),
    );
  }

  void criaVacina(BuildContext context) {
    final String nomeVacina = _controllerCampoVacinaNome.text;
    final String descricaoVacina = _controllerCampoVacinaDescricao.text;
    if(nomeVacina != "" && descricaoVacina != ""){
      final t = Vacina(nomeVacina, descricaoVacina);
      // debugPrint('$t');
      Navigator.pop(context, t);
    }
  }

}

class Editor extends StatelessWidget {

  final TextEditingController _controlador;
  final String _rotulo;
  final String _dica;
  final IconData _icone;

  Editor(this._controlador, this._rotulo, this._dica, this._icone);
  
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.all(24.0),
            child: TextField(
              controller: _controlador,
              style: TextStyle(
                fontSize: 24.0,
                
              ),
              decoration: InputDecoration(
                icon: Icon(_icone),
                labelText: _rotulo,
                hintText: _dica,
              ),
              keyboardType: TextInputType.text,
            ),
          );
  }

}