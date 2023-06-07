import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import 'models/trip.dart';
import 'models/trip_activity.dart';

class TripProvider extends ChangeNotifier {
//  Variables
//ID generator
  final _uuid = const Uuid();

//  Trips list
  final List<Trip> _trips = [];

// Methods
//Trips
//Get trips
  List<Trip> get trips => _trips;

//Get trip
  Trip getTrip(String id) {
    return _trips.singleWhere((element) => element.id == id);
  }

//Add trip
  addTrip(String country, DateTime startDate, DateTime endDate) {
    //  Create ID
    final id = _uuid.v4();
    //  Add trip
    _trips.add(Trip(id, country, startDate, endDate));
    //Update UI
    notifyListeners();
  }

//Delete trip
  deleteTrip(String id) {
    //Remove where id matches to the element
    _trips.removeWhere((element) => element.id == id);
    //Update UI
    notifyListeners();
  }

//Trip activities
//Get trip activities
  List<TripActivity> getTripActivities(String id) {
    //  Get all activities for the trip with id
    return _trips.singleWhere((element) => element.id == id).activities;
  }

//Add trip activity
  addTripActivity(String tripId, String description) {
    //    //  Create ID
    final id = _uuid.v4();
    //  Add to list
    getTrip(id).addActivity(TripActivity(
      id,
      tripId,
      description,
    ));
    //Update UI
    notifyListeners();
  }

//Delete trip activity
  deleteTripActivity(String tripId,String activityId){
    //Delete the activity in this trip by its id
    getTrip(tripId).deleteActivity(activityId);
    //Update UI
    notifyListeners();
  }
}
