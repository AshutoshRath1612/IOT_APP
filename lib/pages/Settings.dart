import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:rcapp/Servers.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Map data = {};
  double currentspeed = 0;
  @override
  Widget build(BuildContext context) {
    data=ModalRoute.of(context)!.settings.arguments as Map;
    double defaultspeed = data['currentspeed'];
    String currentip = data['hostip'];
    TextEditingController _textEditingController = TextEditingController(text: currentip);
    var submitData = ()async{
      previousip = hostip;
      if(previousip != hostip) {
        await stopServer();
        changeServerStatus(0);
      }
      Navigator.pop(context,
          {
            'currentspeed' : currentspeed != 0 ? currentspeed : defaultspeed,
            'hostip' : currentip
          });
    };
    return Scaffold(
      backgroundColor: Color.fromRGBO(10, 20, 30, 1),
      body: Container(
          width: 500,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 70, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'IP address',
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: 25,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 220,
                      height: 60,
                      child: TextField(
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white70),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                              width: 2.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.green,
                              width: 2.0,
                            ),
                          ),
                          hintText: 'IP Address of the Host',
                          hintStyle: TextStyle(
                            fontFamily: 'Roboto',
                            color: Colors.grey,
                          ),
                        ),
                        controller: _textEditingController,
                        onChanged: (String value) {
                          // This callback is triggered whenever the text in the TextField changes
                          currentip = _textEditingController.text;
                          print('Current Text: $value');
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  'Speed',
                  style: TextStyle(
                      fontSize: 50,
                      fontFamily: 'Prompt',
                      color: Colors.white70),
                ),
                Stack(
                children:[
                Slider(
                  value: currentspeed==0 ? defaultspeed : currentspeed,
                  max: 100,
                  divisions: 10,
                  label: currentspeed==0 ? defaultspeed.round().toString() : currentspeed.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      currentspeed = value;
                    });
                  },
                ),
                Positioned(
                  top: 10,
                  left: (currentspeed == 0 ? defaultspeed : currentspeed )/ 100 * 300 + 15,
                  child: Container(
                    width: 25.0,
                    height: 25.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue, // Customize the color of the text view thumb
                    ),
                    child: Center(
                      child: Text(
                        (currentspeed == 0 ? defaultspeed : currentspeed ).toInt().toString(),
                        style: TextStyle(
                          color: Colors.white, // Customize the color of the text
                        ),
                      ),
                    ),
                  ),
                ),
                ]),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 200,
                      height: 50,
                      child: (ElevatedButton(
                          onPressed: ()async{submitData();},
                          child: const Text(
                            'Save',
                            style: TextStyle(fontSize: 30,fontFamily: 'Merriweather'),
                          ))),
                    ),

                  ],
                )
              ],
            ),
          )),
    );
  }
}
