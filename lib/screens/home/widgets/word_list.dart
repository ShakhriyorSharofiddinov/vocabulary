import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vocabulary/screens/home/widgets/word_item.dart';

import '../../../database_helper.dart';
import '../../../main_provider.dart';
import '../../../utils/constants.dart';

class WordList extends StatefulWidget {
  const WordList({Key? key}) : super(key: key);

  @override
  State<WordList> createState() => _WordListState();
}

class _WordListState extends State<WordList> {
  @override
  void initState() {
    super.initState();
    loadDB();
  }

  Future<void> loadDB() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoaded = prefs.getBool(Constants.IS_DATABASE_INIT) ?? false;

    if (!isLoaded) {
      await DatabaseHelper.instance.init();
    }
    updateQuery();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .9,
      child: Consumer<MainProvider>(builder: (context, data, child) {
        return Scrollbar(
          isAlwaysShown: true,
          thickness: 12.0,
          hoverThickness: 12,
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 10),
            itemBuilder: (context, index) {
              return Container(
                color: Colors.green,
                width: 100,
                height: 100,
              );
              // return WordItem(data.words[index], data.showCity);
            },
            itemCount: data.words.length,
          ),
        );
      }),
    );
  }

  void updateQuery({String? word, bool? isCity}) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    mainProvider.initList(word: word, isCity: isCity);
  }
}
