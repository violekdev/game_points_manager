import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_points_manager/core/themes/app_theme.dart';
import 'package:game_points_manager/logic/cubit/players_cubit.dart';
import 'package:game_points_manager/logic/cubit/theme_cubit.dart';
import 'package:game_points_manager/presentation/router/app_router.dart';
import 'package:game_points_manager/presentation/screens/points_screen/widgets/players_list_widget.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

class PointsScreen extends StatefulWidget {
  final String title;
  PointsScreen({Key key, this.title}) : super(key: key);
  @override
  _PointsScreenState createState() => _PointsScreenState();
}

class _PointsScreenState extends State<PointsScreen> {
  @override
  void initState() {
    super.initState();
  }

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
      case 'New Game':
        {
          BlocProvider.of<PlayersCubit>(ctx).newGame();
          Navigator.of(ctx).pushNamed(AppRouter.addPlayers);
          break;
        }
      case 'Reset':
        BlocProvider.of<PlayersCubit>(ctx).resetExistingPlayerDetails();
        break;
      case 'Delete':
        BlocProvider.of<PlayersCubit>(ctx).deletePlayerDetails();
        break;
    }
  }

  Widget buildMenu() {
    return Builder(
      builder: (materialButtonContext) => Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: ListView(
          children: <Widget>[
            listTile(materialButtonContext, 'New Game', Icons.fiber_new),
            listTile(materialButtonContext, 'Reset', Icons.restore),
            listTile(materialButtonContext, 'Delete', Icons.delete),
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
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          textTheme: Theme.of(context).appBarTheme.textTheme,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              _sideMenuState = _sideMenuKey.currentState;
              if (_sideMenuState.isOpened)
                _sideMenuState.closeSideMenu();
              else
                _sideMenuState.openSideMenu();
            },
          ),
        ),
        body: Container(
          padding: EdgeInsets.only(top: 8.0),
          color: Theme.of(context).backgroundColor,
          child: BlocBuilder<PlayersCubit, PlayersState>(
            builder: (playersCubitBuilderContext, state) => Container(
              child: 
              (state.playersCount == null) ? Center(
                      child: Text(
                        'No players!',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ): 
                    (state.playersCount == 0 || !state.wasAdded ) 
                  ? Center(
                      child: Text(
                        'No players!',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    )
                  : PlayersListWidget(), 
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.assessment,
            size: 30,
          ),
          elevation: 5,
          backgroundColor: Theme.of(context).accentColor,
          foregroundColor: Theme.of(context).iconTheme.color,
          onPressed: () => {
            context.read<PlayersCubit>().setPlayerRankings(),
            Navigator.of(context).pushNamed(
              AppRouter.ranks,
            )
          },
        ),
      ),
    );
  }
}
