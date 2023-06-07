// ignore_for_file: unnecessary_getters_setters

class TripActivity{
  final String _id;
  final String _tripId;
  final String _description;
  bool _isComplete = false;

  TripActivity(this._id, this._tripId, this._description);

  bool get isComplete => _isComplete;

  set isComplete(bool value) {
    _isComplete = value;
  }

  String get description => _description;

  String get tripId => _tripId;

  String get id => _id;

}