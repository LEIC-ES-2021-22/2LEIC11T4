import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uni/utils/constants.dart' as Constants;
import '../../../model/erasmus/erasmus_api.dart';
import 'package:http/http.dart' as http;

import 'erasmus_nav_card.dart';


class UniversityRows extends StatelessWidget {

  List<UniversityItem> items;


  UniversityRows(
      {Key key,
        @required this.items,
      })
      : super(key: key);

  static Future<String> getImageUrl() async{
    // // final url = 'https://www.googleapis.com/customsearch/v1?key=AIzaSyBl4yPIInB6rCFgYF345s4xVr7ZrWiimHA&cx=f29830fe2502e4c5e&q=FEUP&searchType=image&num=1';
    // final response = await http.get(Uri.parse(url));
    // final decodeResponse =  jsonDecode(response.body);
//
    // //final img_url = decodeResponse.data.items[0].link;
    // return decodeResponse.data.items[0].link;

    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child:  Container(
          padding: EdgeInsets.only(left: 12.0, bottom: 8.0, right: 12),
          margin: EdgeInsets.only(top: 8.0),
          child:  Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: Column(children: getUniversityRows(context),))
            ],
          ),
        ));
  }

  List<Widget> getUniversityRows(BuildContext context){
    final List<Widget> widgets = [];


    items.forEach((element) async {
      // String url = await getImageUrl();

      widgets.add(ErasmusUniversityCard(
          element,
          Constants.navErasmusUniversitiesList, // TODO: In a new issue
          Image.network('https://picsum.photos/seed/picsum/200/300')),
      );
    });

    return widgets;
  }
}