import 'package:tuple/tuple.dart';
import 'package:uni/model/app_state.dart';
import 'package:uni/model/entities/lecture.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:uni/view/Pages/Erasmus/eramus_paperwork_view.dart';

import 'package:uni/view/Pages/secondary_page_view.dart';

class ErasmusPaperworkModel extends StatefulWidget {
  const ErasmusPaperworkModel({Key key}) : super(key: key);

  @override
  _ErasmusPaperworkModelState createState() => _ErasmusPaperworkModelState();
}

class _ErasmusPaperworkModelState extends SecondaryPageViewState
    with SingleTickerProviderStateMixin {

  TabController tabController;
  ScrollController scrollViewController;

  final List<String> tabs = [
    'How to participate',
    'Scholarships',
    'More about Erasmus'
  ];

  final List<String> text = [
    'text0',
    'text1',
    'text2'

  ];


  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: tabs.length);
    tabController.animateTo((tabController.index));
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget getBody(BuildContext context) {
    return StoreConnector<AppState, Tuple2<List<Lecture>, RequestStatus>>(
      converter: (store) => Tuple2(store.state.content['schedule'],
          store.state.content['scheduleStatus']),
      builder: (context, lectureData) {
        return ErasmusPaperworkView(
            tabController: tabController,
            scrollViewController: scrollViewController,
            tabBarContent: tabs,
            text: text,
            );
      },
    );
  }
}
