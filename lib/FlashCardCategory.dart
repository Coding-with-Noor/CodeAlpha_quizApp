import 'package:quiz_app/FlashCard.dart';

class FlashCardCategory {
  int? id;
  final String title;
  final String imagePath;
  final List<FlashCard> cards;

  FlashCardCategory({
    this.id,
    required this.title,
    required this.imagePath,
    required this.cards,
  });
  factory FlashCardCategory.fromMap(Map<String, dynamic> map, {List<FlashCard> cards = const []}) {
    return FlashCardCategory(
      id: map['id'] as int?,
      title: map['title']?.toString() ?? '',
      imagePath: map['imagePath']?.toString() ?? '',
      cards: cards,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'imagePath': imagePath,
    };
  }


}
