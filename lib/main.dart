import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thomas/src/clasesObjetos/scriptsProvider.dart';
import 'package:thomas/src/rutas/rutas.dart';
import 'package:thomas/src/widgets/carga.dart';
import 'src/clasesObjetos/clases.dart';
import 'src/pages/panelCentral.dart';

import 'src/pages/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays(
      [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future _obtenerLista(context) async {
    List<Script> objetos = [];

    final instanciaLista = Provider.of<ScriptsProvider>(context);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (instanciaLista.tamanioLista == 0) {
      print("aqui");
      var lista = preferences.getString("lista");

      var cambioJson = jsonDecode(lista!);
      for (var i in cambioJson) {
        Script objt = Script(i['nombre'], i['secuencia'], i['tiempo']);
        objetos.add(objt);
      }
      // print(cambioJson);
      setState(() {
        instanciaLista.myListaScripts = objetos;
        instanciaLista.myListaScriptsA = cambioJson;
      });
    }
    print(instanciaLista.myListaScriptsA);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ScriptsProvider(),
      child: FutureBuilder(
        future: Init.instance.initialize(),
        builder: (context, AsyncSnapshot snapshot) {
          // Show splash screen while waiting for app resources to load:
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
                debugShowCheckedModeBanner: false, home: Splash());
          } else {
            // Loading is done, return the app:
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Thomas',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              initialRoute: '/',
              routes: getApplicationRoutes(),
              home: FutureBuilder(
                future: _obtenerLista(context),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return MyHomePage(title: 'Thomas Scripts');
                  } else {
                    return MyHomePage(title: 'Thomas Scripts');
                  }
                },
              ),
            );
          }
        },
      ),
    );
  }
}

class Init {
  Init._();
  static final instance = Init._();

  Future initialize() async {
    await Future.delayed(Duration(seconds: 3));
  }
}
