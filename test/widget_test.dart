import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:mp5/service/quote_service.dart';
import 'package:mp5/service/quote_service.dart';
import 'package:mp5/views/home_page.dart';


class MockQuoteService extends Mock  {
  @override
  Future<Map<String, dynamic>> fetchQuote() async {
    return {'author': 'Mock Author', 'content': 'Mock Quote Content'};
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Create a mock instance of QuoteService
    final mockQuoteService = MockQuoteService();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    //  home: HomePage(quoteService: mockQuoteService),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
    );
  }
}
