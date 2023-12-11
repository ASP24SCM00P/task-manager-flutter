import 'dart:convert';
import 'package:mp5/models/quote.dart';
import 'package:http/http.dart' as http;

class QuoteService {
  final http.Client httpClient;

  QuoteService({http.Client? httpClient}) : httpClient = httpClient ?? http.Client();

  Future<Map<String, dynamic>> fetchQuote() async {
    try {
      final response = await httpClient.get(Uri.parse('https://api.quotable.io/random'));

      if (response.statusCode == 200) {
        final responseBody = response.body;
        if (responseBody.isNotEmpty) {
          return json.decode(responseBody);
        } else {
          throw Exception('Empty response body');
        }
      } else {
        throw Exception('Failed to fetch quote. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching quote: $e');
      throw e;
    }
  }

  Future<Quote> fetchParsedQuote() async {
    try {
      final Map<String, dynamic> responseData = await fetchQuote();

      if (responseData.containsKey('content') && responseData.containsKey('author')) {
        // Check if 'content' is a String
        if (responseData['content'] is String) {
          return Quote.fromJson(responseData);
        } else {
          throw Exception('Invalid data type for content');
        }
      } else {
        throw Exception('Failed to parse quote data. Missing required fields.');
      }
    } catch (e) {
      print('Error loading quote: $e');
      return Quote(
        id: '',
        tags: '',
        content: '',
        author: '',
        authorSlug: '',
        length: null,
        dateAdded: '',
        dateModified: '',
      );
    }
  }
}
