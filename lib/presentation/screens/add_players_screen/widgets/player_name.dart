import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_points_manager/logic/cubit/players_cubit.dart';
import 'package:sizer/sizer.dart';


class PlayerName extends StatefulWidget {
  final int id;

  PlayerName(this.id);

  @override
  _PlayerNameState createState() => _PlayerNameState();
}

class _PlayerNameState extends State<PlayerName> {
  final _playerNamesController = TextEditingController();

  @override
  void initState() {
    _playerNamesController.text = 'player #${widget.id + 1}';
    super.initState();
  }

  @override
  void dispose() {
    _playerNamesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 0.10.h,
            left: 2.h,
            right: 2.h,
            bottom: MediaQuery.of(context).viewInsets.bottom + 1.5.h,
          ),
          margin: EdgeInsets.only(bottom: 8.0),
          child: TextFormField(
            controller: _playerNamesController,
            decoration: InputDecoration(
              labelText: 'Enter player #${widget.id + 1} name',
            ),
            style: TextStyle(),
            keyboardType: TextInputType.text,
            inputFormatters: [
              LengthLimitingTextInputFormatter(10),
            ],
            onTap: () => _playerNamesController.selection = TextSelection(
                baseOffset: 0,
                extentOffset: _playerNamesController.value.text.length),
            onChanged: (_) {
              if (_playerNamesController.text != '')
                BlocProvider.of<PlayersCubit>(context)
                    .addPlayerDetails(widget.id, _playerNamesController.text);
            },
          ),
        ),
      ),
    );
  }
}
