import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:thomas/src/clasesObjetos/scriptsProvider.dart';
import 'package:thomas/src/pages/vistaDetallesSecuencia.dart';
//import 'package:thomas/src/widgets/carga.dart';

FToast fToast = FToast();
List nuevaLista = [];

class MisScripts extends StatefulWidget {
  const MisScripts({Key? key}) : super(key: key);

  @override
  _MisScriptsState createState() => _MisScriptsState();
}

class _MisScriptsState extends State<MisScripts> {
  Widget _listaCarrito(BuildContext context) {
    //TextEditingController cantidadController = TextEditingController();
    final instanciaLista = Provider.of<ScriptsProvider>(context);

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: instanciaLista.tamanioLista,
      itemBuilder: (context, int index) {
        //  print(instanciaLista.myListaScripts[index].secuencia);
        final item = instanciaLista.myListaScripts[index].secuencia;
        //final precio = double.parse(instanciaLista.myList[index].precio);
        final items = instanciaLista.myListaScripts[index];

        return Dismissible(
          background: Container(
            color: Color.fromRGBO(150, 86, 149, 1),
            child: Text(
              "Eliminar",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          onDismissed: (_) {
            // El parámetro no se usa temporalmente, se indica con un guión bajo
            setState(() {
              showToast(
                  context, Icons.delete, Colors.red, "Eliminado del carrito!");
            });
          }, // monitor
          movementDuration: Duration(milliseconds: 100),
          key: Key(item),
          child: Container(
            margin: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              image: DecorationImage(
                image: AssetImage("assets/estudio.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Card(
              color: Colors.transparent,
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.video_camera_back,
                      color: Colors.white,
                    ),
                    title: Text('Secuencia ${items.secuencia}',
                        style: TextStyle(color: Colors.white)),
                    subtitle: Text(
                      'Autor ${items.nombre}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ButtonBar(
                        alignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 200.0,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                color: Color.fromRGBO(46, 14, 54, 1)
                                    .withOpacity(0.7)),
                            child: ElevatedButton(
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Icon(
                                        Icons.open_in_full,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Expanded(
                                        flex: 2, child: Text('Ver detalles')),
                                  ],
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.transparent,
                                onPrimary: Colors.white,
                                shadowColor: Colors.transparent,
                                elevation: 10,
                                minimumSize: Size(100.0, 40.0),
                              ),
                              onPressed: () {
                                print(items.tiempos.length);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetallesSecuencia(
                                            title: items.secuencia,
                                            autor: items.nombre,
                                            lista: items.tiempos)));
                              },
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    final instanciaLista = Provider.of<ScriptsProvider>(context);

    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/fondo.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      alignment: Alignment.topCenter,
      child: instanciaLista.tamanioLista == 0
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Sin scripts", style: TextStyle(color: Colors.white))
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Numero de Scripts ${instanciaLista.tamanioLista}",
                    style: TextStyle(color: Colors.white)),
                Expanded(
                  child: SizedBox(
                    height: double.infinity,
                    child: _listaCarrito(context),
                  ),
                ),
              ],
            ),
    ));
  }

  showToast(BuildContext context, IconData icono, Color color, String text) {
    //print('hola');
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: color,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icono,
            color: Colors.white,
          ),
          SizedBox(
            width: 12.0,
          ),
          Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );

    fToast.showToast(
        child: toast,
        gravity: ToastGravity.BOTTOM_LEFT,
        toastDuration: Duration(seconds: 2),
        positionedToastBuilder: (context, child) {
          return Positioned(
            child: child,
            bottom: 100.0,
            left: 125.0,
          );
        });

    // Custom Toast Position
    /* fToast.showToast(
        child: toast,
        toastDuration: Duration(seconds: 2),
        positionedToastBuilder: (context, child) {
          return Positioned(
            child: child,
            top: 16.0,
            left: 16.0,
          );
        });*/
  }
}
