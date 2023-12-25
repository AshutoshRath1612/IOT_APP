import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:ssh2/ssh2.dart';
import 'dart:async';
import 'Error_Handle.dart';

String hostip = '';
String previousip = '';
String _baseUrl =
    'http://$hostip:5000'; // Replace with your Raspberry Pi IP and server port
double currentspeed = 0;
String previousD = '';
int status = 0;

SSHClient pi =
    new SSHClient(host: '', port: 0, username: '', passwordOrKey: '');
final Completer<void> completer = Completer<void>();
void startpi() {
  pi = new SSHClient(
      host: hostip, port: 22, username: 'doomrpi4', passwordOrKey: 'raspberry');
}

void changeServerStatus(int value) {
  status = value;
}

int setValues(double speed, String hostipp) {
  hostip = hostipp;
  currentspeed = speed;
  return 1;
}

void sendCommands(String direction) async {
  if (previousD != direction) {
    previousD = direction;
    final response = await http.get(
        Uri.parse('$_baseUrl/control?command=$direction&speed=$currentspeed'));
    print(response.body);
    if (response.statusCode == 200) {
      print('Command sent: $direction');
    } else {
      print('Failed to send command: $direction');
    }
  }
}

String? result;
Future<void> runServer(double speed, String hostipp) async {
  int success = await setValues(speed, hostipp);
  if (success == 1) {
    try {
      print('SS : $speed , HP : $hostipp');
      startpi();
      result = await pi.connect();
      if (result == "session_connected") {
        print('run');
        changeServerStatus(1);
        result = await pi.execute("python Documents/server.py");
        print(result);
      } else {
        print('Not Connected');
      }
    } on TimeoutException catch (timeoutException) {
      // Handle timeout exception
      changeServerStatus(404);
      ErrorOutputHandler().updateOutput('Timeout Error: ${timeoutException.message}');
      print('Timeout Error: ${timeoutException.message}');
    } on PlatformException catch (e) {
      changeServerStatus(404);
      ErrorOutputHandler().updateOutput('Error: ${e.code}\nError Message: ${e.message}');
      print('Error: ${e.code}\nError Message: ${e.message}');
    }
  }
}

Future<void> stopServer() async {
  changeServerStatus(0);
  try {
    await pi.disconnect();
    print('Server Stopped');
  } on PlatformException catch (e) {
    print('Error: ${e.code}\nError Message: ${e.message}');
  }
}

void printValues(double speed, String hostip) {
  print("$speed , $hostip");
}
