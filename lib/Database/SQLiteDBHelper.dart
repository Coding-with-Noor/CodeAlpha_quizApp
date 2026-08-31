import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:quiz_app/FlashCardCategory.dart';
import 'package:quiz_app/FlashCard.dart';

class SQLiteDBHelper {
  Database? _db;

  Future<Database> getDatabase() async {
    if (_db != null && _db!.isOpen) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    String dbPath = join(await getDatabasesPath(), 'FlashCard_quiz.db');

    return await openDatabase(
      dbPath,
      version: 1,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS categories (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title VARCHAR(255) NOT NULL,
            imagePath TEXT NOT NULL
          )
        ''');

        await db.execute('''
          CREATE TABLE IF NOT EXISTS flashcards (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            categoryId INTEGER NOT NULL,
            question TEXT NOT NULL,
            answer TEXT NOT NULL,
            FOREIGN KEY (categoryId) REFERENCES categories (id) ON DELETE CASCADE
          )
        ''');
      },
    );
  }

  // ================= CATEGORY OPERATIONS =================

  // CREATE Category
  Future<int> insertCategory(FlashCardCategory category) async {
    final db = await getDatabase();
    int categoryId = await db.insert('categories', category.toMap());

    for (var card in category.cards) {
      await insertCard(card, categoryId);
    }

    return categoryId;
  }

  // READ All Categories
  Future<List<FlashCardCategory>> getCategories() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> categoryMaps = await db.query('categories');

    List<FlashCardCategory> categoriesList = [];

    for (var catMap in categoryMaps) {
      int categoryId = catMap['id'] is int
          ? catMap['id']
          : int.parse(catMap['id'].toString());

      List<FlashCard> cards = await getCardsForCategory(categoryId);

      categoriesList.add(
        FlashCardCategory(
          id: categoryId,
          title: catMap['title']?.toString() ?? '',
          imagePath: catMap['imagePath']?.toString() ?? '',
          cards: cards,
        ),
      );
    }

    return categoriesList;
  }

  // UPDATE Category (Accepts primitive arguments matching UI)
  Future<int> updateCategory(int id, String newTitle, String imagePath) async {
    final db = await getDatabase();
    return await db.update(
      'categories',
      {
        'title': newTitle,
        'imagePath': imagePath,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // DELETE Category
  Future<int> deleteCategory(int categoryId) async {
    final db = await getDatabase();
    return await db.delete('categories', where: 'id = ?', whereArgs: [categoryId]);
  }

  // ================= FLASHCARD OPERATIONS =================

  // CREATE Flashcard
  Future<int> insertCard(FlashCard card, int categoryId) async {
    final db = await getDatabase();
    return await db.insert('flashcards', {
      'categoryId': categoryId,
      'question': card.question,
      'answer': card.answer,
    });
  }

  // READ Cards for Category
  Future<List<FlashCard>> getCardsForCategory(int categoryId) async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> cardMaps = await db.query(
      'flashcards',
      where: 'categoryId = ?',
      whereArgs: [categoryId],
    );

    return cardMaps.map((map) {
      return FlashCard(
        id: map['id'] is int ? map['id'] : int.tryParse(map['id']?.toString() ?? '0'),
        question: map['question']?.toString() ?? '',
        answer: map['answer']?.toString() ?? '',
      );
    }).toList();
  }

  // UPDATE Flashcard (Accepts primitive arguments matching UI)
  Future<int> updateCard(int id, String question, String answer) async {
    final db = await getDatabase();
    return await db.update(
      'flashcards',
      {
        'question': question,
        'answer': answer,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // DELETE Flashcard
  Future<int> deleteCard(int cardId) async {
    final db = await getDatabase();
    return await db.delete('flashcards', where: 'id = ?', whereArgs: [cardId]);
  }
}