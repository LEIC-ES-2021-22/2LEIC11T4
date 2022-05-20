import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uni/model/erasmus/erasmus_db.dart';
import 'package:uni/model/erasmus/universityReview.dart';
import 'package:uni/view/Pages/general_page_view.dart';

class ErasmusUniversityReviewView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ErasmusUniversityReviewViewState();
}

/// Manages the 'about' section of the app.
class ErasmusUniversityReviewViewState extends GeneralPageViewState {
  int _sNumber = 0;

  // chamar funcao para guardar na database a review
  void postReview(UniversityReview review) async {
    await ErasmusDB.addReview(review);
  }

  void getStudentNumber() {
    _sNumber = ErasmusDB.getStudentNumber();
  }

  @override
  Widget getBody(BuildContext context) {
    getStudentNumber();

    final MediaQueryData queryData = MediaQuery.of(context);
    return ListView(
      children: <Widget>[
        Container(
            child: SvgPicture.asset(
          'assets/images/ni_logo.svg',
          color: Theme.of(context).colorScheme.secondary,
          width: queryData.size.height / 7,
          height: queryData.size.height / 7,
        )),
        Center(
            child: Padding(
          padding: EdgeInsets.only(
              left: queryData.size.width / 12,
              right: queryData.size.width / 12,
              top: queryData.size.width / 12,
              bottom: queryData.size.width / 12),
          child: Column(children: <Widget>[
            Text(
              'University Make Review \n\n',
              textScaleFactor: 1.5,
            ),
            Text("TODO : $_sNumber")
          ]),
        ))
      ],
    );
  }
}
