import 'package:flutter/material.dart';
import 'package:quiz_app/Database/SQLiteDBHelper.dart';
import 'package:quiz_app/FlashCard.dart';

class EditCardScreen extends StatefulWidget {
  final FlashCard card;

  const EditCardScreen({Key? key, required this.card}) : super(key: key);

  @override
  State<EditCardScreen> createState() => _EditCardScreenState();
}

class _EditCardScreenState extends State<EditCardScreen> {
  late TextEditingController _questionController;
  late TextEditingController _answerController;

  @override
  void initState() {
    super.initState();
    _questionController = TextEditingController(text: widget.card.question);
    _answerController = TextEditingController(text: widget.card.answer);
  }

  @override
  void dispose() {
    _questionController.dispose();
    _answerController.dispose();
    super.dispose();
  }

  Future<void> _saveCard() async {
    final updatedQuestion = _questionController.text.trim();
    final updatedAnswer = _answerController.text.trim();
    final SQLiteDBHelper _dbHelper = SQLiteDBHelper();


    if (updatedQuestion.isEmpty || updatedAnswer.isEmpty) return;

    await _dbHelper.updateCard(
      widget.card.id!,
      updatedQuestion,
      updatedAnswer,
    );

    // Return true so the calling screen knows to refresh
    if (mounted) Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFF5EFE5),
      appBar: AppBar(
        title: const Text('Edit Flashcard',style: TextStyle(
          fontFamily: 'Poppins',
          color: Color(0XFFFFFFFF),
          height: 1.8,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _questionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Question',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _answerController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Answer',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _saveCard,
                icon: Icon(Icons.save,size:22,color:Color(0XFFFFFFFF)),
                label: Text('Save Flashcard',style: TextStyle(color: Color(0XFFFFFFFF),fontSize: 18,fontFamily: "Poppins",fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0XFF422701),
                  foregroundColor: Color(0XFFFFFFFF),
                  minimumSize: const Size.fromHeight(50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}