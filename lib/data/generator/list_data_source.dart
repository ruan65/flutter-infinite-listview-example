import 'dart:math';

import 'package:built_collection/built_collection.dart';
import 'package:infinite_listview_example/data/model/list_item.dart';

class ListDataSource {
  static const int ITEMS_PER_PAGE = 20;
  static const int MAX_PAGE_COUNT = 5;

  static final rnd = Random();

  int _showPagesCount = 0;

  Future<BuiltList<ListItem>> getNextListPage() async {

    _showPagesCount++;

    if(_showPagesCount > MAX_PAGE_COUNT) {

      throw NoNextPageException();
    }

    await Future.delayed(Duration(milliseconds: 750));

    return BuiltList.of(List.generate(ITEMS_PER_PAGE, _generateListItem));
  }

  ListItem _generateListItem(int index) {
    return ListItem((b) => b
      ..title = 'item #$index on the Page $_showPagesCount'
      ..colorInt = rnd.nextInt(0xFFFFFFFF));
  }
}

class NoNextPageException implements Exception {}
