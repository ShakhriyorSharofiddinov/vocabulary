import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vocabulary/utils/constants.dart';
import 'package:path/path.dart' as path;
import 'dart:io' as io;

import 'models/word.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();

  static Database? _db;

  DatabaseHelper._instance();

  final String tableName = "en_uz";
  final String colId = 'id';
  final String colEnWord = 'enWord';
  final String colType = 'type';
  final String colTranslation = 'translation';
  final String colDescription = 'description';
  final String colCountable = 'countable';
  final String colFavourite = 'favourite';
  //
  // Future<Database?> get db async {
  //   return _db ?? await _initDB();
  // }

  Future<void> init() async {
    io.Directory applicationDirectory =
    await getApplicationDocumentsDirectory();

    String dbPathEnglish =
    path.join(applicationDirectory.path, "englishDictionary.db");

    bool dbExistsEnglish = await io.File(dbPathEnglish).exists();

    if (!dbExistsEnglish) {
      // Copy from asset
      ByteData data = await rootBundle.load(path.join("assets", "dictionary.db"));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await io.File(dbPathEnglish).writeAsBytes(bytes, flush: true);
    }

    _db = await openDatabase(dbPathEnglish);


    print("DTATABASE UPDATE");
    print(_db?.path.toString());
    Future <List<Word>> list = getAllTheWordsEnglish();
    print(list);

  }

  /// get all the words from english dictionary
  Future<List<Word>> getAllTheWordsEnglish() async {
    if (_db == null) {
      throw "bd is not initiated, initiate using [init(db)] function";
    }
    List<Map<String,dynamic>> words = [];

    await _db?.transaction((txn) async {
      words = await txn.query(
        "eng_uz",
        columns: [
          "id"
          "enWord"
          "type"
          "translation"
          "description"
          "countable"
          "favourite"
        ],
      );
    });

    return words.map((e) => Word.fromJson(e)).toList();
  }


  // Future<Database?> _initDB() async {
  //   Directory documentsDirectory = await getApplicationDocumentsDirectory();
  //   String path = "${documentsDirectory.path}en_uz.db";
  //   _db = await openDatabase(path, version: 1, onOpen: (db) {},
  //       onCreate: (Database db, int version) async {
  //     await db.execute("CREATE TABLE $tableName ("
  //         "$colId INTEGER PRIMARY KEY,"
  //         "$colEnWord TEXT,"
  //         "$colType TEXT,"
  //         "$colTranslation TEXT,"
  //         "$colDescription TEXT,"
  //         "$colCountable TEXT,"
  //         "$colFavourite INTEGER,"
  //         ")");
  //   });
  //   return _db;
  // }
  //
  // Future<void> loadDB(context) async {
  //   print("DATABASE LOADED");
  //
  //   String data =
  //       await DefaultAssetBundle.of(context).loadString("assets/capitals.json");
  //   final jsonResult = jsonDecode(data);
  //
  //   List<Word> capitals = jsonResult.map<Word>((data) {
  //     return Word.fromJson(data);
  //   }).toList();
  //
  //   for (var word in capitals) {
  //     await insert(word);
  //   }
  //   saveState();
  //
  // }
  //
  // Future<void> saveState() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool(Constants.IS_DATABASE_INIT, true);
  // }
  //
  // Future<Word> insert(Word word) async {
  //   final data = await db;
  //   word.id = await data?.insert(tableName, word.toMap());
  //   return word;
  // }
  //
  // Future<List<Map<String, Object?>>?> getWordMap(
  //     {String? word, bool? isCity}) async {
  //   final data = await db;
  //   final List<Map<String, Object?>>? result;
  //   if (word == null) {
  //     result = await data?.query(tableName);
  //   } else {
  //     result = await data?.query(
  //       tableName,
  //       where: word,
  //       whereArgs: ["$word%"],
  //     );
  //   }
  //   return result;
  // }
  //
  // Future<List<Word>> getWords() async {
  //   final List<Map<String, Object?>>? wordMap = await getWordMap();
  //   final List<Word> words = [];
  //   wordMap?.forEach((element) {
  //     words.add(Word.fromMap(element));
  //   });
  //   return words;
  // }
  //
  // Future<int?> update(Word word) async {
  //   final data = await db;
  //   return await data?.update(tableName, word.toMap(),
  //       where: '$colId = ?', whereArgs: [word.id]);
  // }
  //
  // Future<int?> delete(int wordId) async {
  //   final data = await db;
  //   return await data?.delete(
  //     tableName,
  //     where: '$colId = ?',
  //     whereArgs: [wordId],
  //   );
  // }
  //
  // Future<List<Word>> getWordLike(String word, bool isCity) async {
  //   final List<Map<String, Object?>>? wordMap =
  //       await getWordMap(word: word, isCity: isCity);
  //   final List<Word> words = [];
  //   wordMap?.forEach((element) {
  //     words.add(Word.fromMap(element));
  //   });
  //   return words;
  // }
}
