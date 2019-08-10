import 'package:bloc/bloc.dart';
import 'package:infinite_listview_example/data/generator/list_data_source.dart';

import 'list.dart';

class ListBloc extends Bloc<ListEvent, ListState> {

  final ListDataSource _listDataSource;

  ListBloc(this._listDataSource);
  @override
  ListState get initialState => ListState.initial();

  @override
  Stream<ListState> mapEventToState(ListEvent event) async* {

    if(event is FetchNextPageEvent) {

      try {
        final nextPageItems = await _listDataSource.getNextListPage();
        yield ListState.success(nextPageItems + currentState.listItems);
      } on NoNextPageException catch (_) {
        yield currentState.rebuild((b) => b..hasReachedEndOfResults = true);
      }
    }
  }

  getNextPage() {
    dispatch(FetchNextPageEvent());
  }
}