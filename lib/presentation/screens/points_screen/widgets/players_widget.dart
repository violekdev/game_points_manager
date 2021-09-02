import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_points_manager/logic/cubit/players_cubit.dart';

import 'animated_count.dart';

class PlayersWidget extends StatefulWidget {
  final int id;
  PlayersWidget({
    Key key,
    @required this.id,
  }) : super(key: key);

  @override
  _PlayersWidgetState createState() => _PlayersWidgetState();
}

class _PlayersWidgetState extends State<PlayersWidget> {
  TextEditingController _pointsController = new TextEditingController();
  final _playerNamesController = TextEditingController();
  bool viewVisible = false;
  bool isEditNameEnabled = false;

  @override
  void dispose() {
    _pointsController.dispose();
    _playerNamesController.dispose();
    super.dispose();
  }

  void toggleWidgetVisibility() {
    setState(() {
      viewVisible = !viewVisible;
    });
  }

  void toggleWidgetNameEdit() {
    setState(() {
      isEditNameEnabled = !isEditNameEnabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.all(4),
            horizontalTitleGap: 0,
            leading: IconButton(
              icon: viewVisible
                  ? Icon(Icons.arrow_circle_up_rounded)
                  : Icon(Icons.arrow_drop_down_circle),
              onPressed: toggleWidgetVisibility,
              color: Theme.of(context).buttonColor,
            ),
            title: GestureDetector(
              onTap: toggleWidgetNameEdit,
              child: isEditNameEnabled
                  ? TextFormField(
                      controller: _playerNamesController,
                      enableInteractiveSelection: true,
                      decoration: InputDecoration(
                        labelText:
                            'Rename ${BlocProvider.of<PlayersCubit>(context).state.playersDetails[widget.id]['playerName']}',
                        suffixIcon: IconButton(
                          onPressed: toggleWidgetNameEdit,
                          icon: Icon(Icons.clear),
                        ),
                      ),
                      style: TextStyle(),
                      keyboardType: TextInputType.text,
                      // onTap: () => _playerNamesController.selection =
                      //     TextSelection(
                      //         baseOffset: 0,
                      //         extentOffset:
                      //             _playerNamesController.value.text.length),
                      // onChanged: (_) {
                      //   if (_playerNamesController.text != '')
                      //     BlocProvider.of<PlayersCubit>(context)
                      //         .addPlayerDetails(
                      //             widget.id, _playerNamesController.text);
                      // },
                      onEditingComplete: () => {
                        if (_playerNamesController.text != '')
                          BlocProvider.of<PlayersCubit>(context)
                              .addPlayerDetails(
                                  widget.id, _playerNamesController.text)
                      },
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                      ],
                      onFieldSubmitted: (_) => {toggleWidgetNameEdit()},
                    )
                  : Text(
                      context
                          .read<PlayersCubit>()
                          .state
                          .playersDetails[widget.id]['playerName'],
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
            ),
            trailing: BlocBuilder<PlayersCubit, PlayersState>(
              builder: (playersCubitBuilderContext, state) {
                return Container(
                  alignment: Alignment.center,
                  width: mediaQuery.size.width * 0.5,
                  margin: EdgeInsets.only(left: 8),
                  child: AnimatedCount(
                    prevCount: state.playersDetails[widget.id]['prevScore'],
                    currCount: state.playersDetails[widget.id]['currScore'],
                    duration: Duration(milliseconds: 500),
                  ),
                );
              },
            ),
            subtitle: Container(
              child: TextField(
                controller: _pointsController,
                decoration: InputDecoration(hintText: 'Add Points'),
                keyboardType: TextInputType.numberWithOptions(
                    signed: true, decimal: false),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                  FilteringTextInputFormatter.deny(','),
                  FilteringTextInputFormatter.deny('.'),
                ],
                onSubmitted: (value) {
                  BlocProvider.of<PlayersCubit>(context)
                      .setPlayersScore(widget.id, int.parse(value));
                  _pointsController.clear();
                },
              ),
            ),
            tileColor: Theme.of(context).cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(bottom: 16.0),
          //   child: Row(
          //     mainAxisSize: MainAxisSize.max,
          //     children: <Widget>[
          // Container(
          //   width: mediaQuery.size.width * 0.4,
          //   padding: EdgeInsets.only(left: mediaQuery.size.width * 0.04),
          //   child: TextField(
          //     controller: controller,
          //     decoration: InputDecoration(
          //       labelText: 'Add Points',
          //     ),
          //     keyboardType: TextInputType.numberWithOptions(
          //         signed: true, decimal: false),
          //     inputFormatters: [
          //       LengthLimitingTextInputFormatter(10),
          //       FilteringTextInputFormatter.deny(','),
          //     ],
          //     onSubmitted: (value) {
          //       BlocProvider.of<PlayersCubit>(context)
          //           .setPlayersScore(widget.id, int.parse(value));
          //       controller.clear();
          //     },
          //   ),
          // ),
          // BlocBuilder<PlayersCubit, PlayersState>(
          //   builder: (playersCubitBuilderContext, state) {
          //     return Container(
          //       alignment: Alignment.center,
          //       width: mediaQuery.size.width * 0.5,
          //       margin: EdgeInsets.only(left: 8),
          //       child: AnimatedCount(
          //         prevCount: state.playersDetails[widget.id]['prevScore'],
          //         currCount: state.playersDetails[widget.id]['currScore'],
          //         duration: Duration(milliseconds: 500),
          //       ),
          //     );
          //   },
          //       // ),
          //     ],
          //   ),
          // ),
          Visibility(
            maintainSize: false,
            maintainAnimation: true,
            maintainState: true,
            visible: viewVisible,
            child: Padding(
              padding:
                  const EdgeInsets.only(right: 4.0, bottom: 4.0, left: 8.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: mediaQuery.size.width * 0.125,
                  minHeight: mediaQuery.size.width * 0.07,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: BlocProvider.of<PlayersCubit>(context)
                              .state
                              .playersDetails[widget.id]['scoreTimeline'] !=
                          ''
                      ? Text(
                          BlocProvider.of<PlayersCubit>(context)
                              .state
                              .playersDetails[widget.id]['scoreTimeline'],
                          style: TextStyle(fontSize: 18),
                        )
                      : Text('0', style: TextStyle(fontSize: 18)),
                ),
              ),
            ),
          ),
          // ButtonBar(
          //   alignment: MainAxisAlignment.start,
          //   children: [
          //     TextButton(
          //       onPressed: () {
          //         // Perform some action
          //       },
          //       child: const Text('ACTION 1'),
          //     ),
          //     TextButton(
          //       onPressed: () {
          //         // Perform some action
          //       },
          //       child: const Text('ACTION 2'),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
