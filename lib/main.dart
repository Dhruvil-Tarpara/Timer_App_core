import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_round_slider/flutter_round_slider.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    ),
  );
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
   int h = 00;
  int min  = 00;
  int sec = 00;
  int msec = 00;
  double val = 00;
  bool Val = true;

  @override
  void initState() {
    super.initState();
    time();
  }

  final valueTween = Tween<double>(
    begin: -120,
    end: 360,
  );

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
      valueTween.transform(val);
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              height: size.height,
              width: size.width,
              child: Image(
                image: AssetImage("imeges/Background1.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: size.height * 0.7,
              width: size.width * 0.7,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Text(
                "$h : $min : $sec.$msec ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 36,
                ),
              ),
            ),
            Positioned(
              width: size.width * 0.82,
              child: RoundSlider(
                style: RoundSliderStyle(
                  lineColor: Colors.blue,
                  borderColor: Colors.black,
                  borderStroke: 12,
                  lineStroke: 2,
                ),
                animationDuration: Duration.zero,
                value: val,
                onChanged: (value) {
                  setState(() {
                    val = value;
                  });
                },
              ),
            ),
            Positioned(
              bottom: size.height * 0.1,
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        msec = 00;
                        sec = 00;
                        min = 00;
                        h = 00;
                      });
                    },
                    child: Icon(
                      Icons.refresh,
                      size: 34,
                      color: Colors.white,
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.brown.shade900),
                      fixedSize: MaterialStateProperty.all(
                        Size(size.width * 0.3, size.height * 0.06),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.26,
                  ),
                  ElevatedButton(
                    onPressed: () {
                       setState((){ Val ? _stop() : _start();});
                    },
                    child: Text(
                      "${(Val) ? 'Stop' : 'Start'}",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.brown.shade900),
                      fixedSize: MaterialStateProperty.all(
                        Size(size.width * 0.3, size.height * 0.06),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
    time() async {
    await Future.delayed(Duration(milliseconds: 1), () {
      setState(() {
        if (msec >= 99) {
          sec++;
          msec = 00;
        } else if (sec >= 59) {
          min++;
          sec = 00;
        } else if (min >= 59) {
          h++;
          min = 00;
        } else {
          msec++;
        }
        (Val) ?time() : Val;
      });
    });
  }

   void _stop() async {
     setState(() {
       Val = false;
      });
   }
   void _start() async {
     setState(() {
       Val = true;
       time();
     });
   }
}
