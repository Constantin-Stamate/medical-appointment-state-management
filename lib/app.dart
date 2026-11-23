import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/constants/app_colors.dart';
import 'repositories/app_repository.dart';
import 'state/app_cubit.dart';
import 'screens/home/home_screen.dart';

class DoctorApp extends StatelessWidget {
  const DoctorApp({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => AppCubit(AppRepository())..load(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Doctor App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const HomeScreen(),
    ),
  );
}