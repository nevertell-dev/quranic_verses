import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quranic_verses/home/cubit/home_cubit.dart';
import 'package:quranic_verses/home/widgets/surah_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  Widget _body(HomeState state) {
    if (state is! HomeLoaded) {
      return const Center(child: CircularProgressIndicator.adaptive());
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(
        childAspectRatio: 1 / 1.6,
        crossAxisCount: 3,
        children: List<Widget>.generate(
          state.chapters.length,
          (i) => Hero(
            tag: 'surah-${state.chapters[i].id}',
            child: SurahCard(chapter: state.chapters[i]),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
            body: _body(state),
          ),
        );
      },
    );
  }
}
