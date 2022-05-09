import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uni/view/Pages/general_page_view.dart';
import 'package:uni/utils/constants.dart' as Constants;
import 'package:url_launcher/url_launcher.dart';

class ErasmusUniversityPageView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ErasmusUniversityPageViewState();
}

/// Manages the 'about' section of the app.
class ErasmusUniversityPageViewState extends GeneralPageViewState {
  gotoErasmusUniReviewMake(BuildContext context) =>
      Navigator.pushNamed(context, '/' + Constants.navErasmusUniversityReview);

  gotoErasmusUniReviewList(BuildContext context) =>
      Navigator.pushNamed(context, '/' + Constants.navErasmusReviewList);

  final String descriptionText = '''
Dolorum perferendis nesciunt rerum recusandae quia dolorem laudantium. Necessitatibus consequuntur eum nulla culpa. Temporibus accusantium consequatur sapiente adipisci aliquam. Aperiam eligendi ut cum.
''';

  @override
  Widget getBody(BuildContext context) {
    final MediaQueryData queryData = MediaQuery.of(context);
    return ListView(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.all(10),
                child: SvgPicture.asset(
                  'assets/images/ni_logo.svg',
                  color: Theme.of(context).colorScheme.secondary,
                  width: queryData.size.height / 5,
                  height: queryData.size.height / 5,
                )),
            Center(
                child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(children: <Widget>[
                Text(
                  'Faculdade de Engenharia\n',
                  textScaleFactor: 1.2,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Portugal\n',
                  textScaleFactor: 1,
                ),
                TextLink(
                  '317 th',
                  'https://cwur.org/2021-22.php',
                  preText: 'Ranking: ',
                ),
              ]),
            ))
          ],
        ),
        Center(
            child: Column(
          children: [
            TextLink(
              'fe.up.pt',
              'https://fe.up.pt',
              preText: 'Website:  ',
              postText: '\n',
            ),
            Text(
              'Description',
              textScaleFactor: 1.2,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold),
            ),
          ],
        )),
        Container(
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 10),
          child: Text(
            descriptionText,
            textScaleFactor: 1.1,
            textAlign: TextAlign.justify,
          ),
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StarContainer('Expenses', 2, 0),
                StarContainer('Experience', 5, 20),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StarContainer('Knowledge', 1, 0),
                StarContainer('Country', 4, 20),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NavButton('See Reviews', gotoErasmusUniReviewList, Colors.white,
                    Theme.of(context).colorScheme.secondary),
                NavButton('Make Review', gotoErasmusUniReviewMake,
                    Theme.of(context).colorScheme.secondary, Colors.grey[300]),
              ],
            )
          ],
        )
      ],
    );
  }
}

// Class Widgets

class TextLink extends StatelessWidget {
  final String linkText;
  final String link;

  String postText = '';
  String preText = '';

  TextLink(
    String this.linkText,
    String this.link, {
    Key key,
    String this.preText,
    String this.postText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: preText,
          style: TextStyle(color: Colors.black),
        ),
        TextSpan(
            text: linkText,
            style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline),
            recognizer: TapGestureRecognizer()..onTap = () => launch(link)),
        TextSpan(
          text: postText,
          style: TextStyle(color: Colors.black),
        ),
      ]),
    );
  }
}

class NavButton extends StatelessWidget {
  final String textContent;
  final Function navFunc;
  final Color textColor;
  final Color backColor;

  const NavButton(String this.textContent, Function this.navFunc,
      Color this.textColor, Color this.backColor,
      {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        navFunc(context);
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        child: Text(
          '$textContent',
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
        color: backColor,
      ),
    );
  }
}

class StarContainer extends StatelessWidget {
  final String header;
  final int value;
  final double leftMargin;
  const StarContainer(
      String this.header, int this.value, double this.leftMargin,
      {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: EdgeInsets.only(left: leftMargin, bottom: 20),
      child: Center(
        child: Column(children: [
          Text(
            '$header',
            textScaleFactor: 1.2,
          ),
          IconTheme(
            data: IconThemeData(
              color: Theme.of(context).colorScheme.secondary,
              size: 30,
            ),
            child: StarDisplay(value: value),
          ),
        ]),
      ),
      color: Colors.grey[300],
    );
  }
}

class StarDisplay extends StatelessWidget {
  final int value;

  const StarDisplay({Key key, this.value = 0})
      : assert(value != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < value ? Icons.star : Icons.star_border,
        );
      }),
    );
  }
}
