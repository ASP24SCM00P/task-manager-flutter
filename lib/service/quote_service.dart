import 'dart:convert';

import 'package:mp5/models/quote.dart';
import 'package:http/http.dart' as http;


class QuoteService {
  Future<Map<String, dynamic>> fetchQuote() async {
    try {
      final response = await http.get(Uri.parse('https://api.quotable.io/random'));

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.body.isEmpty) {
        throw Exception('Empty response body');
      }

      return json.decode(response.body);
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
        throw Exception('Failed to parse quote data');
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
