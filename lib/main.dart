import 'package:flutter/material.dart';
import 'dart:async';
import 'package:percent_indicator/percent_indicator.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: pomodoro(),
    );
  }
}

class pomodoro extends StatefulWidget {
  const pomodoro({super.key});

  @override
  State<pomodoro> createState() => _pomodoroState();
}

class _pomodoroState extends State<pomodoro> {
  Timer? repeatedFunction;
  Duration duration = Duration(minutes: 25);
  startTimer() {
    repeatedFunction = Timer.periodic(Duration(seconds: 1), (qqqqqq) {
      setState(() {
        int newSeconds = duration.inSeconds - 1;
        duration = Duration(seconds: newSeconds);
        if (duration.inSeconds == 0) {
          repeatedFunction!.cancel();
          setState(() {
            duration = Duration(minutes: 25);
            isRunning = false;
          });
        }
      });
    });
  }

  bool isRunning = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title:const Text(
        "Pomodoro App",
        style: TextStyle(color: Colors.white, fontSize: 28),
      ),
      backgroundColor: const Color.fromARGB(255, 50, 65, 71),
    ),
        backgroundColor:const Color.fromARGB(255, 33, 40, 43),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularPercentIndicator(
                  progressColor: const Color.fromARGB(255, 255, 85, 113),
                  backgroundColor:const Color.fromARGB(255, 255, 255, 255),
                  lineWidth: 7,
                  percent: duration.inMinutes / 25,
                  animation: true,
                  animateFromLastPercent: true,
                  animationDuration: 1000,
                  radius: 120.0,
                  center: Text(
                    "${duration.inMinutes.remainder(60).toString().padLeft(2, "0")}:${duration.inSeconds.remainder(60).toString().padLeft(2, "0")}",
                    style:const TextStyle(fontSize: 77, color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 55,
            ),
            isRunning
                ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (repeatedFunction!.isActive) {
                      setState(() {
                        repeatedFunction!.cancel();
                      });
                    } else {
                      startTimer();
                    }
                  },
                  child: Text(
                    (repeatedFunction!.isActive) ? "Stop" : "Resume",
                    style: TextStyle(fontSize: 22),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 197, 25, 97)),
                    padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9))),
                  ),
                ),
                const SizedBox(
                  width: 22,
                ),
                ElevatedButton(
                  onPressed: () {
                    repeatedFunction!.cancel();
                    setState(() {
                      duration =const Duration(minutes: 25);
                      isRunning = false;
                    });
                  },
                  child:Text(
                    "CANCEL",
                    style:  TextStyle(fontSize: 19),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 197, 25, 97)),
                    padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9))),
                  ),
                ),
              ],
            )
                : ElevatedButton(
              onPressed: () {
                startTimer();
                setState(() {
                  isRunning = true;
                });
              },
              child: Text(
                "Start Studying",
                style: TextStyle(fontSize: 23),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    Color.fromARGB(255, 25, 120, 197)),
                padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9))),
              ),
            )
          ],
        )

    );
  }
}
