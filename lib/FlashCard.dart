class FlashCard {
  final int? id;
  final String question;
  final String answer;

  FlashCard({this.id,required this.question, required this.answer});

  Map<String, dynamic> toMap(int categoryId) {
    return {
      if (id != null) 'id': id,
      'question': question,
      'answer': answer,
    };
  }

  factory FlashCard.fromMap(Map<String, dynamic> map) {
    return FlashCard(
      id: map['id'] as int?,
      question: map['question']?.toString() ?? '',
      answer: map['answer']?.toString() ?? '',
    );
  }
}

