import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_points_manager/core/themes/app_theme.dart';
import 'package:game_points_manager/logic/cubit/players_cubit.dart';
import 'package:game_points_manager/logic/cubit/theme_cubit.dart';
import 'package:game_points_manager/presentation/router/app_router.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () => {
        BlocProvider.of<PlayersCubit>(context).state.wasAdded
            ? Navigator.of(context).pushReplacementNamed(AppRouter.home)
            : Navigator.of(context).pushReplacementNamed(AppRouter.addPlayers)
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors:
                context.read<ThemeCubit>().state.themeMode == ThemeMode.light
                    ? [
                        AppTheme.lightPrimaryColor,
                        AppTheme.lightAccentColor,
                      ]
                    : [
                        AppTheme.darkPrimaryColor,
                        AppTheme.darkAccentColor,
                      ],
          ),
        ),
        child: Center(
          child: Icon(
            Icons.star,
            size: 50,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
