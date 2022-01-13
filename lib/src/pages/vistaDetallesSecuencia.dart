import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DetallesSecuencia extends StatefulWidget {
  final String title;
  final String autor;
  final List lista;
  const DetallesSecuencia(
      {Key? key, required this.title, required this.autor, required this.lista})
      : super(key: key);

  @override
  _DetallesSecuenciaState createState() => _DetallesSecuenciaState();
}

class _DetallesSecuenciaState extends State<DetallesSecuencia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Color.fromRGBO(150, 86, 149, 1)),
        bottom: PreferredSize(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromRGBO(94, 45, 79, 1),
              ),
              height: 10.0,
            ),
            preferredSize: Size.fromHeight(4.0)),
        title: Text(widget.title),
        backgroundColor: Color.fromRGBO(46, 14, 54, 1).withOpacity(0.7),
      ),
      backgroundColor: Color.fromRGBO(14, 13, 21, 1),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Autor ${widget.autor}",
                style: TextStyle(color: Colors.white),
              ),
              Text(
                "Numero de cortes ${widget.lista.length}",
                style: TextStyle(color: Colors.white),
              ),
              listaTiempos(widget.lista)
            ],
          ),
        ),
      ),
    );
  }

  Widget listaTiempos(List lista) {
    return new Row(
      children: <Widget>[
        Expanded(
          child: SizedBox(
            height: double.maxFinite,
            child: ListView.builder(
              // Deja que ListView sepa cuántos elementos necesita para construir
              itemCount: lista.length,
              // Proporciona una función de constructor. ¡Aquí es donde sucede la magia! Vamos a
              // convertir cada elemento en un Widget basado en el tipo de elemento que es.
              itemBuilder: (context, index) {
                final item = lista[index];
                return _buildItem(item, index + 1);
              },
            ),
          ),
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );

    /*
 
     */
  }

  Widget _buildItem(String textTitle, numero) {
    return new ListTile(
      title: new Text("Corte $numero", style: TextStyle(color: Colors.white)),
      subtitle: new Text(textTitle, style: TextStyle(color: Colors.white)),
      leading: new Icon(Icons.map),
    );
  }
}
