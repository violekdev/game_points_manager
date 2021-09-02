import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_points_manager/logic/cubit/players_cubit.dart';

class SinglePlayerName extends StatefulWidget {
  @override
  _SinglePlayerNameState createState() => _SinglePlayerNameState();
}

class _SinglePlayerNameState extends State<SinglePlayerName> {
  final _playerNamesController = TextEditingController();
  var _isValidted = false;

  void validatePlayerCount() {
    _playerNamesController.text != '' &&
            _playerNamesController.text != ''
        ? setState(() {
            _isValidted = true;
          })
        : setState(() {
            _isValidted = false;
          });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        margin: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextFormField(
                controller: _playerNamesController,
                decoration: InputDecoration(labelText: 'Enter player name'),
                keyboardType: TextInputType.text,
                onChanged: (_) => validatePlayerCount(),
              ),
              ElevatedButton(
                child: Text('Add'),
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(
                    color: Colors.white,
                  ),
                  primary: _isValidted
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).accentColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  BlocProvider.of<PlayersCubit>(context)
                      .addSinglePlayerDetails(_playerNamesController.text);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
