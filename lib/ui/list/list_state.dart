library list_state;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:infinite_listview_example/data/model/list_item.dart';
import 'package:infinite_listview_example/ui/list/list_bloc.dart';

part 'list_state.g.dart';

abstract class ListState implements Built<ListState, ListStateBuilder> {
  BuiltList<ListItem> get listItems;

  bool get hasReachedEndOfResults;

  ListState._();

  factory ListState([updates(ListStateBuilder b)]) = _$ListState;

  factory ListState.initial() {
    return ListState((b) => b
      ..listItems.replace(BuiltList<ListItem>())
      ..hasReachedEndOfResults = false);
  }

  factory ListState.success(BuiltList<ListItem> items) {
    return ListState((b) => b
      ..listItems.replace(BuiltList<ListItem>(items))
      ..hasReachedEndOfResults = false);
  }
}
