import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_planner/provider/models/trip_activity.dart';
import 'package:trip_planner/provider/trip_provider.dart';

class TripActivityCard extends StatelessWidget {
  final String tripId;
  final TripActivity tripActivity;

  const TripActivityCard(this.tripActivity, {super.key, required this.tripId});

  @override
  Widget build(BuildContext context) {
    return Consumer<TripProvider>(
      builder: (context, tripProvider, child) => Dismissible(
        //Required for UI to update correctly when deleting
        key: ValueKey(tripActivity.id),
        //Background behind card when swiping
        background: Container(
          color: Colors.red,
        ),
        //Delete trip on swipe
        onDismissed: (direction) =>
            tripProvider.deleteTripActivity(tripId, tripActivity.id),
        child: Card(
          child: CheckboxListTile(
            value: tripActivity.isComplete,
            onChanged: (value) {
              if (value == true) {
                tripProvider.markTripActivityComplete(tripId, tripActivity.id);
              } else {
                tripProvider.markTripActivityIncomplete(
                    tripId, tripActivity.id);
              }
            },
            title: Text(tripActivity.description),
            //Start and end date
          ),
        ),
      ),
    );
  }
}
