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

  // Widget untuk kotak angka digital
  Widget _buildTimeSegment(String value, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.greenAccent.withOpacity(0.3)),
            boxShadow: [
              BoxShadow(
                color: Colors.greenAccent.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
              )
            ],
          ),
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.bold,
              color: Colors.greenAccent,
              fontFamily: 'Courier', // Gaya font digital
              shadows: [
                Shadow(color: Colors.greenAccent, blurRadius: 15),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.greenAccent, fontSize: 12)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Kalkulasi Waktu
    int totalMs = _stopwatch.elapsedMilliseconds;
    String minutes = ((totalMs / (1000 * 60)) % 60).toInt().toString().padLeft(2, '0');
    String seconds = ((totalMs / 1000) % 60).toInt().toString().padLeft(2, '0');
    String milliseconds = ((totalMs / 10) % 100).toInt().toString().padLeft(2, '0');

    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Hitam pekat
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 40),
              child: Text("DIGITAL CHRONOMETER", 
                style: TextStyle(letterSpacing: 4, color: Colors.white24, fontWeight: FontWeight.bold)),
            ),
            const Spacer(),
            
            // PANEL JAM ALARM
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTimeSegment(minutes, "MIN"),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 25),
                    child: Text(" : ", style: TextStyle(fontSize: 40, color: Colors.greenAccent)),
                  ),
                  _buildTimeSegment(seconds, "SEC"),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 25),
                    child: Text(" : ", style: TextStyle(fontSize: 40, color: Colors.greenAccent)),
                  ),
                  _buildTimeSegment(milliseconds, "MS"),
                ],
              ),
            ),

            const Spacer(),
            
            // TOMBOL KONTROL
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton("RESET", Colors.orangeAccent, _handleReset),
                _buildButton(
                  _stopwatch.isRunning ? "STOP" : "START", 
                  _stopwatch.isRunning ? Colors.redAccent : Colors.greenAccent, 
                  _handleStartPause
                ),
              ],
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 50,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: color, width: 2),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
    );
  }
}