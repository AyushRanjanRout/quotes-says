class Quote {
  String author;
  String text;

  Quote({required this.author, required this.text});

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      author: json['author'] as String,
      text: json['text'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'author': author,
      'text': text,
    };
  }
}
