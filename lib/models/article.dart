// ignore_for_file: public_member_api_docs, sort_constructors_first
class Article {
  final String title;
  final String author;
  final String description;
  final DateTime published;
  final String content;
  String articleUrl;
  Article({
    required this.title,
    required this.author,
    required this.description,
    required this.published,
    required this.content,
    required this.articleUrl,
    required imgUrl,
  });
}
