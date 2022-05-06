import 'package:flutter/material.dart';

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
