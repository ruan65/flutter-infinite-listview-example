import 'dart:math';

import 'package:built_collection/built_collection.dart';
import 'package:infinite_listview_example/data/model/list_item.dart';

class ListDataSource {
  static const int ITEMS_PER_PAGE = 20;
  static const int PAGE_COUNT = 5;

  static final rnd = Random();

  int _showPagesCount = 0;

  Future<BuiltList<ListItem>> getNextListPage() async {

    if(_showPagesCount > PAGE_COUNT) {

      throw NoNextPageException();
    }
    _showPagesCount++;

    await Future.delayed(Duration(milliseconds: 750));

    return BuiltList.of(List.generate(ITEMS_PER_PAGE, _generateListItem));
  }

  ListItem _generateListItem(int index) {
    return ListItem((b) => b
      ..title = '$index Lorem ipsum'
      ..colorInt = rnd.nextInt(0xFFFFFFFF));
  }
}

class NoNextPageException implements Exception {}
