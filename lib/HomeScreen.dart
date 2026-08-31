// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:quiz_app/CardScreen.dart';
// import 'package:quiz_app/Dialogs/add_card_dialog.dart';
// import 'package:quiz_app/EditCategoryScreen.dart';
// import 'package:quiz_app/FlashCardCategory.dart';
// import 'package:quiz_app/Dialogs/add_category_dialog.dart';
// import 'package:quiz_app/FlashCard.dart';
// import 'package:quiz_app/CategoryAvatar.dart';
// import 'package:quiz_app/main.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   List<FlashCardCategory> categories = [];
//   bool isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadCategories();
//   }
//
//   Future<void> _loadCategories() async {
//     setState(() {
//       isLoading = true;
//     });
//     try {
//       final dbCategories = await sqliteDBHelper.getCategories();
//       if (dbCategories.isEmpty) {
//         for (final cat in defaultCategories) {
//           await sqliteDBHelper.insertCategory(cat);
//         }
//         final loaded = await sqliteDBHelper.getCategories();
//         setState(() {
//           categories = loaded;
//         });
//       } else {
//         setState(() {
//           categories = dbCategories;
//         });
//       }
//     } catch (e) {
//       debugPrint("Error loading categories: $e");
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
//   final List<FlashCardCategory> defaultCategories = [
//     FlashCardCategory(
//       title: " Islamic Knowledge",
//       imagePath: 'Assets/Images/islamic knowledge.jpg',
//       cards: [
//         FlashCard(
//           question: "How many obligatory prayers are there in Islam each day?",
//           answer: "Five",
//         ),
//         FlashCard(
//           question: "How many Surahs are there in the Quran?",
//           answer: "114",
//         ),
//         FlashCard(
//           question: "Which is the longest Surah in the Quran?",
//           answer: "Surah Al-Baqarah",
//         ),
//         FlashCard(
//           question: "Which is the shortest Surah in the Quran?",
//           answer: "Surah Al-Kawthar",
//         ),
//         FlashCard(
//           question: "In which year was the Hijrah?",
//           answer: "622 CE",
//         ),
//         FlashCard(
//           question: "In which city was Prophet Muhammad ﷺ born?",
//           answer: "Makkah",
//         ),
//         FlashCard(
//           question: "What is the first month of the Islamic calendar?",
//           answer: "Muharram",
//         ),
//         FlashCard(
//           question: "Which month do Muslims fast during?",
//           answer: "Ramadan",
//         ),
//         FlashCard(
//           question:
//           "Who was the first person to receive revelation from Allah through Angel Jibril?",
//           answer: "Prophet Muhammad ﷺ",
//         ),
//         FlashCard(
//           question: "What is the pilgrimage to Makkah called?",
//           answer: "Hajj",
//         ),
//       ],
//     ),
//     FlashCardCategory(
//       title: " World Geography",
//       imagePath: 'Assets/Images/world geography.jpg',
//       cards: [
//         FlashCard(question: "What is the largest continent?", answer: "Asia"),
//         FlashCard(question: "What is the capital of Japan?", answer: "Tokyo"),
//         FlashCard(
//           question: "What is the largest ocean in the world?",
//           answer: "Pacific Ocean",
//         ),
//         FlashCard(
//           question: "Which country is known as the Land of the Rising Sun?",
//           answer: "Japan",
//         ),
//         FlashCard(
//           question: "What is the capital of Australia?",
//           answer: "Canberra",
//         ),
//         FlashCard(
//           question: "What is the largest hot desert in the world?",
//           answer: "Sahara Desert",
//         ),
//         FlashCard(
//           question: "What is the smallest country in the world?",
//           answer: "Vatican City",
//         ),
//         FlashCard(
//           question: "Which continent is Egypt primarily located in?",
//           answer: "Africa",
//         ),
//         FlashCard(
//           question: "What is the capital of Pakistan?",
//           answer: "Islamabad",
//         ),
//         FlashCard(
//           question: "Which mountain is the highest in the world?",
//           answer: "Mount Everest",
//         ),
//       ],
//     ),
//     FlashCardCategory(
//       title: " Science",
//       imagePath: 'Assets/Images/Science.jpg',
//       cards: [
//         FlashCard(
//           question: "What is H₂O commonly known as?",
//           answer: "Water",
//         ),
//         FlashCard(
//           question: "Which planet is known as the Red Planet?",
//           answer: "Mars",
//         ),
//         FlashCard(
//           question: "What gas do humans need to breathe?",
//           answer: "Oxygen",
//         ),
//         FlashCard(
//           question: "What force pulls objects toward Earth?",
//           answer: "Gravity",
//         ),
//         FlashCard(
//           question: "What is the center of an atom called?",
//           answer: "Nucleus",
//         ),
//         FlashCard(
//           question: "Which organ pumps blood around the human body?",
//           answer: "Heart",
//         ),
//         FlashCard(
//           question: "What is the boiling point of water at sea level?",
//           answer: "100°C",
//         ),
//         FlashCard(
//           question:
//           "Which vitamin is produced when the skin is exposed to sunlight?",
//           answer: "Vitamin D",
//         ),
//         FlashCard(
//           question: "What is the largest organ of the human body?",
//           answer: "Skin",
//         ),
//         FlashCard(
//           question: "How many bones are in an average adult human body?",
//           answer: "206",
//         ),
//       ],
//     ),
//     FlashCardCategory(
//       title: " Computer & Technology",
//       imagePath: 'Assets/Images/IT.jpg',
//       cards: [
//         FlashCard(
//           question: "What does CPU stand for?",
//           answer: "Central Processing Unit",
//         ),
//         FlashCard(
//           question: "What does RAM stand for?",
//           answer: "Random Access Memory",
//         ),
//         FlashCard(
//           question: "What does HTML stand for?",
//           answer: "HyperText Markup Language",
//         ),
//         FlashCard(
//           question: "What does CSS stand for?",
//           answer: "Cascading Style Sheets",
//         ),
//         FlashCard(
//           question: "What does URL stand for?",
//           answer: "Uniform Resource Locator",
//         ),
//         FlashCard(
//           question: "What does AI stand for?",
//           answer: "Artificial Intelligence",
//         ),
//         FlashCard(
//           question: "What is the main function of an operating system?",
//           answer: "Manage computer hardware and software",
//         ),
//         FlashCard(
//           question: "Which company developed the Android operating system?",
//           answer: "Google",
//         ),
//         FlashCard(
//           question: "What does USB stand for?",
//           answer: "Universal Serial Bus",
//         ),
//         FlashCard(
//           question: "What is a computer program?",
//           answer: "A set of instructions executed by a computer",
//         ),
//       ],
//     ),
//     FlashCardCategory(
//       title: " History",
//       imagePath: 'Assets/Images/History.jpg',
//       cards: [
//         FlashCard(
//           question: "Who was the founder of Pakistan?",
//           answer: "Muhammad Ali Jinnah",
//         ),
//         FlashCard(
//           question: "In which year did Pakistan gain independence?",
//           answer: "1947",
//         ),
//         FlashCard(
//           question: "In which year did World War II end?",
//           answer: "1945",
//         ),
//         FlashCard(
//           question: "Which ancient civilization built the pyramids of Giza?",
//           answer: "Ancient Egyptians",
//         ),
//         FlashCard(
//           question:
//           "Which ancient city was destroyed by Mount Vesuvius in 79 CE?",
//           answer: "Pompeii",
//         ),
//         FlashCard(
//           question: "Who discovered penicillin?",
//           answer: "Alexander Fleming",
//         ),
//         FlashCard(
//           question: "Where did democracy develop in ancient Greece?",
//           answer: "Athens",
//         ),
//         FlashCard(
//           question: "Who was the first Governor-General of Pakistan?",
//           answer: "Muhammad Ali Jinnah",
//         ),
//         FlashCard(
//           question: "What was the Silk Road?",
//           answer: "A network of trade routes connecting East and West",
//         ),
//         FlashCard(
//           question: "Which wall divided Berlin during the Cold War?",
//           answer: "Berlin Wall",
//         ),
//       ],
//     ),
//     FlashCardCategory(
//       title: " General Knowledge",
//       imagePath: 'Assets/Images/GK.jpg',
//       cards: [
//         FlashCard(
//           question: "How many days are there in a leap year?",
//           answer: "366",
//         ),
//         FlashCard(
//           question: "How many colors are traditionally in a rainbow?",
//           answer: "Seven",
//         ),
//         FlashCard(
//           question: "What is the largest mammal in the world?",
//           answer: "Blue Whale",
//         ),
//         FlashCard(
//           question: "How many sides does a hexagon have?",
//           answer: "Six",
//         ),
//         FlashCard(question: "What is the currency of Japan?", answer: "Yen"),
//         FlashCard(
//           question: "What is the hardest natural substance?",
//           answer: "Diamond",
//         ),
//         FlashCard(
//           question: "How many continents are there?",
//           answer: "Seven",
//         ),
//         FlashCard(
//           question: "What is the fastest land animal?",
//           answer: "Cheetah",
//         ),
//         FlashCard(
//           question: "Which language has the most native speakers?",
//           answer: "Mandarin Chinese",
//         ),
//         FlashCard(
//           question: "What is the largest planet in our Solar System?",
//           answer: "Jupiter",
//         ),
//       ],
//     ),
//     FlashCardCategory(
//       title: " Space & Astronomy",
//       imagePath: 'Assets/Images/space.jpg',
//       cards: [
//         FlashCard(
//           question: "What is the closest star to Earth?",
//           answer: "The Sun",
//         ),
//         FlashCard(
//           question: "Which planet is closest to the Sun?",
//           answer: "Mercury",
//         ),
//         FlashCard(
//           question: "Which planet is known for its prominent rings?",
//           answer: "Saturn",
//         ),
//         FlashCard(
//           question: "How many planets are in our Solar System?",
//           answer: "Eight",
//         ),
//         FlashCard(
//           question: "What is Earth's natural satellite?",
//           answer: "The Moon",
//         ),
//         FlashCard(
//           question: "What galaxy contains our Solar System?",
//           answer: "Milky Way",
//         ),
//         FlashCard(
//           question: "What is the largest planet in our Solar System?",
//           answer: "Jupiter",
//         ),
//         FlashCard(
//           question: "Which planet is known as the Blue Planet?",
//           answer: "Earth",
//         ),
//         FlashCard(
//           question:
//           "What do we call a rocky object that enters Earth's atmosphere and produces a streak of light?",
//           answer: "Meteor",
//         ),
//         FlashCard(
//           question: "What is a black hole?",
//           answer:
//           "A region of space with extremely strong gravity from which light cannot escape",
//         ),
//       ],
//     ),
//     FlashCardCategory(
//       title: " Animals & Nature",
//       imagePath: 'Assets/Images/Animals.jpg',
//       cards: [
//         FlashCard(
//           question: "What is the largest land animal?",
//           answer: "African Elephant",
//         ),
//         FlashCard(
//           question: "Which animal is known as the King of the Jungle?",
//           answer: "Lion",
//         ),
//         FlashCard(
//           question: "What is the fastest land animal?",
//           answer: "Cheetah",
//         ),
//         FlashCard(question: "Which mammal can fly?", answer: "Bat"),
//         FlashCard(question: "What do bees produce?", answer: "Honey"),
//         FlashCard(
//           question: "Which animal is the largest living reptile?",
//           answer: "Saltwater Crocodile",
//         ),
//         FlashCard(question: "What is a baby frog called?", answer: "Tadpole"),
//         FlashCard(
//           question:
//           "Which bird is famous for its ability to mimic human speech?",
//           answer: "Parrot",
//         ),
//         FlashCard(
//           question: "What process do plants use to make their food?",
//           answer: "Photosynthesis",
//         ),
//         FlashCard(
//           question: "Which tree produces acorns?",
//           answer: "Oak tree",
//         ),
//       ],
//     ),
//     FlashCardCategory(
//       title: " English & Vocabulary",
//       imagePath: 'Assets/Images/English.jpg',
//       cards: [
//         FlashCard(
//           question: "What is the opposite of 'ancient'?",
//           answer: "Modern",
//         ),
//         FlashCard(
//           question: "What is a synonym of 'happy'?",
//           answer: "Joyful",
//         ),
//         FlashCard(
//           question: "What is the plural of 'child'?",
//           answer: "Children",
//         ),
//         FlashCard(
//           question: "What is the past tense of 'go'?",
//           answer: "Went",
//         ),
//         FlashCard(
//           question: "What is the opposite of 'expand'?",
//           answer: "Contract",
//         ),
//         FlashCard(
//           question: "What is a person who writes books called?",
//           answer: "Author",
//         ),
//         FlashCard(
//           question: "What is the synonym of 'rapid'?",
//           answer: "Fast",
//         ),
//         FlashCard(
//           question: "What is the opposite of 'victory'?",
//           answer: "Defeat",
//         ),
//         FlashCard(
//           question: "What is the comparative form of 'good'?",
//           answer: "Better",
//         ),
//         FlashCard(
//           question:
//           "What do we call a word that has the opposite meaning of another word?",
//           answer: "Antonym",
//         ),
//       ],
//     ),
//     FlashCardCategory(
//       title: " Sports",
//       imagePath: 'Assets/Images/Sports.jpg',
//       cards: [
//         FlashCard(
//           question:
//           "How many players are on the field for one football team at the start of a match?",
//           answer: "11",
//         ),
//         FlashCard(
//           question: "Which sport uses a bat, ball, and wickets?",
//           answer: "Cricket",
//         ),
//         FlashCard(
//           question: "How many players are on a basketball team on the court?",
//           answer: "Five",
//         ),
//         FlashCard(
//           question: "Which country hosted the 2016 Summer Olympics?",
//           answer: "Brazil",
//         ),
//         FlashCard(
//           question: "How many rings are on the Olympic flag?",
//           answer: "Five",
//         ),
//         FlashCard(
//           question: "Which sport is played at Wimbledon?",
//           answer: "Tennis",
//         ),
//         FlashCard(
//           question:
//           "How many points is a touchdown worth in American football before the extra point attempt?",
//           answer: "Six",
//         ),
//         FlashCard(
//           question: "Which sport uses a shuttlecock?",
//           answer: "Badminton",
//         ),
//         FlashCard(
//           question: "How many players are on a volleyball team on the court?",
//           answer: "Six",
//         ),
//         FlashCard(
//           question: "Which country is famous for the martial art of judo?",
//           answer: "Japan",
//         ),
//       ],
//     ),
//   ];
//
//   void _addNewCategory(FlashCardCategory newCat) async {
//     final categoryId = await sqliteDBHelper.insertCategory(newCat);
//     newCat.id = categoryId;
//     setState(() {
//       categories.add(newCat);
//     });
//   }
//
//   void _deleteCategory(int categoryId) async {
//     await sqliteDBHelper.deleteCategory(categoryId);
//     setState(() {
//       categories.removeWhere((cat) => cat.id == categoryId);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     void _showAddOptionsBottomSheet(BuildContext context) {
//       showModalBottomSheet(
//         context: context,
//         backgroundColor: const Color(0XFFF5EFE5),
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//         ),
//         builder: (context) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Text(
//                   "Create ",
//                   style: TextStyle(
//                     fontFamily: 'Poppins',
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0XFF422701),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 ListTile(
//                   leading: const Icon(Icons.folder_open, color: Color(0XFF422701)),
//                   title: const Text(
//                     "New Category",
//                     style: TextStyle(
//                       fontFamily: 'Poppins',
//                       fontSize: 14,
//                       color: Color(0XFF422701),
//                     ),
//                   ),
//                   subtitle: const Text(
//                     "Create a category like 'Biology' or 'Food'.",
//                     style: TextStyle(
//                       fontFamily: 'Poppins',
//                       fontSize: 12,
//                       color: Color(0XFF705E46),
//                     ),
//                   ),
//                   onTap: () {
//                     Navigator.pop(context);
//                     showAddCategoryDialog(
//                       context: context,
//                       onCategoryAdded: (newCategory) {
//                         _addNewCategory(newCategory);
//                       },
//                     );
//                   },
//                 ),
//                 const Divider(color: Color(0XFF422701)),
//                 ListTile(
//                   leading: const Icon(Icons.folder_open, color: Color(0XFF422701)),
//                   title: const Text(
//                     "New FlashCard",
//                     style: TextStyle(
//                       fontFamily: 'Poppins',
//                       fontSize: 14,
//                       color: Color(0XFF422701),
//                     ),
//                   ),
//                   subtitle: const Text(
//                     "Add a card to an existing category",
//                     style: TextStyle(
//                       fontFamily: 'Poppins',
//                       fontSize: 12,
//                       color: Color(0XFF705E46),
//                     ),
//                   ),
//                   enabled: categories.isNotEmpty,
//                   onTap: () {
//                     Navigator.pop(context);
//                     showAddCardDialog(
//                       context: context,
//                       categories: categories,
//                       onCardAdded: (targetCategory, newCard) async {
//                         if (targetCategory.id != null) {
//                           final cardId = await sqliteDBHelper.insertCard(newCard, targetCategory.id!);
//                           final savedCard = FlashCard(
//                             id: cardId,
//                             question: newCard.question,
//                             answer: newCard.answer,
//                           );
//                           setState(() {
//                             targetCategory.cards.add(savedCard);
//                           });
//                         }
//                       },
//                     );
//                   },
//                 ),
//               ],
//             ),
//           );
//         },
//       );
//     }
//
//     return Scaffold(
//       backgroundColor: const Color(0XFFF5EFE5),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: const Color(0XFF422701),
//         shape: const CircleBorder(),
//         onPressed: () {
//           _showAddOptionsBottomSheet(context);
//         },
//         child: const Icon(Icons.add, size: 30, color: Color(0xFFFFFFFF)),
//       ),
//       appBar: AppBar(
//         backgroundColor: const Color(0XFF422701),
//         elevation: 0,
//         centerTitle: true,
//         title: const Row(
//           children: [
//             Text(
//               "FlashCards",
//               style: TextStyle(
//                 fontFamily: 'Poppins',
//                 color: Color(0XFFFFFFFF),
//                 height: 1.8,
//                 fontWeight: FontWeight.w600,
//                 fontSize: 18,
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: isLoading
//             ? const Center(child: CircularProgressIndicator())
//             : categories.isEmpty
//                 ? const Center(
//                     child: Text(
//                       "No categories yet! Tap + to add.",
//                       style: TextStyle(
//                         fontFamily: "Poppins",
//                         color: Color(0XFF422701),
//                         fontSize: 16,
//                       ),
//                     ),
//                   )
//                 : ListView.builder(
//                     itemCount: categories.length,
//                     itemBuilder: (context, index) {
//                       final categoryCard = categories[index];
//
//                       return Card(
//                         margin: const EdgeInsets.only(bottom: 12),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(18.0),
//                           side: const BorderSide(
//                             color: Color(0XFF705E46),
//                             width: 1.2,
//                           ),
//                         ),
//                         elevation: 4,
//                         shadowColor: Colors.black54,
//                         color: const Color(0XFFFFF9EF),
//                         child: InkWell(
//                           borderRadius: BorderRadius.circular(18.0),
//                           onTap: () async {
//                             await Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => CardScreen(
//                                   categoryCard.cards,
//                                   categoryCard.title,
//                                   categoryCard.id ?? 0,
//                                 ),
//                               ),
//                             );
//                             _loadCategories();
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 12,
//                               vertical: 12,
//                             ),
//                             child: Row(
//                               children: [
//                                 () {
//                                   Widget? imageWidget;
//                                   if (categoryCard.imagePath.startsWith('Assets/')) {
//                                     imageWidget = Image.asset(
//                                       categoryCard.imagePath,
//                                       fit: BoxFit.cover,
//                                     );
//                                   } else if (categoryCard.imagePath.isNotEmpty &&
//                                       categoryCard.imagePath != 'avatar' &&
//                                       File(categoryCard.imagePath).existsSync()) {
//                                     imageWidget = Image.file(
//                                       File(categoryCard.imagePath),
//                                       fit: BoxFit.cover,
//                                     );
//                                   }
//
//                                   if (imageWidget != null) {
//                                     return Container(
//                                       width: 52,
//                                       height: 52,
//                                       decoration: const BoxDecoration(
//                                         color: Color(0xFFEFE6D8),
//                                         shape: BoxShape.circle,
//                                       ),
//                                       child: ClipOval(
//                                         child: imageWidget,
//                                       ),
//                                     );
//                                   } else {
//                                     return CategoryAvatar(
//                                       title: categoryCard.title,
//                                       size: 52,
//                                     );
//                                   }
//                                 }(),
//                                 const SizedBox(width: 12),
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       Text(
//                                         categoryCard.title,
//                                         style: const TextStyle(
//                                           fontFamily: 'Poppins',
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold,
//                                           color: Color(0XFF422701),
//                                         ),
//                                       ),
//                                       const SizedBox(height: 6),
//                                       Text(
//                                         "${categoryCard.cards.length} Cards",
//                                         style: const TextStyle(
//                                           fontFamily: 'Poppins',
//                                           fontSize: 14,
//                                           color: Color(0XFF705E46),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     IconButton(
//                                       icon: const Icon(
//                                         Icons.edit,
//                                         size: 20,
//                                         color: Color(0XFF422701),
//                                       ),
//                                       onPressed: () async {
//                                         await Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (context) => EditCategoryScreen(
//                                               category: categoryCard,
//                                             ),
//                                           ),
//                                         );
//                                         _loadCategories();
//                                       },
//                                     ),
//                                     const Icon(
//                                       Icons.arrow_forward_ios_rounded,
//                                       size: 22,
//                                       color: Color(0XFF422701),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:quiz_app/CardScreen.dart';
import 'package:quiz_app/CategoryAvatar.dart';
import 'package:quiz_app/Dialogs/add_card_dialog.dart';
import 'package:quiz_app/EditCategoryScreen.dart';
import 'package:quiz_app/FlashCardCategory.dart';
import 'package:quiz_app/Dialogs/add_category_dialog.dart';
import 'package:quiz_app/FlashCard.dart';
import 'package:quiz_app/main.dart'; // SQLiteDBHelper instance (sqliteDBHelper)

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<FlashCardCategory> categories = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCategoriesFromDB();
  }

  // Smart load: If DB is empty OR only contains corrupt/stale zero-card data from prior tests, re-seed defaults!
  Future<void> _loadCategoriesFromDB() async {
    setState(() => _isLoading = true);
    List<FlashCardCategory> dbCategories = await sqliteDBHelper.getCategories();

    // Check total card count across all retrieved categories
    int totalCards = dbCategories.fold(0, (sum, cat) => sum + cat.cards.length);

    // If database has fewer than 10 categories OR total cards is 0, clear stale data and re-seed
    if (dbCategories.length < 10 || totalCards == 0) {
      // Clear out stale/corrupt categories from previous tests
      for (var cat in dbCategories) {
        if (cat.id != null) {
          await sqliteDBHelper.deleteCategory(cat.id!);
        }
      }

      // Populate all 10 categories with 10 cards each
      await _seedDefaultCategories();
      dbCategories = await sqliteDBHelper.getCategories();
    }

    setState(() {
      categories = dbCategories;
      _isLoading = false;
    });
  }

  Future<void> _seedDefaultCategories() async {
    List<FlashCardCategory> defaultCategories = [
      FlashCardCategory(
        title: "Islamic Knowledge",
        imagePath: 'Assets/Images/Islamic knowledge.jpg',
        cards: [
          FlashCard(question: "How many obligatory prayers are there in Islam each day?", answer: "Five"),
          FlashCard(question: "How many Surahs are there in the Quran?", answer: "114"),
          FlashCard(question: "Which is the longest Surah in the Quran?", answer: "Surah Al-Baqarah"),
          FlashCard(question: "Which is the shortest Surah in the Quran?", answer: "Surah Al-Kawthar"),
          FlashCard(question: "In which year was the Hijrah?", answer: "622 CE"),
          FlashCard(question: "In which city was Prophet Muhammad ﷺ born?", answer: "Makkah"),
          FlashCard(question: "What is the first month of the Islamic calendar?", answer: "Muharram"),
          FlashCard(question: "Which month do Muslims fast during?", answer: "Ramadan"),
          FlashCard(question: "Who was the first person to receive revelation from Allah through Angel Jibril?", answer: "Prophet Muhammad ﷺ"),
          FlashCard(question: "What is the pilgrimage to Makkah called?", answer: "Hajj"),
        ],
      ),
      FlashCardCategory(
        title: "World Geography",
        imagePath: 'Assets/Images/world geography.jpg',
        cards: [
          FlashCard(question: "What is the largest continent?", answer: "Asia"),
          FlashCard(question: "What is the capital of Japan?", answer: "Tokyo"),
          FlashCard(question: "What is the largest ocean in the world?", answer: "Pacific Ocean"),
          FlashCard(question: "Which country is known as the Land of the Rising Sun?", answer: "Japan"),
          FlashCard(question: "What is the capital of Australia?", answer: "Canberra"),
          FlashCard(question: "What is the largest hot desert in the world?", answer: "Sahara Desert"),
          FlashCard(question: "What is the smallest country in the world?", answer: "Vatican City"),
          FlashCard(question: "Which continent is Egypt primarily located in?", answer: "Africa"),
          FlashCard(question: "What is the capital of Pakistan?", answer: "Islamabad"),
          FlashCard(question: "Which mountain is the highest in the world?", answer: "Mount Everest"),
        ],
      ),
      FlashCardCategory(
        title: "Science",
        imagePath: 'Assets/Images/Science.jpg',
        cards: [
          FlashCard(question: "What is H₂O commonly known as?", answer: "Water"),
          FlashCard(question: "Which planet is known as the Red Planet?", answer: "Mars"),
          FlashCard(question: "What gas do humans need to breathe?", answer: "Oxygen"),
          FlashCard(question: "What force pulls objects toward Earth?", answer: "Gravity"),
          FlashCard(question: "What is the center of an atom called?", answer: "Nucleus"),
          FlashCard(question: "Which organ pumps blood around the human body?", answer: "Heart"),
          FlashCard(question: "What is the boiling point of water at sea level?", answer: "100°C"),
          FlashCard(question: "Which vitamin is produced when the skin is exposed to sunlight?", answer: "Vitamin D"),
          FlashCard(question: "What is the largest organ of the human body?", answer: "Skin"),
          FlashCard(question: "How many bones are in an average adult human body?", answer: "206"),
        ],
      ),
      FlashCardCategory(
        title: "Computer & Technology",
        imagePath: 'Assets/Images/IT.jpg',
        cards: [
          FlashCard(question: "What does CPU stand for?", answer: "Central Processing Unit"),
          FlashCard(question: "What does RAM stand for?", answer: "Random Access Memory"),
          FlashCard(question: "What does HTML stand for?", answer: "HyperText Markup Language"),
          FlashCard(question: "What does CSS stand for?", answer: "Cascading Style Sheets"),
          FlashCard(question: "What does URL stand for?", answer: "Uniform Resource Locator"),
          FlashCard(question: "What does AI stand for?", answer: "Artificial Intelligence"),
          FlashCard(question: "What is the main function of an operating system?", answer: "Manage computer hardware and software"),
          FlashCard(question: "Which company developed the Android operating system?", answer: "Google"),
          FlashCard(question: "What does USB stand for?", answer: "Universal Serial Bus"),
          FlashCard(question: "What is a computer program?", answer: "A set of instructions executed by a computer"),
        ],
      ),
      FlashCardCategory(
        title: "History",
        imagePath: 'Assets/Images/History.jpg',
        cards: [
          FlashCard(question: "Who was the founder of Pakistan?", answer: "Muhammad Ali Jinnah"),
          FlashCard(question: "In which year did Pakistan gain independence?", answer: "1947"),
          FlashCard(question: "In which year did World War II end?", answer: "1945"),
          FlashCard(question: "Which ancient civilization built the pyramids of Giza?", answer: "Ancient Egyptians"),
          FlashCard(question: "Which ancient city was destroyed by Mount Vesuvius in 79 CE?", answer: "Pompeii"),
          FlashCard(question: "Who discovered penicillin?", answer: "Alexander Fleming"),
          FlashCard(question: "Where did democracy develop in ancient Greece?", answer: "Athens"),
          FlashCard(question: "Who was the first Governor-General of Pakistan?", answer: "Muhammad Ali Jinnah"),
          FlashCard(question: "What was the Silk Road?", answer: "A network of trade routes connecting East and West"),
          FlashCard(question: "Which wall divided Berlin during the Cold War?", answer: "Berlin Wall"),
        ],
      ),
      FlashCardCategory(
        title: "General Knowledge",
        imagePath: 'Assets/Images/GK.jpg',
        cards: [
          FlashCard(question: "How many days are there in a leap year?", answer: "366"),
          FlashCard(question: "How many colors are traditionally in a rainbow?", answer: "Seven"),
          FlashCard(question: "What is the largest mammal in the world?", answer: "Blue Whale"),
          FlashCard(question: "How many sides does a hexagon have?", answer: "Six"),
          FlashCard(question: "What is the currency of Japan?", answer: "Yen"),
          FlashCard(question: "What is the hardest natural substance?", answer: "Diamond"),
          FlashCard(question: "How many continents are there?", answer: "Seven"),
          FlashCard(question: "What is the fastest land animal?", answer: "Cheetah"),
          FlashCard(question: "Which language has the most native speakers?", answer: "Mandarin Chinese"),
          FlashCard(question: "What is the largest planet in our Solar System?", answer: "Jupiter"),
        ],
      ),
      FlashCardCategory(
        title: "Space & Astronomy",
        imagePath: 'Assets/Images/space.jpg',
        cards: [
          FlashCard(question: "What is the closest star to Earth?", answer: "The Sun"),
          FlashCard(question: "Which planet is closest to the Sun?", answer: "Mercury"),
          FlashCard(question: "Which planet is known for its prominent rings?", answer: "Saturn"),
          FlashCard(question: "How many planets are in our Solar System?", answer: "Eight"),
          FlashCard(question: "What is Earth's natural satellite?", answer: "The Moon"),
          FlashCard(question: "What galaxy contains our Solar System?", answer: "Milky Way"),
          FlashCard(question: "What is the largest planet in our Solar System?", answer: "Jupiter"),
          FlashCard(question: "Which planet is known as the Blue Planet?", answer: "Earth"),
          FlashCard(question: "What do we call a rocky object that enters Earth's atmosphere and produces a streak of light?", answer: "Meteor"),
          FlashCard(question: "What is a black hole?", answer: "A region of space with extremely strong gravity from which light cannot escape"),
        ],
      ),
      FlashCardCategory(
        title: "Animals & Nature",
        imagePath: 'Assets/Images/Animals.jpg',
        cards: [
          FlashCard(question: "What is the largest land animal?", answer: "African Elephant"),
          FlashCard(question: "Which animal is known as the King of the Jungle?", answer: "Lion"),
          FlashCard(question: "What is the fastest land animal?", answer: "Cheetah"),
          FlashCard(question: "Which mammal can fly?", answer: "Bat"),
          FlashCard(question: "What do bees produce?", answer: "Honey"),
          FlashCard(question: "Which animal is the largest living reptile?", answer: "Saltwater Crocodile"),
          FlashCard(question: "What is a baby frog called?", answer: "Tadpole"),
          FlashCard(question: "Which bird is famous for its ability to mimic human speech?", answer: "Parrot"),
          FlashCard(question: "What process do plants use to make their food?", answer: "Photosynthesis"),
          FlashCard(question: "Which tree produces acorns?", answer: "Oak tree"),
        ],
      ),
      FlashCardCategory(
        title: "English & Vocabulary",
        imagePath: 'Assets/Images/English.jpg',
        cards: [
          FlashCard(question: "What is the opposite of 'ancient'?", answer: "Modern"),
          FlashCard(question: "What is a synonym of 'happy'?", answer: "Joyful"),
          FlashCard(question: "What is the plural of 'child'?", answer: "Children"),
          FlashCard(question: "What is the past tense of 'go'?", answer: "Went"),
          FlashCard(question: "What is the opposite of 'expand'?", answer: "Contract"),
          FlashCard(question: "What is a person who writes books called?", answer: "Author"),
          FlashCard(question: "What is the synonym of 'rapid'?", answer: "Fast"),
          FlashCard(question: "What is the opposite of 'victory'?", answer: "Defeat"),
          FlashCard(question: "What is the comparative form of 'good'?", answer: "Better"),
          FlashCard(question: "What do we call a word that has the opposite meaning of another word?", answer: "Antonym"),
        ],
      ),
      FlashCardCategory(
        title: "Sports",
        imagePath: 'Assets/Images/Sports.jpg',
        cards: [
          FlashCard(question: "How many players are on the field for one football team at the start of a match?", answer: "11"),
          FlashCard(question: "Which sport uses a bat, ball, and wickets?", answer: "Cricket"),
          FlashCard(question: "How many players are on a basketball team on the court?", answer: "Five"),
          FlashCard(question: "Which country hosted the 2016 Summer Olympics?", answer: "Brazil"),
          FlashCard(question: "How many rings are on the Olympic flag?", answer: "Five"),
          FlashCard(question: "Which sport is played at Wimbledon?", answer: "Tennis"),
          FlashCard(question: "How many points is a touchdown worth in American football before the extra point attempt?", answer: "Six"),
          FlashCard(question: "Which sport uses a shuttlecock?", answer: "Badminton"),
          FlashCard(question: "How many players are on a volleyball team on the court?", answer: "Six"),
          FlashCard(question: "Which country is famous for the martial art of judo?", answer: "Japan"),
        ],
      ),
    ];

    for (var cat in defaultCategories) {
      await sqliteDBHelper.insertCategory(cat);
    }
  }

  void _addNewCategory(FlashCardCategory newCat) async {
    await sqliteDBHelper.insertCategory(newCat);
    await _loadCategoriesFromDB();
  }

  void _addNewCardToCategory(FlashCardCategory targetCategory, FlashCard newCard) async {
    if (targetCategory.id != null) {
      await sqliteDBHelper.insertCard(newCard, targetCategory.id!);
      await _loadCategoriesFromDB();
    }
  }

  void _deleteCategory(int categoryId) async {
    await sqliteDBHelper.deleteCategory(categoryId);
    await _loadCategoriesFromDB();
  }

  Widget _buildCategoryImage(String imagePath, String title) {
    if (imagePath.isNotEmpty && imagePath.startsWith('Assets/')) {
      return Image.asset(
        imagePath,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => CategoryAvatar(title: title, size: 52),
      );
    } else if (imagePath.isNotEmpty && File(imagePath).existsSync()) {
      return Image.file(
        File(imagePath),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => CategoryAvatar(title: title, size: 52),
      );
    }
    return CategoryAvatar(title: title, size: 52);
  }

  void _showAddOptionsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0XFFF5EFE5),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Create New Item",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0XFF422701),
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.folder_open, color: Color(0XFF422701)),
                title: const Text(
                  "New Category",
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 14, color: Color(0XFF422701)),
                ),
                subtitle: const Text(
                  "Create a category like 'Biology' or 'Food'.",
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 12, color: Color(0XFF705E46)),
                ),
                onTap: () {
                  Navigator.pop(context);
                  showAddCategoryDialog(
                    context: context,
                    onCategoryAdded: (newCategory) {
                      _addNewCategory(newCategory);
                    },
                  );
                },
              ),
              const Divider(color: Color(0XFF422701)),
              ListTile(
                leading: const Icon(Icons.style_outlined, color: Color(0XFF422701)),
                title: const Text(
                  "New FlashCard",
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 14, color: Color(0XFF422701)),
                ),
                subtitle: const Text(
                  "Add a card to an existing category",
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 12, color: Color(0XFF705E46)),
                ),
                enabled: categories.isNotEmpty,
                onTap: () {
                  Navigator.pop(context);
                  showAddCardDialog(
                    context: context,
                    categories: categories,
                    onCardAdded: (targetCategory, newCard) {
                      _addNewCardToCategory(targetCategory, newCard);
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFF5EFE5),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0XFF422701),
        shape: const CircleBorder(),
        onPressed: () => _showAddOptionsBottomSheet(context),
        child: const Icon(Icons.add, size: 30, color: Color(0xFFFFFFFF)),
      ),
      appBar: AppBar(
        backgroundColor: const Color(0XFF422701),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "FlashCards",
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Color(0XFFFFFFFF),
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0XFF422701)))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: categories.isEmpty
            ? const Center(
          child: Text(
            "No categories yet! Tap + to add.",
            style: TextStyle(
              fontFamily: "Poppins",
              color: Color(0XFF422701),
              fontSize: 16,
            ),
          ),
        )
            : ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final categoryCard = categories[index];

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: const BorderSide(
                  color: Color(0XFF705E46),
                  width: 1.2,
                ),
              ),
              elevation: 4,
              shadowColor: Colors.black54,
              color: const Color(0XFFFFF9EF),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                leading: Container(
                  width: 52,
                  height: 52,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEFE6D8),
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: _buildCategoryImage(categoryCard.imagePath, categoryCard.title),
                  ),
                ),
                title: Text(
                  categoryCard.title,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0XFF422701),
                  ),
                ),
                subtitle: Text(
                  "${categoryCard.cards.length} Cards",
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: Color(0XFF705E46),
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.edit,
                        size: 20,
                        color: Color(0XFF422701),
                      ),
                      onPressed: () async {
                        final isUpdated = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditCategoryScreen(
                              category: categoryCard,
                            ),
                          ),
                        );
                        if (isUpdated == true) {
                          await _loadCategoriesFromDB();
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.delete,
                        size: 20,
                        color: Colors.redAccent,
                      ),
                      onPressed: () async {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Delete Category"),
                            content: Text(
                              "Are you sure you want to delete '${categoryCard.title}' and all its flashcards?",
                            ),
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

                        if (confirm == true && categoryCard.id != null) {
                          _deleteCategory(categoryCard.id!);
                        }
                      },
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 18,
                      color: Color(0XFF422701),
                    ),
                  ],
                ),
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CardScreen(
                        categoryCard.cards,
                        categoryCard.title,
                        categoryCard.id ?? 0,
                      ),
                    ),
                  );
                  await _loadCategoriesFromDB();
                },
              ),
            );
          },
        ),
      ),
    );
  }
}