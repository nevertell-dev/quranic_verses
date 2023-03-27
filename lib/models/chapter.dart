class Chapter {
  Chapter({
    required this.id,
    required this.revelationPlace,
    required this.revelationOrder,
    required this.bismillahPre,
    required this.nameSimple,
    required this.nameComplex,
    required this.nameArabic,
    required this.versesCount,
    required this.pages,
    required this.translatedName,
  });

  late final int id;
  late final String revelationPlace;
  late final int revelationOrder;
  late final bool bismillahPre;
  late final String nameSimple;
  late final String nameComplex;
  late final String nameArabic;
  late final int versesCount;
  late final List<int> pages;
  late final TranslatedName translatedName;

  Chapter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    revelationPlace = json['revelation_place'];
    revelationOrder = json['revelation_order'];
    bismillahPre = json['bismillah_pre'];
    nameSimple = json['name_simple'];
    nameComplex = json['name_complex'];
    nameArabic = json['name_arabic'];
    versesCount = json['verses_count'];
    pages = List.castFrom<dynamic, int>(json['pages']);
    translatedName = TranslatedName.fromJson(json['translated_name']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['revelation_place'] = revelationPlace;
    data['revelation_order'] = revelationOrder;
    data['bismillah_pre'] = bismillahPre;
    data['name_simple'] = nameSimple;
    data['name_complex'] = nameComplex;
    data['name_arabic'] = nameArabic;
    data['verses_count'] = versesCount;
    data['pages'] = pages;
    data['translated_name'] = translatedName.toJson();
    return data;
  }
}

class TranslatedName {
  TranslatedName({
    required this.languageName,
    required this.name,
  });
  late final String languageName;
  late final String name;

  TranslatedName.fromJson(Map<String, dynamic> json) {
    languageName = json['language_name'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['language_name'] = languageName;
    data['name'] = name;
    return data;
  }
}
