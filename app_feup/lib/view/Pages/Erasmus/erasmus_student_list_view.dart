import 'package:flutter/material.dart';
import 'package:uni/model/erasmus/erasmus_db.dart';
import 'package:uni/model/erasmus/studentItem.dart';
import 'package:uni/view/Pages/general_page_view.dart';

import '../../Widgets/Erasmus/eramus_nav_card_rows.dart';

class ErasmusStudentListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ErasmusStudentListViewState();
}

class ErasmusStudentListViewState extends GeneralPageViewState {
  List<StudentItem> students = ErasmusDB.getStudents();

  void getReviews() {
    students = ErasmusDB.getStudents();
  }

  @override
  Widget getBody(BuildContext context) {
    getReviews();
    return ListView(
      key: Key('key_students_list'),
      children: <Widget>[StudentRows(items: students)],
    );
  }
}
