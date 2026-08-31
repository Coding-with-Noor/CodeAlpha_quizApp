import 'package:flutter/material.dart';
import 'package:quiz_app/FlashCard.dart';

class FlashCardWidget extends StatefulWidget {
  final FlashCard flashcard;

  FlashCardWidget(this.flashcard, {super.key});

  @override
  State<FlashCardWidget> createState() => _FlashCardWidgetState();
}

class _FlashCardWidgetState extends State<FlashCardWidget> {
  bool isFavorite = false;
  bool showAnswer = false;

  // Reset answer view when a new card is loaded
  @override
  void didUpdateWidget(covariant FlashCardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.flashcard != widget.flashcard) {
      setState(() {
        showAnswer = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 6,
        shadowColor: Colors.black54,
        color: Color(0XFFFFF8EC),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  style: IconButton.styleFrom(
                    side: BorderSide(width: 1.5, color: Color(0XFFE8E0D5)),
                  ),
                  onPressed: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },
                  icon: Card(
                    shape: CircleBorder(),
                    child: Icon(
                      isFavorite ? Icons.star : Icons.star_border_outlined,
                      size: 24,
                      color: const Color(0XFF705E46),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                showAnswer ? "Answer" : "Question",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  color: Color(0XFF705E46),
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: 28),
              Text(
                showAnswer
                    ? widget.flashcard.answer
                    : widget.flashcard.question,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  color: Color(0XFF422701),
                ),
              ),
              SizedBox(height: 36),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Color(0xFFD6B588),
                      thickness: 1,
                    ),
                  ),
                  SizedBox(width: 12),
                  Icon(Icons.sync, color: Color(0xFF705E46), size: 22),
                  SizedBox(width: 12),
                  Expanded(
                    child: Divider(
                      color: Color(0xFFD6B588),
                      thickness: 1,
                    ),
                  ),
                ],
              ),
              SizedBox(height:16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0XFF422701),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    showAnswer = !showAnswer;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text(
                    showAnswer ? "Show Question" : "Show Answer",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0XFFFFFFFF),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
