import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:game_points_manager/logic/cubit/players_cubit.dart';
import 'package:game_points_manager/presentation/screens/add_players_screen/widgets/player_count.dart';
import 'package:game_points_manager/presentation/screens/add_players_screen/widgets/player_name.dart';

class AddPlayersScreen extends StatefulWidget {
  final String title;
  const AddPlayersScreen({
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  _AddPlayersScreenState createState() => _AddPlayersScreenState();
}

class _AddPlayersScreenState extends State<AddPlayersScreen> {
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (ctx) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to discard changes'),
            actions: <Widget>[
              TextButton(
                child: new Text('No'),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              TextButton(
                child: new Text('Yes'),
                onPressed: () {
                  if (BlocProvider.of<PlayersCubit>(context).state.oldState.length <= 0
                      ) {
                    Navigator.of(context).pop(false);
                  } 
                  else {
                    BlocProvider.of<PlayersCubit>(ctx).noNewGame();
                    Navigator.of(context).pop(true);
                  }
                },
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: BlocProvider.of<PlayersCubit>(context).state.oldState.length <= 0 ? null : _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          textTheme: Theme.of(context).appBarTheme.textTheme,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          actions: <Widget>[
            BlocBuilder<PlayersCubit, PlayersState>(
              builder: (playersCubitBuilderContext, state) => IconButton(
                icon: Icon(
                  Icons.save,
                ),
                disabledColor: Theme.of(context).disabledColor,
                onPressed: !state.wasAdded ||
                        state.playersDetails.length != state.playersCount
                    ? null
                    : () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
        body: Container(
          padding: EdgeInsets.only(top: 8.0),
          color: Theme.of(context).backgroundColor,
          child: BlocBuilder<PlayersCubit, PlayersState>(
            builder: (playersCubitBuilderContext, state) => Container(
              child: Flex(
                direction: Axis.vertical,
                children: <Widget>[
                  PlayerCount(),
                  Divider(),
                  Expanded(
                    flex: 1,
                    child: ListView.builder(
                      itemCount: state.playersCount,
                      itemBuilder: (playersCubitBuilderContext, i) =>
                          PlayerName(i),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
