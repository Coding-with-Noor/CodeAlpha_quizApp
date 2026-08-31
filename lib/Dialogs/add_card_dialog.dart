import 'package:flutter/material.dart';
import 'package:quiz_app/FlashCard.dart';
import 'package:quiz_app/FlashCardCategory.dart';

void showAddCardDialog({
  required BuildContext context,
  required List<FlashCardCategory> categories,
  required Function(FlashCardCategory targetCategory, FlashCard newCard) onCardAdded,
}) {
  final questionController = TextEditingController();
  final answerController = TextEditingController();
  FlashCardCategory selectedCategory = categories.first;

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            backgroundColor: Color(0XFFF5EFE5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            title: Text(
              "Add FlashCard",
              style: TextStyle(
                fontFamily: "Poppins",
                color: Color(0XFF422701),
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<FlashCardCategory>(
                  value: selectedCategory,
                  decoration: InputDecoration(
                    labelText: "Select Category",
                    border: OutlineInputBorder(),
                  ),
                  items: categories.map((FlashCardCategory category) {
                    return DropdownMenuItem<FlashCardCategory>(
                      value: category,
                      child: Text(category.title),
                    );
                  }).toList(),
                  onChanged: (FlashCardCategory? newValue) {
                    if (newValue != null) {
                      setDialogState(() {
                        selectedCategory = newValue;
                      });
                    }
                  },
                ),
                SizedBox(height: 12),
                TextField(
                  controller: questionController,
                  decoration: InputDecoration(
                    labelText: "Question",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: answerController,
                  decoration: InputDecoration(
                    labelText: "Answer",
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    color: Color(0XFF422701),
                    fontSize: 18,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0XFF422701),
                ),
                onPressed: () {
                  if (questionController.text.trim().isNotEmpty &&
                      answerController.text.trim().isNotEmpty) {
                    final newCard = FlashCard(
                      question: questionController.text.trim(),
                      answer: answerController.text.trim(),
                    );
                    onCardAdded(selectedCategory, newCard);
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  "Add",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    color: Color(0XFFFFFFFF),
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}
