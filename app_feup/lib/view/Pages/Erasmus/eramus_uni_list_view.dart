import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:uni/view/Pages/general_page_view.dart';

import '../../Widgets/Erasmus/eramus_nav_card_rows.dart';
import '../../../model/erasmus/erasmus_api.dart';


class ErasmusUniversityListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ErasmusUniversityListViewState();
}

//class SearchField extends StatelessWidget {
//  final TextEditingController _textEditingController = TextEditingController();
//
//  @override
//  Widget build(BuildContext context) {
//    return Column(
//      mainAxisAlignment: MainAxisAlignment.center,
//      children:[
//        Text('Page 1'),
//        TextFormField(
//          controller: _textEditingController,
//        ),
//        FlatButton(
//          child: Text('Submit'),
//          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
//              builder: (context) {
//                return const Padding(
//                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
//                  child: TextField(
//                    controller: _textEditingController,
//                    decoration: InputDecoration(
//                      border: OutlineInputBorder(),
//                      hintText: 'Enter a search term',
//                    ),
//                  ),
//                );
//              }
//          )),
//        ),
//      ],
//    );
//  }
//}

class ErasmusUniversityListViewState extends GeneralPageViewState {

  // TextEditingController myController = TextEditingController();
  String selectedCountry = 'All';
  String selectedCourse = 'All';
  String searchUni = '';

  //Future<List> fetchData() async {
  //  final List _list = [];
  //  final String _inputText = myController.text;
  //  final List _jsonList = [
  //    {
  //      'label': _inputText + ' Item 1',
  //      'value': 30
  //    },
  //    {
  //      'label': _inputText + ' Item 2',
  //      'value': 31
  //    },
  //    {
  //      'label': _inputText + ' Item 3',
  //      'value': 32
  //    },
  //  ];
////
  // // _list.add(UniversityItem.fromJson(_jsonList[0]));
  // // _list.add(UniversityItem.fromJson(_jsonList[1]));
  // // _list.add(UniversityItem.fromJson(_jsonList[2]));
  //  _list.add(_inputText + ' Item 1');
  //  _list.add(_inputText + ' Item 2');
  //  _list.add(_inputText + ' Item 3');
  //  return _list;
  //}
//
  //@override
  //void dispose() {
  //  myController.dispose();
  //  super.dispose();
  //}

 //_printLatestValue() {
 //  print("Textfield value: ${myController.text}");
 //}

 //@override
 //void initState() {
 //  super.initState();
 //  myController.addListener(_printLatestValue);
 //}

  @override
  Widget getBody(BuildContext context) {
    List countries = [
      {
        'id': '1',
        'name': 'Brazil',
      },
      {
        'id': '2',
        'name': 'India',
      },
      {
        'id': '3',
        'name': 'Japan',
      },
      {
        'id': '4',
        'name': 'Tokyo',
      },
      {
        'id': '5',
        'name': 'Australia',
      },
      {
        'id': '6',
        'name': 'Srilanka',
      },
      {
        'id': '7',
        'name': 'Canada',
      },
      {
        'id': '8',
        'name': 'Portugal',
      },
      {
        'id': '9',
        'name': 'U.S.A',
      },
      {
        'id': '10',
        'name': 'All',
      },
    ];

    List courses = [
      {
        'id': '1',
        'name': 'Economia',
      },
      {
        'id': '2',
        'name': 'Direito',
      },
      {
        'id': '3',
        'name': 'Engenharia de Software',
      },
      {
        'id': '4',
        'name': 'História',
      },
      {
        'id': '5',
        'name': 'All',
      }
    ];

    List uniLabels = [
      {
        'id': '0',
        'name': '',
      },
      {
        'id': '1',
        'name': 'Feup',
      },
      {
        'id': '2',
        'name': 'Fep',
      },
      {
        'id': '3',
        'name': 'Uminho',
      },
      {
        'id': '4',
        'name': 'Flup',
      },
      {
        'id': '5',
        'name': 'Harvard',
      },
      {
        'id': '6',
        'name': 'MIT',
      }
    ];

    return ListView(
      children: <Widget>[
      //  TextFieldSearch(
      //      label: label,
      //      initialList: dummyList,
      //      controller: myController,
      //      //future: () {
      //      //  return fetchData();
      //      //},
      //      //getSelectedValue: (value) {
      //      //  print(value);
      //      //}
      //  ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: DropdownSearch<dynamic>(
            mode: Mode.MENU,
            items: uniLabels.map((e)=>e['name']).toList(),
            showSearchBox: true,
            onChanged: (value){
              setState(() {
                searchUni = value;
              });
            },
            selectedItem: searchUni,
          ),
        ),
        Padding(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child:
            Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
                ListTile(
                  title: Text('Country'),
                  trailing: DropdownButton<String>(
                    hint: Text('Country'),
                    items: countries.map((e)=>DropdownMenuItem<String>(
                          value: e['name'], child: Text(e['name']))).toList(),
                    onChanged: (value){
                      setState(() {
                        selectedCountry = value;
                      });
                    },
                    value: selectedCountry,
                  ),
                ),
                ListTile(
                  title: Text('Course'),
                  trailing: DropdownButton<String>(
                    hint: Text('Country'),
                    items: courses.map((e)=>DropdownMenuItem<String>(
                        value: e['name'], child: Text(e['name']))).toList(),
                    onChanged: (value){
                      setState(() {
                        selectedCourse = value;
                      });
                    },
                    value: selectedCourse,
                  ),
                ),
            ]
            ),
        ),
        UniversityRows(items:
          ErasmusAPI.getUniversitiesFromSearch(searchUni
                , selectedCountry, selectedCourse)
        ),
      ],
    );
  }

}
//
//TextField(
//controller: myController,
//decoration: InputDecoration(
//border: OutlineInputBorder(),
//hintText: 'Enter a search term',
//),
//),



// DropdownSearch<dynamic>(
// mode: Mode.MENU,
// items: countries.map((e)=>e['name']).toList(),
// showSearchBox: true,
// onChanged: (value){
// setState(() {
// selectedCountry = value;
// });
// print(value);
// },
// selectedItem: selectedCountry,
// ),
