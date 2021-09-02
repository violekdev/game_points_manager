import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_points_manager/logic/cubit/players_cubit.dart';
import 'package:game_points_manager/presentation/screens/points_screen/widgets/SinglePlayerName.dart';
import '../../../../widgets/../presentation/screens/points_screen/widgets/players_widget.dart';

class PlayersListWidget extends StatefulWidget {
  PlayersListWidget();

  @override
  _PlayersListWidgetState createState() => _PlayersListWidgetState();
}

class _PlayersListWidgetState extends State<PlayersListWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Builder(
          builder: (ctx) => Expanded(
            child: BlocBuilder<PlayersCubit, PlayersState>(
              builder: (playersCubitContext, state) => ListView.builder(
                  itemCount: state.playersCount,
                  itemBuilder: (playersCubitContext, i) =>
                      PlayersWidget(id: i)),
            ),
          ),
        ),
        ElevatedButton.icon(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (_) {
                return SinglePlayerName();
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
            );
          },
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
          label: Text(
            'Add a Player',
            style: TextStyle(color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            primary: Theme.of(context).primaryColor,
            onPrimary: Theme.of(context).iconTheme.color,
          ),
        ),
      ],
    );
  }
}
