import 'package:flutter_test/flutter_test.dart';
import 'package:mp5/models/quote.dart';

void main() {
  group('Quote Model Tests', () {
    test('Quote should be created from JSON', () {
      Map<String, dynamic> json = {
        '_id': '1',
        'tags': 'inspirational',
        'content': 'This is a test quote.',
        'author': 'Test Author',
        'authorSlug': 'test-author',
        'length': 42,
        'dateAdded': '2022-01-01',
        'dateModified': '2022-01-02',
      };

      Quote quote = Quote.fromJson(json);

      expect(quote.id, '1');
      expect(quote.tags, 'inspirational');
      expect(quote.content, 'This is a test quote.');
      expect(quote.author, 'Test Author');
      expect(quote.authorSlug, 'test-author');
      expect(quote.length, 42);
      expect(quote.dateAdded, '2022-01-01');
      expect(quote.dateModified, '2022-01-02');
    });

    // Add more tests as needed
  });
}
