import 'package:flutter/material.dart';
import 'package:game_points_manager/presentation/screens/splash_screen/splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:game_points_manager/presentation/screens/add_players_screen/add_players_screen.dart';
import 'package:game_points_manager/presentation/screens/players_ranking_screen/players_ranking_screen.dart';
import 'package:game_points_manager/presentation/screens/points_screen/points_screen.dart';

import '../../core/constants/strings.dart';
import '../../core/exceptions/route_exception.dart';

class AppRouter {
  static const String home = '/';
  static const String splash = '/splash';
  static const String addPlayers = '/add-players';
  static const String points = '/points';
  static const String ranks = '/ranks';

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return PageTransition(
          type: PageTransitionType.fade,
          child: PointsScreen(
            title: Strings.pointsScreenTitle,
          ),
        );
      case splash:
        return PageTransition(
          type: PageTransitionType.fade,
          child: SplashScreen(),
        );
        break;
      case addPlayers:
        return PageTransition(
          type: PageTransitionType.fade,
          child: AddPlayersScreen(
            title: Strings.addPlayersScreenTitle,
          ),
        );
      case ranks:
        return PageTransition(
          type: PageTransitionType.fade,
          child: PlayersRankingScreen(
            title: Strings.ranksScreenTitle,
          ),
        );
      default:
        throw const RouteException('Route not found!');
    }
  }
}
