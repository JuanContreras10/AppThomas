import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:thomas/src/clasesObjetos/scriptsProvider.dart';
import 'package:thomas/src/widgets/count_up_timer_page.dart';

import 'misScripts.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //variables
  bool panelScript = false;
  @override
  Widget build(BuildContext context) {
    final instanciaLista = Provider.of<ScriptsProvider>(context);
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
        backgroundColor: Color.fromRGBO(46, 14, 54, 1),
      ),
      // backgroundColor: Color.fromRGBO(14, 13, 21, 1),

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/fondo2.gif"),
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 15.0),
              _nuevoScript(),
              SizedBox(height: 15.0),
              _panelScript()
            ],
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Stack(children: [
        FloatingActionButton.extended(
          onPressed: () {
            showBarModalBottomSheet(
              expand: true,
              context: context,
              backgroundColor: Colors.transparent,
              builder: (context) => MisScripts(),
            );
          },
          label: const Text('Mis Scripts'),
          icon: const Icon(Icons.file_copy_rounded),
          backgroundColor: Color.fromRGBO(46, 14, 54, 1),
        ),
        instanciaLista.tamanioLista == 0
            ? Container(
                width: 25.0,
                height: 25.0,
                decoration: new BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                ))
            : Container(
                width: 25.0,
                height: 25.0,
                child: Center(
                  child: instanciaLista.tamanioLista > 10
                      ? Icon(Icons.more, color: Colors.white)
                      : Text("${instanciaLista.tamanioLista}",
                          style: TextStyle(color: Colors.white)),
                ),
                decoration: new BoxDecoration(
                  color: Color.fromRGBO(150, 86, 149, 1),
                  shape: BoxShape.circle,
                ),
              )
      ]),
    );
  }

  //witgets
  Widget _nuevoScript() {
    return Container(
      width: 200.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Color.fromRGBO(46, 14, 54, 1)),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            panelScript = !panelScript;
          });
        },
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
              Expanded(flex: 2, child: Text('Nuevo Script')),
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
      ),
    );
  }

  Widget _panelScript() {
    if (panelScript) {
      return Container(
        child: SingleChildScrollView(child: _body()),
        width: 400.0,
        // height: 400.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Colors.black),
      );
    } else {
      return Container();
    }
  }

  Widget _body() {
    return Container(
      child: CountUpTimerPage(),
    );
  }
}
