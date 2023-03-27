import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quranic_verses/models/chapter.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  void init() async {
    final jsonData = json.decode(await getJson());
    final documents = jsonData['chapters'] as Iterable;
    final chapters = List<Chapter>.generate(
      documents.length,
      (i) => Chapter.fromJson(documents.elementAt(i)),
    );

    emit(HomeLoaded(chapters));
  }

  Future<String> getJson() async {
    return await rootBundle.loadString('assets/json/chapters.json');
  }
}
