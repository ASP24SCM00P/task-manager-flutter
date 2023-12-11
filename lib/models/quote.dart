// quote_model.dart

class Quote {
  final String id;
  final String tags;
  final String content;
  final String author;
  final String authorSlug;
  final int? length;
  final String dateAdded;
  final String dateModified;

  Quote({
    required this.id,
    required this.tags,
    required this.content,
    required this.author,
    required this.authorSlug,
    required this.length,
    required this.dateAdded,
    required this.dateModified,
  });

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      id: json['_id'] ?? '',
      tags: json['tags'] ?? '',
      content: json['content'] ?? '',
      author: json['author'] ?? '',
      authorSlug: json['authorSlug'] ?? '',
      length: json['length'] ?? null,
      dateAdded: json['dateAdded'] ?? '',
      dateModified: json['dateModified'] ?? '',
    );
  }
}
