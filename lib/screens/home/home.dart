import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vocabulary/database_helper.dart';
import 'package:vocabulary/screens/home/widgets/word_list.dart';

import '../../main.dart';
import '../../main_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  bool _isCity = false;
  bool _isDark = false;
  String searchQuery = "Search query";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseHelper.instance.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: _isSearching ? const BackButton() : Container(),
          title: _isSearching ? _buildSearchField() : const Text("Dictionary"),
          actions: _buildActions()),
      body: const WordList(),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchQueryController,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: "Search Data...",
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white54),
      ),
      style: const TextStyle(color: Colors.white, fontSize: 24.0),
      onChanged: (query) => updateSearchQuery(query),
    );
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (_searchQueryController == null ||
                _searchQueryController.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),
      IconButton(
        onPressed: () {
          final mainProvider =
              Provider.of<MainProvider>(context, listen: false);
          mainProvider.change();
          _isCity = !_isCity;
        },
        icon: const Icon(Icons.switch_access_shortcut_rounded),
      ),
      IconButton(
        onPressed: () {
          setState(() {
            _isDark = !_isDark;
            ThemeStream.setTheme.add(_isDark);
          });
        },
        icon: _isDark
            ? const Icon(Icons.dark_mode)
            : const Icon(Icons.dark_mode_outlined),
      ),
    ];
  }

  void _startSearch() {
    ModalRoute.of(context)?.addLocalHistoryEntry(
      LocalHistoryEntry(onRemove: _stopSearching),
    );

    setState(() {
      _isSearching = true;
    });
  }

  void updateSearchQuery(String newQuery) {
    searchQuery = newQuery;
    updateQuery(word: searchQuery);
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
      updateSearchQuery("");
    });
  }

  void updateQuery({String? word}) {
    final mainProvider = Provider.of<MainProvider>(context, listen: false);
    mainProvider.initList(word: word, isCity: _isCity);
  }
}
