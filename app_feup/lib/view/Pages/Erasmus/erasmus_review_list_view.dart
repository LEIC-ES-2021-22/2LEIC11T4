import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uni/model/erasmus/erasmus_db.dart';
import 'package:uni/model/erasmus/universityReview.dart';
import 'package:uni/view/Pages/general_page_view.dart';
import 'package:uni/view/Widgets/Erasmus/erasmus_card_reviews_rows.dart';

import '../../Widgets/Erasmus/eramus_nav_card_rows.dart';

class ErasmusReviewListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ErasmusReviewListViewState();
}

/// Manages the 'about' section of the app.


class ErasmusReviewListViewState extends GeneralPageViewState {


  List<UniversityReview> reviews;

  void getReviews(){
    reviews = ErasmusDB.getReviews();
  }


  @override
  Widget getBody(BuildContext context) {
    getReviews();
    return ListView(
      key: Key('key_Universities List'),
      children: <Widget>[
        ReviewRows(items: reviews)
      ],
    );
  }
}

