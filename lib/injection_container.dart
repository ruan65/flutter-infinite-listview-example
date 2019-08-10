import 'package:infinite_listview_example/data/generator/list_data_source.dart';
import 'package:kiwi/kiwi.dart';

import 'ui/list/list.dart';

void initKiwi() {
  Container().registerFactory((c) => ListDataSource());
  Container().registerFactory((c) => ListBloc(c.resolve()));
}