import 'package:flutter/material.dart';
import '../Servers.dart';

class Joystick extends StatefulWidget {
  final double stickRadius;
  final void Function(Offset) onDirectionChange;

  const Joystick({
    Key? key,
    required this.stickRadius,
    required this.onDirectionChange,
  }) : super(key: key);

  @override
  _JoystickState createState() => _JoystickState();
}

class _JoystickState extends State<Joystick> {
  double knobSize = 60.0;
  Offset position = Offset(0, 0);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          // Calculate the new position
          double newX = position.dx + details.delta.dx;
          double newY = position.dy + details.delta.dy;

          // Limit the movement within boundaries
          newX = newX.clamp(-100 + knobSize / 2, 100 - knobSize / 2);
          newY = newY.clamp(-100 + knobSize / 2, 100 - knobSize / 2);

          position = Offset(newX, newY);
          // print(position);
          if (position.dy < -35 && position.dx > 30) {
            sendCommands('forward_right');
            }else if (position.dy < -35 &&  position.dx < -30) {
            sendCommands('forward_left');
            }else if (position.dy > 25 && position.dx > 30) {
            sendCommands('backward_right');
            }else if (position.dy > 25 &&  position.dx < -25) {
            sendCommands('backward_left');
            }
          else if (position.dx > 25) {
            sendCommands('right');
          } else if (position.dx < -25) {
            sendCommands('left');
          } else if (position.dy > 25) {
            sendCommands('backward');
          } else if (position.dy < -25) {
            sendCommands('forward');
          }
          // else {
          //   sendCommands('Center');
          // }
        });
      },
      onPanEnd: (details){
        setState(() {
          position = Offset(0, 0);
          sendCommands('stop');
        });
      },
        child: Container(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10 , left: 80),
                child: Container(
                width: 200,
                height: 200,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                  image: DecorationImage(image: AssetImage('assets/images/joystick_background.png') , fit: BoxFit.fill)
                ),
                child: Center(
                  child: Transform.translate(
                    offset: position,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                          image: DecorationImage(image: AssetImage('assets/images/joystick_knob.png') , fit: BoxFit.fill)
                      ),
                    ),
                  ),
                ),
          ),
              ),
            ]
          ),
        ),
    );
  }
}
