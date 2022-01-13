import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backwardsCompatibility: false,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Color.fromRGBO(14, 13, 21, 1)),
        backgroundColor: Colors.black,
        title: Text(
          'Thomas Scripts',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Image.asset('assets/icono.png'),
      ),
    );
  }
}
