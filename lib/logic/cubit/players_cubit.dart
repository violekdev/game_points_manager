import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'dart:convert';

part 'players_state.dart';

class PlayersCubit extends Cubit<PlayersState> with HydratedMixin {
  PlayersCubit()
      : super(PlayersState(
          playersCount: 0,
          playersDetails: [],
          wasAdded: false,
          playerRankings: [],
          oldState: {},
          sortHighToLow: true,
        ));

  void setPlayersCount(playersCount) {
    var newList = List<Map<String, dynamic>>.filled(playersCount, {
      'id': 0,
      'playerName': '',
      'prevScore': 0,
      'currScore': 0,
      'scoreTimeline': '',
    });
    emit(PlayersState(
      playersCount: playersCount,
      playersDetails: newList,
      wasAdded: false,
      playerRankings: [],
      oldState: state.oldState,
      sortHighToLow: state.sortHighToLow,
    ));

    for (var i = 0; i < playersCount; i++) {
      addPlayerDetails(i, "Player #" + (i + 1).toString());
    }
  }

  void newGame() => emit(PlayersState(
        oldState: {
          'playersCount': state.playersCount,
          'playersDetails': state.playersDetails,
          'wasAdded': state.wasAdded,
          'playerRankings': state.playerRankings,
        },
        playersCount: 0,
        playersDetails: [],
        wasAdded: false,
        playerRankings: [],
        sortHighToLow: state.sortHighToLow,
      ));

  void noNewGame() => emit(PlayersState(
        playersCount: state.oldState['playersCount'],
        playersDetails: state.oldState['playersDetails'],
        wasAdded: state.oldState['wasAdded'],
        playerRankings: state.oldState['playerRankings'],
        oldState: {},
        sortHighToLow: state.sortHighToLow,
      ));

  void addPlayerDetails(id, playerName) {
    var newEntries = state.playersDetails;
    newEntries[id] = {
      'id': id,
      'playerName': playerName,
      'prevScore': 0,
      'currScore': 0,
      'scoreTimeline': '',
    };
    emit(PlayersState(
      playersCount: state.playersCount,
      playersDetails: newEntries,
      wasAdded: true,
      playerRankings: [],
      oldState: state.oldState,
      sortHighToLow: state.sortHighToLow,
    ));
  }

  void addSinglePlayerDetails(playerName) {
    var entries = state.playersDetails;

    var newList = List<Map<String, dynamic>>.filled(state.playersCount + 1, {
      'id': 0,
      'playerName': '',
      'prevScore': 0,
      'currScore': 0,
      'scoreTimeline': '',
    });

    newList = List.from(entries);
    newList.add({
      'id': id,
      'playerName': playerName,
      'prevScore': 0,
      'currScore': 0,
      'scoreTimeline': '',
    });

    emit(PlayersState(
      playersCount: state.playersCount + 1,
      playersDetails: newList,
      wasAdded: true,
      playerRankings: [],
      oldState: state.oldState,
      sortHighToLow: state.sortHighToLow,
    ));
  }

  void setPlayersScore(id, score) {
    var newEntries = state.playersDetails;
    newEntries[id] = {
      'id': id,
      'playerName': state.playersDetails[id]['playerName'],
      'prevScore': state.playersDetails[id]['currScore'],
      'currScore': state.playersDetails[id]['currScore'] + score,
      'scoreTimeline':
          state.playersDetails[id]['scoreTimeline'] + score.toString() + ' + ',
    };
    emit(PlayersState(
      playersCount: state.playersCount,
      playersDetails: newEntries,
      wasAdded: true,
      playerRankings: [],
      oldState: state.oldState,
      sortHighToLow: state.sortHighToLow,
    ));
  }

  void resetExistingPlayerDetails() {
    var entries = state.playersDetails;

    entries.forEach((element) {
      element.update('prevScore', (_) => element['prevScore'] = 0);
      element.update('currScore', (_) => element['currScore'] = 0);
      element.update('scoreTimeline', (_) => element['scoreTimeline'] = '');
    });
    emit(PlayersState(
      playersCount: state.playersCount,
      playersDetails: entries,
      wasAdded: true,
      playerRankings: [],
      oldState: state.oldState,
      sortHighToLow: state.sortHighToLow,
    ));
  }

  void deletePlayerDetails() => emit(PlayersState(
        playersCount: 0,
        playersDetails: [],
        wasAdded: false,
        playerRankings: [],
        oldState: {},
        sortHighToLow: state.sortHighToLow,
      ));

  void setPlayerRankings() {
    var playerEntries = state.playersDetails;
    List<Map<String, dynamic>> sortedEntries = [];

    sortedEntries.addAll(playerEntries);
    state.sortHighToLow
        ? sortedEntries.sort(
            (item1, item2) => item1['currScore'] <= item2['currScore'] ? 1 : 0)
        : sortedEntries.sort(
            (item1, item2) => item1['currScore'] <= item2['currScore'] ? 0 : 1);

    emit(PlayersState(
      playersCount: state.playersCount,
      playersDetails: state.playersDetails,
      wasAdded: state.wasAdded,
      playerRankings: sortedEntries,
      oldState: state.oldState,
      sortHighToLow: state.sortHighToLow,
    ));
  }

  void setSortHighToLow(bool value) {
    emit(PlayersState(
      playersCount: state.playersCount,
      playersDetails: state.playersDetails,
      wasAdded: state.wasAdded,
      playerRankings: state.playerRankings,
      oldState: state.oldState,
      sortHighToLow: value,
    ));
  }

  void editPlayerName(id, newName) {
    var entries = state.playersDetails;
    entries[id]['playerName'] = newName;
  }

  @override
  PlayersState fromJson(Map<String, dynamic> json) {
    return PlayersState.fromMap(json);
  }

  @override
  Map<String, dynamic> toJson(PlayersState state) {
    return state.toMap();
  }
}
