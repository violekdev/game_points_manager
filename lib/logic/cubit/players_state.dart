part of 'players_cubit.dart';

class PlayersState {
  int playersCount;
  List<Map<String, dynamic>> playersDetails;
  bool wasAdded;
  List<Map<String, dynamic>> playerRankings;
  Map<dynamic, dynamic> oldState;
  bool sortHighToLow;

  PlayersState({
    this.playersCount,
    this.playersDetails,
    this.wasAdded,
    this.playerRankings,
    this.oldState,
    this.sortHighToLow,
  });

  Map<String, dynamic> toMap() {
    return {
      'playersCount': playersCount,
      'playersDetails': playersDetails,
      'wasAdded': wasAdded,
      'playerRankings': {},
      'oldState': {},
      'sortHighToLow': sortHighToLow,
    };
  }

  factory PlayersState.fromMap(Map<String, dynamic> map) {
    return PlayersState(
      playersCount: map['playersCount'],
      playersDetails: List<Map<String, dynamic>>.from(map['playersDetails']),
      wasAdded: map['wasAdded'],
      playerRankings: [],
      oldState: {},
      sortHighToLow: map['sortHighToLow'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PlayersState.fromJson(String source) =>
      PlayersState.fromMap(json.decode(source));
}
