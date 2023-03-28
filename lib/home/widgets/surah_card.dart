// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:quranic_verses/info/info_view.dart';

import 'package:quranic_verses/models/chapter.dart';
import 'package:quranic_verses/utils/text_style.dart';

class SurahCard extends StatelessWidget {
  const SurahCard({
    Key? key,
    required this.chapter,
  }) : super(key: key);

  final Chapter chapter;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isMadaniyyah = chapter.revelationPlace == 'madinah';
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InfoView(chapter: chapter),
            ));
      },
      child: Container(
        margin: const EdgeInsets.all(4.0),
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(isMadaniyyah ? 20 : 10),
          color: colorScheme.background,
        ),
        child: Material(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SurahCardHeader(
                  id: chapter.id,
                  revelationPlace: chapter.revelationPlace,
                ),
                SurahCardBody(
                  isMadaniyyah: isMadaniyyah,
                  name: chapter.nameArabic,
                  transliteration: chapter.nameComplex,
                  translation: chapter.translatedName.name,
                ),
                SurahCardFooter(
                  versesCount: chapter.versesCount,
                ),
              ]),
        ),
      ),
    );
  }
}

class SurahCardHeader extends StatelessWidget {
  const SurahCardHeader({
    Key? key,
    required this.id,
    required this.revelationPlace,
  }) : super(key: key);

  final int id;
  final String revelationPlace;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('$id', style: surahNumberStyle),
        Image.asset('assets/images/${revelationPlace.toLowerCase()}_icon.png'),
      ],
    );
  }
}

class SurahCardBody extends StatelessWidget {
  const SurahCardBody({
    Key? key,
    required this.isMadaniyyah,
    required this.name,
    required this.transliteration,
    required this.translation,
  }) : super(key: key);

  final bool isMadaniyyah;
  final String name;
  final String transliteration;
  final String translation;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          name,
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.center,
          style:
              isMadaniyyah ? surahNameMadaniyyahStyle : surahNameMakkiyyahStyle,
        ),
        Text(
          transliteration,
          textAlign: TextAlign.center,
          style: surahTransliterationStyle,
        ),
        Text(
          translation,
          textAlign: TextAlign.center,
          style: surahTranslationStyle,
        ),
      ],
    );
  }
}

class SurahCardFooter extends StatelessWidget {
  const SurahCardFooter({
    Key? key,
    required this.versesCount,
  }) : super(key: key);

  final int versesCount;

  @override
  Widget build(BuildContext context) {
    final ornament = Image.asset('assets/images/ornament.png');
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ornament,
        Text('$versesCount', style: surahNumberOfVersesStyle),
        Transform.scale(scaleX: -1, child: ornament),
      ],
    );
  }
}
