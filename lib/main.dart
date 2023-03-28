import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';
import 'home/cubit/home_cubit.dart';
import 'utils/color_schemes.g.dart';
import 'home/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const QuranicVerses());
}

class QuranicVerses extends StatelessWidget {
  const QuranicVerses({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quranic Verses',
      scrollBehavior: CustomScrollBehavior(),
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Inter',
        colorScheme: lightColorScheme,
      ),
      // darkTheme: ThemeData(
      //   useMaterial3: true,
      //   fontFamily: 'Inter',
      //   colorScheme: darkColorScheme,
      // ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => HomeCubit()..init()),
        ],
        child: const HomeView(),
      ),
    );
  }
}

class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.mouse,
        PointerDeviceKind.touch,
      };
}
