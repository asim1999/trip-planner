import 'package:trip_planner/provider/models/trip_activity.dart';

class Trip {
  final String _id;
  final String _country;
  final DateTime _startDate;
  final DateTime _endDate;
  final List<TripActivity> _activities = [];

  Trip(this._id, this._country, this._startDate, this._endDate);

  DateTime get endDate => _endDate;

  DateTime get startDate => _startDate;

  String get country => _country;

  String get id => _id;

  List<TripActivity> get activities => _activities;

  addActivity(TripActivity newActivity) {
    _activities.add(newActivity);
  }

  deleteActivity(String id) {
    _activities.removeWhere((element) => element.id == id);
  }

  markActivityComplete(String id) {
    _activities.singleWhere((element) => element.id == id).isComplete = true;
  }

  markActivityIncomplete(String id) {
    _activities.singleWhere((element) => element.id == id).isComplete = false;
  }
}
