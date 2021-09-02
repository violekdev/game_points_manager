import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_points_manager/logic/cubit/players_cubit.dart';
import 'package:sizer/sizer.dart';

class PlayersRankWidget extends StatefulWidget {
  final int id;
  PlayersRankWidget({
    Key key,
    @required this.id,
  }) : super(key: key);

  @override
  _PlayersRankWidgetState createState() => _PlayersRankWidgetState();
}

class _PlayersRankWidgetState extends State<PlayersRankWidget> {
  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.symmetric(vertical: 0.75.h, horizontal: 1.h),
      elevation: 5,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 0.1.h, horizontal: 1.h),
        child: BlocBuilder<PlayersCubit, PlayersState>(
          builder: (playersDetailsCubitBuilderContext, state) {
            return ListTile(
              leading: Text(
                (widget.id + 1).toString(),
                style: Theme.of(context).textTheme.headline6,
              ),
              title: Text(
                state.playerRankings[widget.id]['playerName'],
                style: Theme.of(context).textTheme.headline6,
              ),
              trailing: Text(
                state.playerRankings[widget.id]['currScore'].toString(),
                style: Theme.of(context).textTheme.headline6,
              ),
            );
            //
          },
        ),
      ),
    );
  }
}
