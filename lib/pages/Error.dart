// error.dart
import 'package:flutter/material.dart';
import '../Error_Handle.dart';

class Error extends StatefulWidget {
  @override
  _ErrorState createState() => _ErrorState();
}


class _ErrorState extends State<Error> {
  ErrorOutputHandler errorOutputHandler = ErrorOutputHandler();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Error Page"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Error: ${errorOutputHandler.error}"),
          Text("Output: ${errorOutputHandler.output}"),
        ],
      ),
    );
  }
}
