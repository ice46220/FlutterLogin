import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/home.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(Duration(seconds: 1));
  FlutterNativeSplash.remove();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
   
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.outfitTextTheme(
        Theme.of(context).textTheme,  // ถ้าไม่ใส่ มันจะตั้งค่า Default ทุกอย่างตาม ThemeData.light().textTheme
    ),
      ),
      home: HomeScreen()
    );
  }
}


