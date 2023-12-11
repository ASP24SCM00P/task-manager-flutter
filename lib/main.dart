import 'package:flutter/material.dart';
import 'package:mp5/views/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

//SharedPreferences? sharedPreferences; 


Future<void> main() async {
  // sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    home: HomePage(quoteService: QuoteService()),
 

      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
    );
  }
}
