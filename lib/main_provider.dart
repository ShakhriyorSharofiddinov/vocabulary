import 'package:flutter/cupertino.dart';

import 'database_helper.dart';
import 'models/word.dart';

class MainProvider extends ChangeNotifier {
  final List<Word> words = [];
  bool showCity = false;

  initList({String? word, bool? isCity}) async {
    words.clear();
    notifyListeners();
  }

  change() {
    showCity = !showCity;
    notifyListeners();
  }
}
