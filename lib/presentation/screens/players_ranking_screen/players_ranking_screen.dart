import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_points_manager/core/themes/app_theme.dart';
import 'package:game_points_manager/logic/cubit/players_cubit.dart';
import 'package:game_points_manager/logic/cubit/theme_cubit.dart';
import 'package:game_points_manager/presentation/screens/players_ranking_screen/widgets/players_rank_list_widget.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

class PlayersRankingScreen extends StatefulWidget {
  final String title;
  const PlayersRankingScreen({
    Key key,
    @required this.title,
  }) : super(key: key);
  @override
  _PlayersRankingScreenState createState() => _PlayersRankingScreenState();
}

class _PlayersRankingScreenState extends State<PlayersRankingScreen> {
  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();
  var _sideMenuState;

  Widget listTile(materialButtonContext, title, icon) => ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(title, style: TextStyle(color: Colors.white)),
        contentPadding: EdgeInsets.all(0),
        minVerticalPadding: 0,
        horizontalTitleGap: 0,
        onTap: () => handleClick(title, materialButtonContext),
      );

  void handleClick(String value, ctx) {
    _sideMenuState.closeSideMenu();
    switch (value) {
      case 'High - Low':
        if (!BlocProvider.of<PlayersCubit>(ctx).state.sortHighToLow)
          BlocProvider.of<PlayersCubit>(ctx).setSortHighToLow(true);
        break;
      case 'Low - High':
        if (BlocProvider.of<PlayersCubit>(ctx).state.sortHighToLow)
          BlocProvider.of<PlayersCubit>(ctx).setSortHighToLow(false);
        break;
    }
    BlocProvider.of<PlayersCubit>(ctx).setPlayerRankings();
  }

  Widget buildMenu() {
    return Builder(
      builder: (materialButtonContext) => Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Column(
          children: [
            Text(
              'Sort Ranks',
              style: Theme.of(context).textTheme.headline6.copyWith(
                    color: Colors.white,
                  ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  listTile(materialButtonContext, 'High - Low',
                      Icons.arrow_downward),
                  listTile(
                      materialButtonContext, 'Low - High', Icons.arrow_upward),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SideMenu(
      key: _sideMenuKey,
      menu: buildMenu(),
      background: context.read<ThemeCubit>().state.themeMode == ThemeMode.light
          ? AppTheme.lightSideMenuBackgroundColor
          : AppTheme.darkSideMenuBackgroundColor,
      type: SideMenuType.shrinkNSlide,
      inverse: true,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          textTheme: Theme.of(context).appBarTheme.textTheme,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          actions: <Widget>[
            BlocBuilder<PlayersCubit, PlayersState>(
              builder: (playersCubitBuilderContext, state) => IconButton(
                icon: Icon(
                  Icons.more_vert,
                ),
                disabledColor: Theme.of(context).disabledColor,
                onPressed: () {
                  _sideMenuState = _sideMenuKey.currentState;
                  if (_sideMenuState.isOpened)
                    _sideMenuState.closeSideMenu();
                  else
                    _sideMenuState.openSideMenu();
                },
              ),
            ),
          ],
        ),
        body: Container(
          padding: EdgeInsets.only(top: 8.0),
          color: Theme.of(context).backgroundColor,
          child: BlocBuilder<PlayersCubit, PlayersState>(
            builder: (playersCubitBuilderContext, state) => Container(
              child: state.playersCount == 0 || !state.wasAdded
                  ? Center(
                      child: Center(
                        child: Text(
                          'No players!',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                    )
                  : PlayersRankListWidget(),
            ),
          ),
        ),
      ),
    );
  }
}
