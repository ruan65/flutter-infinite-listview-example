library list_item;

import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'list_item.g.dart';

abstract class ListItem
    implements Built<ListItem, ListItemBuilder> {

  String get title;
  int get colorInt;

  ListItem._();

  factory ListItem([updates(ListItemBuilder b)]) = _$ListItem;

//  String toJson() {
//    return json
//        .encode(serializers.serializeWith(ListItem.serializer, this));
//  }
//
//  static ListItem fromJson(String jsonString) {
//    return serializers.deserializeWith(
//        ListItem.serializer, json.decode(jsonString));
//  }
//
//  static Serializer<ListItem> get serializer => _$listItemSerializer;
}