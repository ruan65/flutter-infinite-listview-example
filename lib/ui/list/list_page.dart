import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_listview_example/data/model/list_item.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

import 'list.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final _scrollController = ScrollController(initialScrollOffset: 500);

  final _listBloc = kiwi.Container().resolve<ListBloc>();

  List<double> jumps = [];

  @override
  void initState() {
    super.initState();
    _listBloc.getNextPage();
  }

  @override
  void dispose() {
    _listBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder(
        bloc: _listBloc,
        builder: (context, ListState state) {
//          print('state: $state');

          if (state.listItems.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else {
            var listBody = NotificationListener<ScrollNotification>(
              onNotification: _handleScrollNotification,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _calculateListItemCount(state),
                itemBuilder: (context, index) {
                  return _buildDataListItem(state.listItems[index]);
                },
              ),
            );

            Timer(Duration(milliseconds: 0), () {
              print('jump to = $jumps');

              _scrollController.jumpTo(_calculateJump(jumps));
            });
            return listBody;
          }
        },
      ),
    );
  }

  double _calculateJump(List<double> list) {
    double jump = 0;
    switch (jumps.length) {
      case 0:
        jump = _scrollController.position.maxScrollExtent;
        break;
      case 1:
        jump = jumps[0];
        break;
      default:
        jump = jumps.last - jumps[jumps.length - 2];
        break;
    }
    print('jump will be: $jump');
    return jump;
  }

  Widget _buildLoaderListItem() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildDataListItem(ListItem item) {
    String title = item.title;
    int tryParse = int.tryParse(title[title.length - 1]);
    final isRed = tryParse == null ? false : tryParse % 2 == 0;
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Color(item.colorInt),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 16),
            Text(
              item.title,
              style: TextStyle(
                  fontSize: 20, color: isRed ? Colors.red : Colors.blue),
            )
          ],
        ),
      ),
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
//    print('scroll notification: $notification');
    var position = _scrollController.position;

    if (notification is ScrollEndNotification && position.extentBefore == 0) {
      print('extentAfter: ${position.extentAfter}');
      print('extentBefore: ${position.extentBefore}');
      print('extentInside: ${position.extentInside}');

//      jumpTo = position.extentAfter + position.extentInside - jumpTo;
      var newJump = position.extentInside + position.extentAfter;
      jumps.add(newJump);
      _listBloc.getNextPage();
    }

    return false;
  }

  _calculateListItemCount(ListState state) {
    if (state.hasReachedEndOfResults) {
      return state.listItems.length;
    } else {
      return state.listItems.length;
//      return state.listItems.length + 1;
    }
  }
}
