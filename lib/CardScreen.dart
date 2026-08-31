// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:quiz_app/EditCardScreen.dart';
// import 'package:quiz_app/FlashCard.dart';
// import 'package:quiz_app/FlashCardWidget.dart';
// import 'package:quiz_app/main.dart';
//
// class CardScreen extends StatefulWidget {
//   final List<FlashCard> categoryCard;
//   final String categoryTitle;
//   final int categoryId;
//
//   const CardScreen(this.categoryCard, this.categoryTitle,this.categoryId, {super.key});
//
//   @override
//   State<CardScreen> createState() => _CardScreenState();
// }
//
// class _CardScreenState extends State<CardScreen> {
//   int _currentIndex = 0;
//   late List<FlashCard> _currentCards;
//
//   @override
//   void initState() {
//     super.initState();
//     _currentCards = List.from(widget.categoryCard);
//   }
//
//   void _nextCard() {
//     if (_currentIndex < _currentCards.length - 1) {
//       setState(() {
//         _currentIndex++;
//       });
//     }
//   }
//
//   void _previousCard() {
//     if (_currentIndex > 0) {
//       setState(() {
//         _currentIndex--;
//       });
//     }
//   }
//
//   Future<void> _refreshCards() async {
//     final updatedCards = await sqliteDBHelper.getCardsForCategory(widget.categoryId);
//     setState(() {
//       _currentCards = updatedCards;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final totalCards = _currentCards.length;
//     final currentCard = totalCards > 0
//         ? _currentCards[_currentIndex]
//         : null;
//     return Scaffold(
//       backgroundColor: const Color(0xFFC6C0B9),
//       appBar: AppBar(
//         backgroundColor: const Color(0XFF422701),
//         elevation: 0,
//         centerTitle: true,
//         title: Text(
//           totalCards > 0 ? "${_currentIndex + 1}/$totalCards" : "",
//           style: const TextStyle(
//             fontFamily: "Poppins",
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//             color: Color(0XFFFFFFFF),
//           ),
//         ),
//         actions: totalCards > 0
//             ? [
//                 IconButton(
//                   icon: const Icon(Icons.edit, color: Color(0XFFFFFFFF), size: 26),
//                   onPressed: () async {
//                     final currentCard = _currentCards[_currentIndex];
//                     final isUpdated = await Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => EditCardScreen(card: currentCard),
//                       ),
//                     );
//                     if (isUpdated == true) {
//                       await _refreshCards();
//                     }
//                   },
//                 ),
//               ]
//             : null,
//       ),
//
//
//       body: Padding(
//         padding: const EdgeInsets.all(18.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             if (currentCard != null)
//               FlashCardWidget(currentCard)
//             else
//               const Text(
//                 "No cards Available",
//                 style: TextStyle(color: Color(0XFFFFFFFF)),
//               ),
//             SizedBox(height: 16),
//             Row(
//               children: [
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0XFF422701),
//                     padding: const EdgeInsets.all(8.0),
//                   ),
//                   onPressed: totalCards > 1 ? _previousCard : null,
//                   child: Padding(
//                     padding: const EdgeInsets.all(14.0),
//                     child: Row(
//                       children: [
//                         Icon(
//                           Icons.arrow_back_ios,
//                           size: 20,
//                           color: Color(0XFFFFFFFF),
//                         ),
//                         SizedBox(width: 10),
//                         Text(
//                           "Previous",
//                           style: TextStyle(
//                             fontFamily: 'Poppins',
//                             fontSize: 16,
//                             color: Color(0XFFFFFFFF),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const Spacer(),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0XFF422701),
//                     padding: const EdgeInsets.all(8.0),
//                   ),
//                   onPressed: totalCards > 1 ? _nextCard : null,
//                   child: Padding(
//                     padding: const EdgeInsets.all(14.0),
//                     child: Row(
//                       children: [
//                         Text(
//                           "Next",
//                           style: TextStyle(
//                             fontFamily: 'Poppins',
//                             fontSize: 16,
//                             color: Color(0XFFFFFFFF),
//                           ),
//                         ),
//                         SizedBox(width: 10),
//                         Icon(
//                           Icons.arrow_forward_ios,
//                           size: 20,
//                           color: Color(0XFFFFFFFF),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:quiz_app/EditCardScreen.dart';
import 'package:quiz_app/FlashCard.dart';
import 'package:quiz_app/FlashCardWidget.dart';
import 'package:quiz_app/main.dart'; // SQLiteDBHelper instance (sqliteDBHelper)

class CardScreen extends StatefulWidget {
  final List<FlashCard> categoryCard;
  final String categoryTitle;
  final int categoryId;

  const CardScreen(this.categoryCard, this.categoryTitle, this.categoryId, {super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  int _currentIndex = 0;
  late List<FlashCard> _currentCards;

  @override
  void initState() {
    super.initState();
    _currentCards = List.from(widget.categoryCard);
  }

  void _nextCard() {
    if (_currentIndex < _currentCards.length - 1) {
      setState(() {
        _currentIndex++;
      });
    }
  }

  void _previousCard() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
    }
  }

  Future<void> _refreshCards() async {
    final updatedCards = await sqliteDBHelper.getCardsForCategory(widget.categoryId);
    setState(() {
      _currentCards = updatedCards;
      if (_currentIndex >= _currentCards.length && _currentCards.isNotEmpty) {
        _currentIndex = _currentCards.length - 1;
      } else if (_currentCards.isEmpty) {
        _currentIndex = 0;
      }
    });
  }

  Future<void> _deleteCurrentCard() async {
    if (_currentCards.isEmpty) return;

    final currentCard = _currentCards[_currentIndex];
    if (currentCard.id != null) {
      await sqliteDBHelper.deleteCard(currentCard.id!);
      await _refreshCards();
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalCards = _currentCards.length;
    final currentCard = totalCards > 0 ? _currentCards[_currentIndex] : null;

    return Scaffold(
      backgroundColor: const Color(0xFFC6C0B9),
      appBar: AppBar(
        backgroundColor: const Color(0XFF422701),
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.categoryTitle,
          style: const TextStyle(
            fontFamily: "Poppins",
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0XFFFFFFFF),
          ),
        ),
        actions: totalCards > 0
            ? [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Center(
              child: Text(
                "${_currentIndex + 1}/$totalCards",
                style: const TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 16,
                  color: Color(0XFFFFFFFF),
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit, color: Color(0XFFFFFFFF), size: 24),
            onPressed: () async {
              if (currentCard == null) return;
              final isUpdated = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditCardScreen(card: currentCard),
                ),
              );
              if (isUpdated == true) {
                await _refreshCards();
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Color(0XFFFFFFFF), size: 24),
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Delete Flashcard"),
                  content: const Text("Are you sure you want to delete this card?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text("Delete"),
                    ),
                  ],
                ),
              );

              if (confirm == true) {
                await _deleteCurrentCard();
              }
            },
          ),
        ]
            : null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (currentCard != null)
              FlashCardWidget(currentCard)
            else
              const Text(
                "No cards Available",
                style: TextStyle(color: Color(0XFF422701), fontSize: 18, fontFamily: 'Poppins'),
              ),
            const SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0XFF422701),
                    padding: const EdgeInsets.all(8.0),
                  ),
                  onPressed: totalCards > 1 && _currentIndex > 0 ? _previousCard : null,
                  child: const Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back_ios, size: 20, color: Color(0XFFFFFFFF)),
                        SizedBox(width: 10),
                        Text(
                          "Previous",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            color: Color(0XFFFFFFFF),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0XFF422701),
                    padding: const EdgeInsets.all(8.0),
                  ),
                  onPressed: totalCards > 1 && _currentIndex < totalCards - 1 ? _nextCard : null,
                  child: const Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Row(
                      children: [
                        Text(
                          "Next",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            color: Color(0XFFFFFFFF),
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.arrow_forward_ios, size: 20, color: Color(0XFFFFFFFF)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}