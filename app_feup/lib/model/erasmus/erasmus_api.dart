
class UniversityItem {
  String label;
  String name;
  String rank;
  String country;
  String course;

  dynamic value;

  UniversityItem({
    this.label,
    this.name,
    this.rank,
    this.value,
    this.country,
    this.course
  });

  factory UniversityItem.fromJson(Map<String, dynamic> json) {
    return UniversityItem(
        label: json['label'],
        name: json['name'],
        rank: json['rank'],
        value: json['value'],
        country: json['country'],
        course: json['course']
    );
  }
}

class ErasmusAPI {

  static List<UniversityItem> getUniversitiesFromSearch(String search,
      String country, String course) {

      var list = [UniversityItem(label : 'Feup',
          name: 'Faculdade de engenharia da universidade do Porto',
          rank: '124th',value : 30, country: 'Portugal',
          course: 'Engenharia de Software'),
        UniversityItem(label : 'Harvard',
            name: 'Harvard University',
            rank: '124th',value : 31, country: 'U.S.A',
            course: 'Direito'),
        UniversityItem(label : 'MIT',
            name: 'Massachusetts Institute of Technology',
            rank: '124th', value : 32, country: 'U.S.A',
            course: 'Ciência de computadores'),
        UniversityItem(label : 'FEP',
            name: 'Faculdade de economia do Porto',
            rank: '124th',value : 33, country: 'Portugal',
            course: 'Economia'),
        UniversityItem(label : 'Flup',
            name: 'Faculdade de letras da universidade do Porto',
            rank: '124th', value : 34, country: 'Portugal',
            course: 'História'),
        UniversityItem(label : 'Uminho',
            name: 'Universidade do Minho',
            rank: '254th', value : 35, country: 'Portugal',
            course: 'Engenharia de Software')
      ];

      if (search.isEmpty && country == 'All' && course == 'All') {
        return list;
      }
      list.removeWhere((element) {
        return !element.label.contains(search)
            || (!element.country.contains(country) && country != 'All')
            || (!element.course.contains(course) && course != 'All');
      });

      return list;
  }
}

