import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double leftMargin = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(4, 8, 9, 1),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('RPiRC Car' , style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(74, 77, 172, 0.5),
              fontFamily: 'Prompt',
              shadows: [
                Shadow(
                  color: Colors.blue,
                  offset: Offset(1, 1)
                )
              ]
            ),),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Control your Raspberry Pi at your Fingertips.', style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Oxygen',
                  color: Color.fromRGBO(255, 255, 255, 0.5),
                ),),
              ],
            ),
            SizedBox(height: 150,),
            Container(
              child: Image.asset('assets/images/carF.png',height: 100,fit: BoxFit.cover ,),
            ),
            SizedBox(height: 100,),
            ElevatedButton(onPressed: () async{
              dynamic mainpage = await Navigator.pushNamed(context, '/mainpage',arguments: {});
            },
                style: ElevatedButton.styleFrom(
              shadowColor: Color.fromRGBO(131, 196, 210, 1.0),
              primary: Color.fromRGBO(4, 8, 9, 0.5),
              elevation: 10,
              fixedSize: const Size(200, 40),
              textStyle: const TextStyle(
                fontSize: 22,
                fontFamily: 'Prompt'
              )
            ), child: const Text("Let's Drive")),
            SizedBox(height: 10),
          ],
        ),
      )
    );
  }
}
