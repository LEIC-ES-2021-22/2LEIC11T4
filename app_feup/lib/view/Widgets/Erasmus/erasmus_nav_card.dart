import 'dart:io';

import 'package:flutter/material.dart';
import 'package:uni/controller/local_storage/image_offline_storage.dart';
import 'package:uni/model/app_state.dart';

import 'package:uni/model/erasmus/universityItem.dart';
import 'package:uni/view/Widgets/Erasmus/star_evaluation_view.dart';
import '../../../model/erasmus/universityReview.dart';
import '../../Pages/Erasmus/erasmus_uni_page_view.dart';
import '../generic_card.dart';

class ErasmusNavigationCard extends GenericCard {
  final String title;
  final String text;
  final gotoPage;

  ErasmusNavigationCard(this.title, this.text, this.gotoPage);

  ErasmusNavigationCard.fromEditingInformation(Key key, bool editingMode,
      Function onDelete, this.title, this.text, this.gotoPage)
      : super.fromEditingInformation(key, editingMode, onDelete);

  @override
  Widget buildCardContent(BuildContext context) {
    return Column(
      children: [
        Text(''),
        Text(this.text, style: Theme.of(context).textTheme.headline4),
      ],
      //key: Key('$title'),
    );
  }

  @override
  String getTitle() => this.title;

  @override
  onClick(BuildContext context) {
    Navigator.pushNamed(context, '/' + this.gotoPage);
  }
}

class ErasmusUniversityCard extends GenericCard {
  final UniversityItem uni;
  final gotoPage;

  ErasmusUniversityCard(this.uni, this.gotoPage);

  ErasmusUniversityCard.fromEditingInformation(
      Key key, bool editingMode, Function onDelete, this.uni, this.gotoPage)
      : super.fromEditingInformation(key, editingMode, onDelete);

  @override
  Widget buildCardContent(BuildContext context) {
    final MediaQueryData queryData = MediaQuery.of(context);

    return Row(children: [
      Container(
          width: queryData.size.height / 7,
          height: queryData.size.height / 7,
          child: Image.network(uni.imgUrl)),
      SizedBox(width: 30),
      Expanded(
        child: Column(
          children: [
            Text(uni.name,
                softWrap: true, style: Theme.of(context).textTheme.headline2),
            SizedBox(height: 10),
            Text('International Ranking:',
                style: Theme.of(context).textTheme.subtitle2),
            SizedBox(height: 5),
            Text(uni.rank,
                style: Theme.of(context)
                    .textTheme
                    .headline1
                    .apply(fontSizeDelta: -57, fontWeightDelta: -3)),
          ],
        ),
      ),
    ]);
  }

  @override
  String getTitle() => this.uni.label;

  @override
  onClick(BuildContext context) {
    Navigator.pushNamed(context, '/' + this.gotoPage);
    ErasmusUniversityPageViewState.university = this.uni;
  }
}


class ErasmusReviewCard extends GenericCard {
  final UniversityReview review;
  final gotoPage;

  ErasmusReviewCard(this.review, this.gotoPage);

  ErasmusReviewCard.fromEditingInformation(
      Key key, bool editingMode, Function onDelete, this.review, this.gotoPage)
      : super.fromEditingInformation(key, editingMode, onDelete);

  @override
  Widget buildCardContent(BuildContext context) {
    final MediaQueryData queryData = MediaQuery.of(context);

    return Row(children: [
      Container(
          width: queryData.size.height / 7,
          height: queryData.size.height / 7,
          child: Image.network('https://sigarra.up.pt/feup/pt/fotografias_service.foto?pct_cod=up' + review.studentID)),
      SizedBox(width: 30),
      Expanded(
        child: Column(
          children: [
            Text(review.text,
                softWrap: true, style: Theme.of(context).textTheme.headline2),
            SizedBox(height: 10),

            StarDisplay(value: review.stars.experience),
            SizedBox(height: 5)
          ],
        ),
      ),
    ]);
  }

  @override
  String getTitle() => this.review.studentID;

  @override
  onClick(BuildContext context) {
  }

}

Future<File> loadProfilePic(String studentno) {
  final String studentNo = studentno;
  String url =
      'https://sigarra.up.pt/feup/pt/fotografias_service.foto?pct_cod=';
  final Map<String, String> headers = Map<String, String>();

  if (studentNo != null) {
    url += studentNo;
    headers['cookie'] = studentno;
  }
  return retrieveImage(url, headers);
}

