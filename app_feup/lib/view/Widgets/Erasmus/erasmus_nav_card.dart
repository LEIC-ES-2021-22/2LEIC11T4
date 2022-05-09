import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../model/erasmus/erasmus_api.dart';
import '../generic_card.dart';

/// Manages the 'Current account' section inside the user's page (accessible
/// through the top-right widget with the user picture)
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
    return Column(children: [
      Text(''),
      Text(this.text, style: Theme.of(context).textTheme.headline4),
    ]);
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
  Image uniPhoto;
  final gotoPage;

  ErasmusUniversityCard(this.uni, this.gotoPage, this.uniPhoto);

  ErasmusUniversityCard.fromEditingInformation(Key key, bool editingMode,
      Function onDelete, this.uni, this.gotoPage, this.uniPhoto)
      : super.fromEditingInformation(key, editingMode, onDelete);

  @override
  Widget buildCardContent(BuildContext context) {
    final MediaQueryData queryData = MediaQuery.of(context);
    /*
    Wrap(direction: Axis.horizontal,
        crossAxisAlignment: WrapCrossAlignment.start,
        spacing: 30,
        runSpacing: 15,
     */
    return Row(
        children: [
            Container(
                width: queryData.size.height / 7,
                height: queryData.size.height / 7,
                child: uniPhoto
                ),
                SizedBox(width: 30),
            Expanded(child : Column(
              children: [
                Text(uni.name,
                    softWrap: true,
                    style: Theme.of(context).textTheme.headline2),
                SizedBox(height: 10),
                Text('International Ranking:',
                    style: Theme.of(context).textTheme.subtitle2),
                SizedBox(height: 5),
                Text(uni.rank,
                    style: Theme.of(context)
                        .textTheme
                        .headline1
                        .apply(
                        fontSizeDelta: -57,
                        fontWeightDelta: -3)),
              ],
            ),
            ),
        ]
    );
  }

  @override
  String getTitle() => this.uni.label;

  @override
  onClick(BuildContext context) {
    Navigator.pushNamed(context, '/' + this.gotoPage);
  }
}



/* 

      Table(
          columnWidths: {1: FractionColumnWidth(.4)},
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(children: [
              Container(
                margin:
                    const EdgeInsets.only(top: 20.0, bottom: 8.0, left: 20.0),
                child: Text('Saldo: ',
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .apply(fontSizeDelta: -4)),
              ),
              Container(
                margin:
                    const EdgeInsets.only(top: 20.0, bottom: 8.0, right: 30.0),
                child: StoreConnector<AppState, String>(
                    converter: (store) => store.state.content['feesBalance'],
                    builder: (context, feesBalance) =>
                        getInfoText(feesBalance, context)),
              )
            ]),
            TableRow(children: [
              Container(
                margin:
                    const EdgeInsets.only(top: 8.0, bottom: 20.0, left: 20.0),
                child: Text('Data limite próxima prestação: ',
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .apply(fontSizeDelta: -4)),
              ),
              Container(
                margin:
                    const EdgeInsets.only(top: 8.0, bottom: 20.0, right: 30.0),
                child: StoreConnector<AppState, String>(
                    converter: (store) => store.state.content['feesLimit'],
                    builder: (context, feesLimit) =>
                        getInfoText(feesLimit, context)),
              )
            ]),
          ]),
      StoreConnector<AppState, String>(
          converter: (store) => store.state.content['feesRefreshTime'],
          builder: (context, feesRefreshTime) =>
              this.showLastRefreshedTime(feesRefreshTime, context))
    */