import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_points_manager/logic/cubit/players_cubit.dart';
import 'package:game_points_manager/presentation/screens/players_ranking_screen/widgets/players_rank_widget.dart';
import 'package:provider/provider.dart';

class PlayersRankListWidget extends StatefulWidget {
  PlayersRankListWidget();

  @override
  _PlayersRankListWidgetState createState() => _PlayersRankListWidgetState();
}

class _PlayersRankListWidgetState extends State<PlayersRankListWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Builder(
          builder: (ctx) => Expanded(
            child: ListView.builder(
                itemCount: ctx.read<PlayersCubit>().state.playersCount,
                itemBuilder: (ctx, i) => PlayersRankWidget(id: i)),
          ),
        ),
      ],
    );
  }
}
