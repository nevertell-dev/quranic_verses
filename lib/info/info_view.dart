// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html/parser.dart';
import 'package:quranic_verses/home/widgets/surah_card.dart';

import '../models/chapter.dart';

class InfoView extends StatelessWidget {
  const InfoView({
    Key? key,
    required this.chapter,
  }) : super(key: key);

  final Chapter chapter;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InfoCubit()..init(chapter.id),
      child: SafeArea(
        child: Scaffold(
          body: BlocBuilder<InfoCubit, InfoState>(
            builder: (context, state) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AspectRatio(
                      aspectRatio: 1 / 1.6,
                      child: Hero(
                        tag: 'surah-${chapter.id}',
                        child: SurahCard(chapter: chapter),
                      ),
                    ),
                    if (state is InfoLoaded) ...state.children
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class InfoCubit extends Cubit<InfoState> {
  InfoCubit() : super(InfoInitial());

  void init(int chapterId) async {
    final jsonData = json.decode(await getJson(chapterId));
    final infoText = jsonData['chapter_info']['text'] as String;

    const query = ['h1', 'h2', 'h3', 'h4', 'strong'];
    final htmlDatas = parse(infoText).querySelectorAll('p,${query.join(',')}');
    final children = <Widget>[];

    for (var data in htmlDatas) {
      if (data.innerHtml.contains('Pokok-pokok Isi')) {
        children.add(
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              'Pokok-pokok Isi',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
        continue;
      }

      const regex = r'(?<=\*\*)[^\*]+(?=:\*\*)|(?<=\b\d+\.\s)[^\*]+(?=:$)';
      final headerRegex = RegExp(regex);
      final headerMatch = headerRegex.firstMatch(data.innerHtml);
      final isHeader = query.contains(data.localName) || headerMatch != null;

      children.add(Container(
        margin: isHeader
            ? const EdgeInsets.symmetric(vertical: 8.0)
            : const EdgeInsets.all(0.0),
        padding: isHeader
            ? const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0)
            : const EdgeInsets.all(0.0),
        decoration: BoxDecoration(
          color: isHeader ? const Color(0xFF7BFECF) : const Color(0x00000000),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          headerMatch?.group(0) ?? data.innerHtml,
          style: TextStyle(
            color: isHeader ? const Color(0xFF4A5579) : const Color(0xFF000000),
            fontWeight: isHeader ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ));
    }

    emit(InfoLoaded(children: children));
  }

  Future<String> getJson(int chapterId) async {
    final path = 'assets/json/chapters/info/$chapterId.json';
    return await rootBundle.loadString(path);
  }
}

class InfoState extends Equatable {
  const InfoState();

  @override
  List<Object?> get props => [];
}

class InfoInitial extends InfoState {}

class InfoLoaded extends InfoState {
  const InfoLoaded({required this.children});

  final List<Widget> children;

  @override
  List<Object?> get props => [children];
}
