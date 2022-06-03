import 'dart:ffi';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uni/model/erasmus/erasmus_db.dart';
import 'package:uni/model/erasmus/universityItem.dart';
import 'package:uni/view/Widgets/Erasmus/star_evaluation_view.dart';

void main() {
  ErasmusDB.fetchData();
  group('Database Tests', () {
    final university = UniversityItem(
        label: 'TESTUNI',
        name: 'University of Testing',
        rank: '500',
        value: 1000,
        country: 'Portugal',
        course: 'Educação',
        link: 'https://www.google.com/',
        imgUrl: 'https://picsum.photos/200',
        description: 'The best testing University',
        stars: UniversityStarEvaluation(1, 1, 1, 1),
        location: LatLng(50.0123456, 19.7654321));

    test('Addinng and Removing a University', () async {
      //print('Something hey!!!\n');
      await ErasmusDB.addUni(university);
      await ErasmusDB.fetchData();

      List<UniversityItem> universities = ErasmusDB.getUnis();
      bool found = false;
      universities.forEach((element) {
        //print('${element.label}\t');
        if (element.label == university.label) {
          found = true;
        }
      });

      print('Value of ${found}\n');
      expect(found, true);
      
      await ErasmusDB.deleteUni(1000);
      await ErasmusDB.fetchData();

      bool deleted = false;
      universities.forEach((element) {
        //print('${element.label}\t');
        if (element.label == university.label) {
          deleted = true;
        }
      });

      print('Value of ${deleted}\n');
      expect(deleted, true);
      
    });
  });
}
