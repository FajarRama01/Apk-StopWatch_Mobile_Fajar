// import 'dart:async';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(const StopwatchApp());
// }

// class StopwatchApp extends StatelessWidget {
//   const StopwatchApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData.dark().copyWith(
//         scaffoldBackgroundColor: const Color(0xFF0A0E21),
//         primaryColor: Colors.blueAccent,
//       ),
//       home: const StopwatchPage(),
//     );
//   }
// }

// class StopwatchPage extends StatefulWidget {
//   const StopwatchPage({super.key});

//   @override
//   State<StopwatchPage> createState() => _StopwatchPageState();
// }

// class _StopwatchPageState extends State<StopwatchPage> {
//   // Inisialisasi objek Stopwatch dan Timer
//   late Stopwatch _stopwatch;
//   late Timer _timer;

//   // List untuk menyimpan catatan waktu Lap
//   List<String> laps = [];

//   @override
//   void initState() {
//     super.initState();
//     _stopwatch = Stopwatch();
//   }

//   // Fungsi untuk memperbarui UI setiap 30 milidetik
//   void _startTimer() {
//     _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
//       setState(() {});
//     });
//   }

//   // Logika Start dan Pause
//   void _handleStartPause() {
//     if (_stopwatch.isRunning) {
//       _stopwatch.stop();
//       _timer.cancel();
//     } else {
//       _stopwatch.start();
//       _startTimer();
//     }
//     setState(() {});
//   }

//   // Logika Reset
//   void _handleReset() {
//     _stopwatch.reset();
//     laps.clear();
//     setState(() {});
//   }

//   // Logika Tambah Lap
//   void _handleLap() {
//     if (_stopwatch.isRunning) {
//       setState(() {
//         laps.insert(0, _formatTime(_stopwatch.elapsedMilliseconds));
//       });
//     }
//   }

//   // Fungsi Helper untuk format waktu (00:00:00)
//   String _formatTime(int milliseconds) {
//     int hundreds = (milliseconds / 10).truncate() % 100;
//     int seconds = (milliseconds / 1000).truncate() % 60;
//     int minutes = (milliseconds / (1000 * 60)).truncate();

//     String minutesStr = (minutes % 60).toString().padLeft(2, '0');
//     String secondsStr = seconds.toString().padLeft(2, '0');
//     String hundredsStr = hundreds.toString().padLeft(2, '0');

//     return "$minutesStr:$secondsStr:$hundredsStr";
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("STOPWATCH by Muhamad Fajar Ramadlan"),
//         centerTitle: true,
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: Column(
//         children: [
//           const SizedBox(height: 50),
//           // Bagian Display Waktu Utama
//           Center(
//             child: Text(
//               _formatTime(_stopwatch.elapsedMilliseconds),
//               style: const TextStyle(
//                 fontSize: 70,
//                 fontWeight: FontWeight.w200,
//                 color: Colors.white,
//                 fontFamily: 'Courier', // Font monospaced agar angka tidak goyang
//               ),
//             ),
//           ),
//           const SizedBox(height: 50),
//           // Bagian Tombol Kontrol
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               _buildActionButton(
//                 label: _stopwatch.isRunning ? "LAP" : "RESET",
//                 color: Colors.grey[800]!,
//                 onPressed: _stopwatch.isRunning ? _handleLap : _handleReset,
//               ),
//               _buildActionButton(
//                 label: _stopwatch.isRunning ? "STOP" : "START",
//                 color: _stopwatch.isRunning ? Colors.redAccent : Colors.greenAccent,
//                 textColor: Colors.black,
//                 onPressed: _handleStartPause,
//               ),
//             ],
//           ),
//           const SizedBox(height: 40),
//           // Bagian List Lap
//           const Divider(color: Colors.white24),
//           Expanded(
//             child: ListView.builder(
//               itemCount: laps.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   leading: Text("Lap ${laps.length - index}", style: const TextStyle(color: Colors.white70)),
//                   trailing: Text(laps[index], style: const TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'Courier')),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Widget Helper untuk membuat tombol bulat
//   Widget _buildActionButton({required String label, required Color color, Color textColor = Colors.white, required VoidCallback onPressed}) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: color,
//         shape: const CircleBorder(),
//         padding: const EdgeInsets.all(30),
//       ),
//       child: Text(
//         label,
//         style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
//       ),
//     );
//   }
// }
// // import 'package:flutter/material.dart';
// // import 'halaman_timer.dart';

// // void main() => runApp(new MyApp());

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return new MaterialApp(
// //       showPerformanceOverlay: false,
// //       title: 'Flutter Demo',
// //       theme: new ThemeData(
// //         primarySwatch: Colors.blue,
// //       ),
// //       home: MyHomePage(key: null,),
// //     );
// //   }
// // }

// // class MyHomePage extends StatelessWidget {
// //   MyHomePage({required Key key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return new Scaffold(
// //       appBar: new AppBar(
// //         title: new Text("Stopwatch"),
// //       ),
// //       body: new Container(
// //         child: new TimerPage()
// //       ),
// //     );
// //   }
// // }

