import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:thomas/src/clasesObjetos/clases.dart';
import 'package:thomas/src/clasesObjetos/scriptsProvider.dart';

FToast fToast = FToast();

final _formKey = GlobalKey<FormState>();
//final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

TextEditingController nombre = new TextEditingController();

TextEditingController secuencia = new TextEditingController();

class CountUpTimerPage extends StatefulWidget {
  const CountUpTimerPage({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<CountUpTimerPage> {
  List _tiempos = [];
  final _isHours = true;

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,

    //onChange: (value) =>
    //    print('onChange ${StopWatchTimer.getDisplayTime(value)}'),
    //  onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
    //onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
  );

  final _scrollController = ScrollController();

  guardarLista(lista) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("lista", lista);
    preferences.setString("texto", "cambio");

    print("lista guardada:" + lista);
  }

  void reinicoDatos() {
    setState(() {
      //  _tiempos.clear();
      nombre.text = "";
      secuencia.text = "";
    });
  }

  @override
  void initState() {
    super.initState();
    /*
    _stopWatchTimer.rawTime.listen((value) =>
        print('rawTime $value ${StopWatchTimer.getDisplayTime(value)}'));
    _stopWatchTimer.minuteTime.listen((value) => print('minuteTime $value'));
    _stopWatchTimer.secondTime.listen((value) => print('secondTime $value'));
    _stopWatchTimer.records.listen((value) => print('records $value'));
*/
    /// Can be set preset time. This case is "00:01.23".
    // _stopWatchTimer.setPresetTime(mSec: 1234);
    fToast = FToast();
    fToast.init(context);
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _form(),

          /// Display coronometro
          Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: StreamBuilder<int>(
              stream: _stopWatchTimer.rawTime,
              initialData: _stopWatchTimer.rawTime.value,
              builder: (context, snap) {
                final value = snap.data!;
                final displayTime =
                    StopWatchTimer.getDisplayTime(value, hours: _isHours);
                return Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        displayTime,
                        style: const TextStyle(
                            fontSize: 40,
                            fontFamily: 'Helvetica',
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    /* Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        value.toString(),
                        style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Helvetica',
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    ),
                  
                  */
                  ],
                );
              },
            ),
          ),

          /// Display  minute.
          /*    Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: StreamBuilder<int>(
              stream: _stopWatchTimer.minuteTime,
              initialData: _stopWatchTimer.minuteTime.value,
              builder: (context, snap) {
                final value = snap.data;
                print('Listen every minute. $value');
                return Column(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              child: Text(
                                'minute',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: 'Helvetica',
                                    color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Text(
                                value.toString(),
                                style: const TextStyle(
                                    fontSize: 30,
                                    fontFamily: 'Helvetica',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        )),
                  ],
                );
              },
            ),
          ),

          /// Display every second.
          Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: StreamBuilder<int>(
              stream: _stopWatchTimer.secondTime,
              initialData: _stopWatchTimer.secondTime.value,
              builder: (context, snap) {
                final value = snap.data;
                print('Listen every second. $value');
                return Column(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              child: Text(
                                'second',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: 'Helvetica',
                                    color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Text(
                                value.toString(),
                                style: const TextStyle(
                                    fontSize: 30,
                                    fontFamily: 'Helvetica',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        )),
                  ],
                );
              },
            ),
          ),
*/

          Padding(
            padding: const EdgeInsets.all(2),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: RaisedButton(
                          padding: const EdgeInsets.all(4),
                          color: Colors.lightBlue,
                          shape: const StadiumBorder(),
                          onPressed: () async {
                            _stopWatchTimer.onExecute
                                .add(StopWatchExecute.start);
                          },
                          child: const Text(
                            'Inicio',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: RaisedButton(
                          padding: const EdgeInsets.all(4),
                          color: Colors.green,
                          shape: const StadiumBorder(),
                          onPressed: () async {
                            _stopWatchTimer.onExecute
                                .add(StopWatchExecute.stop);
                          },
                          child: const Text(
                            'Stop',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: RaisedButton(
                          padding: const EdgeInsets.all(4),
                          color: Colors.red,
                          shape: const StadiumBorder(),
                          onPressed: () async {
                            _stopWatchTimer.onExecute
                                .add(StopWatchExecute.reset);
                          },
                          child: const Text(
                            'Reiniciar',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(0).copyWith(right: 8),
                        child: RaisedButton(
                          padding: const EdgeInsets.all(4),
                          color: Colors.purple,
                          shape: const StadiumBorder(),
                          onPressed: () async {
                            _stopWatchTimer.onExecute.add(StopWatchExecute.lap);
                          },
                          child: const Text(
                            'Claqueta',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0).copyWith(right: 8),
                        child: RaisedButton(
                          padding: const EdgeInsets.all(4),
                          color: Colors.deepPurpleAccent,
                          shape: const StadiumBorder(),
                          onPressed: () async {
                            _stopWatchTimer.onExecute.add(StopWatchExecute.lap);
                          },
                          child: const Text(
                            'corte',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0).copyWith(right: 8),
                        child: RaisedButton(
                          padding: const EdgeInsets.all(4),
                          color: Colors.red,
                          shape: const StadiumBorder(),
                          onPressed: () async {
                            _stopWatchTimer.onExecute.add(StopWatchExecute.lap);

                            for (var i = 0;
                                i <
                                    _stopWatchTimer.records.value
                                        .toList()
                                        .length;
                                i++) {
                              String tiempo = _stopWatchTimer
                                  .records.value[i].displayTime
                                  .toString();
                              setState(() {
                                _tiempos.add(tiempo);
                              });

                              //print("numero ${_tiempos.length}");
                              //print(_stopWatchTimer.records.value[i].displayTime);
                            }
                            _stopWatchTimer.onExecute
                                .add(StopWatchExecute.stop);
                            _stopWatchTimer.onExecute
                                .add(StopWatchExecute.reset);
                          },
                          child: const Text(
                            'terminar',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /*     Padding(
                  padding: const EdgeInsets.all(0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: RaisedButton(
                          padding: const EdgeInsets.all(4),
                          color: Colors.pinkAccent,
                          shape: const StadiumBorder(),
                          onPressed: () async {
                            _stopWatchTimer.setPresetHoursTime(1);
                          },
                          child: const Text(
                            'Set Hours',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: RaisedButton(
                          padding: const EdgeInsets.all(4),
                          color: Colors.pinkAccent,
                          shape: const StadiumBorder(),
                          onPressed: () async {
                            _stopWatchTimer.setPresetMinuteTime(59);
                          },
                          child: const Text(
                            'Set Minute',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: RaisedButton(
                          padding: const EdgeInsets.all(4),
                          color: Colors.pinkAccent,
                          shape: const StadiumBorder(),
                          onPressed: () async {
                            _stopWatchTimer.setPresetSecondTime(10);
                          },
                          child: const Text(
                            'Set Second',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: RaisedButton(
                    padding: const EdgeInsets.all(4),
                    color: Colors.pinkAccent,
                    shape: const StadiumBorder(),
                    onPressed: () async {
                      _stopWatchTimer.setPresetTime(mSec: 3599 * 1000);
                    },
                    child: const Text(
                      'Set PresetTime',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.pinkAccent,
                      onPrimary: Colors.white,
                      shape: const StadiumBorder(),
                    ),
                    onPressed: () async {
                      _stopWatchTimer.clearPresetTime();
                    },
                    child: const Text(
                      'Clear PresetTime',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
            */
              ],
            ),
          ),
          Container(
            height: 120,
            margin: const EdgeInsets.all(8),
            child: StreamBuilder<List<StopWatchRecord>>(
              stream: _stopWatchTimer.records,
              initialData: _stopWatchTimer.records.value,
              builder: (context, snap) {
                final value = snap.data!;
                if (value.isEmpty) {
                  return Container();
                }
                Future.delayed(const Duration(milliseconds: 100), () {
                  _scrollController.animateTo(
                      _scrollController.position.maxScrollExtent,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeOut);
                });
                //print('Listen records. $value');
                return ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    final data = value[index];
                    // print('${data.displayTime}');
                    return Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            '${index + 1}:  ${data.displayTime}',
                            style: const TextStyle(
                                fontSize: 17,
                                fontFamily: 'Helvetica',
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        const Divider(
                          height: 1,
                        )
                      ],
                    );
                  },
                  itemCount: value.length,
                );
              },
            ),
          ),

          _nuevoScript(context),
          SafeArea(
            child: Container(
              height: 5.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _form() {
    return Container(
        child: Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SafeArea(
              child: Container(
                height: 5.0,
              ),
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return '';
                }
              },
              textInputAction: TextInputAction.done,
              controller: nombre,
              obscureText: false,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      borderSide: BorderSide(color: Colors.white)),
                  labelStyle: TextStyle(color: Colors.white),
                  labelText: 'Nombre'),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return '';
                }
              },
              textInputAction: TextInputAction.done,
              //keyboardType: TextInputType.phone,
              controller: secuencia,
              obscureText: false,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.video_camera_front,
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      borderSide: BorderSide(color: Colors.white)),
                  labelStyle: TextStyle(color: Colors.white),
                  labelText: 'Secuencia'),
            ),
          ],
        ),
      ),
    ));
  }

  Widget _nuevoScript(BuildContext context) {
    final instanciaLista = Provider.of<ScriptsProvider>(context);
    return Container(
      width: 200.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Color.fromRGBO(46, 14, 54, 1)),
      child: ElevatedButton(
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Icon(
                  Icons.save,
                  color: Colors.white,
                ),
              ),
              Expanded(flex: 2, child: Text('Guardar')),
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
          if (_formKey.currentState!.validate()) {
            Script script = Script(nombre.text, secuencia.text, _tiempos);
            var obj = {
              'nombre': nombre.text,
              'secuencia': secuencia.text,
              'tiempo': _tiempos
            };
            // var body = jsonEncode(obj);

            setState(() {
              instanciaLista.myListaScripts.add(script);
              instanciaLista.myListaScriptsA.add(obj);

              List listaActual = instanciaLista.myListaScriptsA;
              var cambioJson = jsonEncode(listaActual);
              //print("actual $cambioJson");
              guardarLista(cambioJson);
            });

            // print("contenido Script ${script.nombre}");

            showToast(context, Icons.check, Color.fromRGBO(150, 86, 149, 1),
                "Registrado");
            reinicoDatos();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.red,
                content: Text('Error faltan datos!',
                    style: TextStyle(color: Colors.white)),
              ),
            );
          }
        },
      ),
    );
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
