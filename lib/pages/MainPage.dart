import 'package:flutter/material.dart';
import 'Joystick.dart';
import '../Colors.dart';
import '../Servers.dart';
import './Error.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var serverstatus = "Offline";
  var serverstatuscolor = Colors.red;
  var hostip = "192.168.98.176";
  var currentspeed = 50.0;





  void changeStatus() {
    setState(() {
      if(serverstatus == "Online"){
        serverstatus = "Offline";
        serverstatuscolor = Colors.red;
      }
      else{
        serverstatus = "Online";
        serverstatuscolor = Colors.green;
      }
    });

  }
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 2;

    navigateTo(int index) {
      setState(() {
        if(_selectedIndex != index){
          Navigator.pop(context);
        }
        _selectedIndex = index;
        print(_selectedIndex);
        // Navigator.pop(context);
      });
    }

    Widget _bottomAppBarIcon({required int index, required IconData icon}) {
      return IconButton(
        onPressed: () {
          navigateTo(index);
        },
        icon: Icon(
          icon,
          color: _selectedIndex == index ? kPrimaryColor : null,
        ),
        iconSize: 35,
      );
    }

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50,
          color: buttomappcolor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _bottomAppBarIcon(index: 0, icon: Icons.home),
              SizedBox(
                  width: 80,
                  height: 80,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                          bottom: 10,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                gradient: serverstatus == 'Offline' ? buttonGradient2 : buttonGradient1),
                            child: IconButton(
                              onPressed: () async {
                                print("S: $currentspeed , Ip: $hostip");
                                await serverstatus == 'Offline' ? await runServer(currentspeed , hostip) : await stopServer();
                                 setState(() {
                                   if(status == 1 || status == 0) {
                                     changeStatus();
                                 }
                                  else{
                                     Navigator.push(
                                       context,
                                       MaterialPageRoute(builder: (context) => Error()),
                                     );
                                    print('Unknown Host');
                                   }
                                 });
                                  print(serverstatus);
                              },
                              icon: Icon(Icons.power_settings_new_outlined),
                              iconSize: 50,
                              color: Colors.white,
                            ),
                          ))
                    ],
                  )),
              _bottomAppBarIcon(index: 2, icon: Icons.control_camera_rounded),
            ],
          ),
        ),
      ),
      body: Container(
          decoration: BoxDecoration(gradient: kBackGroundGradient),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 25, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Hey,",
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.white70),
                        ),
                        Text(
                          "Ashutosh...",
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Ubuntu',
                              color: Colors.white70),
                        ),
                      ],
                    ),
                    IconButton(onPressed: ()async{
                      dynamic data = await Navigator.pushNamed(context, '/Settings' , arguments: {
                        'currentspeed'  :currentspeed,
                        'hostip' : hostip
                      });
                      setState(() {
                        currentspeed = data['currentspeed'];
                        hostip = data['hostip'];
                      });

                      print('current speeed:$currentspeed' );
                      print('currentip: $hostip');
                    }, icon: Icon(Icons.settings) , color: Colors.white70,)
                  ],
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 100),
                  margin: EdgeInsets.symmetric(vertical: 20),
                  height: 50,
                  decoration: BoxDecoration(
                      gradient: kCardGradient1,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromRGBO(6, 5, 45, 1.0),
                            offset: Offset(-5, 5),
                            spreadRadius: 2,
                            blurRadius: 7)
                      ]),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Server Status',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                  },
                                  icon: Icon(Icons.circle),
                                  color: serverstatuscolor,
                                  iconSize: 20,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 0)),
                              Text(
                                serverstatus,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                    fontFamily: 'FireSans'),
                              ),
                            ],
                          )
                        ],
                      )),
                ),
                GestureDetector(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    height: 120,
                    decoration: BoxDecoration(
                        gradient: serverstatus == 'Offline' ? kCardGradient1 : kCardGradient2,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(-5, 5),
                              spreadRadius: 2,
                              blurRadius: 7,
                              color: Color.fromRGBO(
                                  83, 109, 151, 0.45098039215686275))
                        ]),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 30, horizontal: 5),
                          child: Text(
                            'Joystick',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white70,
                              fontFamily: 'Prompt'
                            ),
                          ),
                        ),
                        Image.asset('assets/images/car2.png')
                      ],
                    ),
                  ),
                ),
               AbsorbPointer(
                 absorbing: serverstatus== 'Offline' ? true : false,
                 child: Joystick(
                      stickRadius: 100,
                      onDirectionChange: (direction) {
                        if (direction.dx > 20) {
                          print('Right');
                        } else if (direction.dx < -20) {
                          print('Left');
                        } else if (direction.dy > 20) {
                          print('Down');
                        } else if (direction.dy < -20) {
                          print('Up');
                        } else {
                          print('Center');
                        }
                      }),
               )
              ],
            ),
          )),
    );
  }


}
