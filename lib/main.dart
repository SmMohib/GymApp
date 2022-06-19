import 'package:flutter/material.dart';
import 'package:gymapp/GridDemo.dart';
import 'package:gymapp/addpage.dart';
import 'package:gymapp/homePage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:gymapp/imagedemo.dart';
import 'package:gymapp/provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<GymProvider>(create: (_) => GymProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: GridDemo());
  }
}
