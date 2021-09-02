import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_points_manager/logic/cubit/players_cubit.dart';
import 'package:sizer/sizer.dart';

class PlayerCount extends StatefulWidget {
  PlayerCount();

  @override
  _PlayerCountState createState() => _PlayerCountState();
}

class _PlayerCountState extends State<PlayerCount> {
  final _pCountController = TextEditingController();
  final _pCounterFocusNode = FocusNode();
  var _isValidted = false;

  @override
  void initState() {
    super.initState();
    _pCountController.text = '0';
  }

  @override
  void dispose() {
    _pCountController.dispose();
    _pCounterFocusNode.dispose();
    super.dispose();
  }

  void validatePlayerCount() {
    _pCountController.text != ''
        ? setState(() {
            _isValidted = true;
          })
        : setState(() {
            _isValidted = false;
          });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: Theme.of(context).cardColor,
      elevation: 5,
      child: Container(
        padding: EdgeInsets.only(
          top: 0.1.h,
          left: 2.h,
          right: 2.h,
          bottom: 0.1.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Enter no. of Players!'),
              controller: _pCountController,
              keyboardType: TextInputType.number,
              focusNode: _pCounterFocusNode,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
              onTap: () => _pCountController.selection = TextSelection(
                  baseOffset: 0,
                  extentOffset: _pCountController.value.text.length),
              onChanged: (_) => validatePlayerCount(),
            ),
            Center(
              child: ElevatedButton(
                child: Text('Next'),
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(
                    color: Colors.white,
                  ),
                  primary: _isValidted
                      ? Theme.of(context).buttonColor
                      : Theme.of(context).disabledColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  _pCounterFocusNode.unfocus();
                  if (_isValidted)
                    BlocProvider.of<PlayersCubit>(context)
                        .setPlayersCount(int.parse(_pCountController.text));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
