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
          (i) => SurahCard(chapter: state.chapters[i]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (_, state) {
            return MediaQuery.of(context).size.width < 600
                ? _body(state)
                : const Center(
                    child: Text(
                      'Aplikasi ini dioptimalisasi untuk perangkat mobile dengan layar portrait\nJika ingin membukanya di desktop perkecil dulu windowsnya >>',
                    ),
                  );
          },
        ),
      ),
    );
  }
}
