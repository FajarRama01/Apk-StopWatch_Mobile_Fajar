import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(const AlarmStopwatchApp());

class AlarmStopwatchApp extends StatelessWidget {
  const AlarmStopwatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const StopwatchPage(),
    );
  }
}

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({super.key});

  @override
  State<StopwatchPage> createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  late Stopwatch _stopwatch;
  Timer? _timer;
  List<String> laps = [];

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      setState(() {});
    });
  }

  void _handleStartPause() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
      _timer?.cancel();
    } else {
      _stopwatch.start();
      _startTimer();
    }
    setState(() {});
  }

  void _handleReset() {
    _stopwatch.reset();
    laps.clear();
    setState(() {});
  }

  void _handleLap() {
    if (_stopwatch.isRunning) {
      setState(() {
        laps.insert(0, _formatTime(_stopwatch.elapsedMilliseconds));
      });
    }
  }

  String _formatTime(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate() % 100;
    int seconds = (milliseconds / 1000).truncate() % 60;
    int minutes = (milliseconds / (1000 * 60)).truncate();

    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');
    String hundredsStr = hundreds.toString().padLeft(2, '0');

    return "$minutesStr:$secondsStr:$hundredsStr";
  }

  // Widget Kotak Angka LED
  Widget _buildTimeSegment(String value, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.greenAccent.withOpacity(0.4)),
            boxShadow: [
              BoxShadow(
                color: Colors.greenAccent.withOpacity(0.15),
                blurRadius: 10,
                spreadRadius: 1,
              )
            ],
          ),
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Colors.greenAccent,
              fontFamily: 'Courier',
              shadows: [
                Shadow(color: Colors.greenAccent, blurRadius: 12),
              ],
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(color: Colors.greenAccent, fontSize: 10, fontWeight: FontWeight.bold)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    int totalMs = _stopwatch.elapsedMilliseconds;
    String min = ((totalMs / (1000 * 60)) % 60).toInt().toString().padLeft(2, '0');
    String sec = ((totalMs / 1000) % 60).toInt().toString().padLeft(2, '0');
    String ms = ((totalMs / 10) % 100).toInt().toString().padLeft(2, '0');

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Text("STOPWATCH by Muhamad Fajar Ramadlan", 
                style: TextStyle(letterSpacing: 5, color: Colors.white24, fontWeight: FontWeight.bold)),
            ),
            
            // TAMPILAN JAM UTAMA
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF161616),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTimeSegment(min, "MIN"),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 25, left: 5, right: 5),
                    child: Text(":", style: TextStyle(fontSize: 40, color: Colors.greenAccent)),
                  ),
                  _buildTimeSegment(sec, "SEC"),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 25, left: 5, right: 5),
                    child: Text(":", style: TextStyle(fontSize: 40, color: Colors.greenAccent)),
                  ),
                  _buildTimeSegment(ms, "MS"),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // TOMBOL KONTROL
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Tombol Kiri (LAP atau RESET)
                _buildButton(
                  _stopwatch.isRunning ? "LAP" : "RESET", 
                  _stopwatch.isRunning ? Colors.blueAccent : Colors.orangeAccent, 
                  _stopwatch.isRunning ? _handleLap : _handleReset
                ),
                // Tombol Kanan (START atau STOP)
                _buildButton(
                  _stopwatch.isRunning ? "STOP" : "START", 
                  _stopwatch.isRunning ? Colors.redAccent : Colors.greenAccent, 
                  _handleStartPause
                ),
              ],
            ),

            const SizedBox(height: 30),
            const Divider(color: Colors.white10, thickness: 1, indent: 20, endIndent: 20),

            // DAFTAR LAP
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                itemCount: laps.length,
                separatorBuilder: (context, index) => const Divider(color: Colors.white10),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "LAP ${laps.length - index}",
                          style: const TextStyle(color: Colors.white38, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          laps[index],
                          style: const TextStyle(
                            color: Colors.greenAccent, 
                            fontSize: 20, 
                            fontFamily: 'Courier',
                            letterSpacing: 2
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Desain Tombol Bergaya Bezel
  Widget _buildButton(String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 130,
        height: 55,
        decoration: BoxDecoration(
          color: color.withOpacity(0.05),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: color.withOpacity(0.5), width: 2),
          boxShadow: [
            BoxShadow(color: color.withOpacity(0.1), blurRadius: 8),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 2),
          ),
        ),
      ),
    );
  }
}