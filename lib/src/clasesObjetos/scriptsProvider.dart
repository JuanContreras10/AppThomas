//import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class ScriptsProvider with ChangeNotifier {
  List _listaScripts = [];
  List _listaScriptsActual = [];

/* List get myListaScripts {
    return _listaScripts;
  }*/
  List get myListaScripts => _listaScripts;

  set myListaScripts(List nuevaLista) {
    this._listaScripts = nuevaLista;

    notifyListeners();
  }

  int get tamanioLista => _listaScripts.length;

  List get myListaScriptsA => _listaScriptsActual;

  set myListaScriptsA(List nuevaLista) {
    this._listaScriptsActual = nuevaLista;

    notifyListeners();
  }

  int get tamanioListaA => _listaScriptsActual.length;
}
