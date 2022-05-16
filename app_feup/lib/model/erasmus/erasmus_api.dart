import 'package:uni/model/erasmus/erasmus_db.dart';
import 'package:uni/view/Widgets/Erasmus/star_evaluation_view.dart';

class UniversityItem {
  final String label;
  final String name;
  final String rank;
  final String country;
  final String course;
  final String link;
  final String imgUrl;
  final String description;
  final UniversityStarEvaluation stars;
  // the stars should come from the mean of the db
  dynamic value;

  factory UniversityItem.fromSheets(List<String> input) => UniversityItem(
        label: input[0],
        name: input[1],
        rank: input[2],
        value: input[3],
        country: input[4],
        course: input[5],
        link: input[6],
        description: input[7],
        stars: UniversityStarEvaluation(int.parse(input[8]),
            int.parse(input[9]), int.parse(input[10]), int.parse(input[11])),
        imgUrl: input[12],
      );

  UniversityItem(
      {this.label,
      this.name,
      this.rank,
      this.value,
      this.country,
      this.link,
      this.course,
      this.imgUrl,
      this.description,
      this.stars});

  factory UniversityItem.fromJson(Map<String, dynamic> json) {
    return UniversityItem(
        label: json['label'],
        name: json['name'],
        rank: json['rank'],
        value: json['value'],
        country: json['country'],
        course: json['course'],
        link: json['link'],
        imgUrl: json['imgUrl'],
        description: json['description']);
  }
}

class ErasmusAPI {
  static List<UniversityItem> unis;

  static Future<void> fetchUniversities() async {
    unis = await ErasmusDB.getUnis();
  }

  static List<UniversityItem> getUniversitiesFromSearch(
      String search, String country, String course) {
    final list = unis;

    if (search.isEmpty && country == 'All' && course == 'All') {
      return list;
    }
    list.removeWhere((element) {
      return !element.label.contains(search) ||
          (!element.country.contains(country) && country != 'All') ||
          (!element.course.contains(course) && course != 'All');
    });

    return list;
  }

  static List<String> getAvailableCountries() {
    final set = unis.map((e) => e.country).toSet();
    set.add('All');
    return set.toList();
  }

  static List<String> getAvailableCourses() {
    final set = unis.map((e) => e.course).toSet();
    set.add('All');
    return set.toList();
  }

  static List<String> getAvailableUniversities() {
    final set = unis.map((e) => e.label).toSet();
    set.add('');
    return set.toList();
  }

  static UniversityItem getUniversity(int id) {
    return unis[id % unis.length];
  }

  static List<UniversityItem> getTop(int n) {
    final unis2 = unis;

    int calcScore(UniversityStarEvaluation score) {
      return score.country +
          score.expenses +
          score.experience +
          score.knowledge;
    }

    unis2.sort((a, b) => (calcScore(b.stars)).compareTo(calcScore(a.stars)));

    return unis2.sublist(0, n);
  }
}
