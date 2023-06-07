import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:trip_planner/provider/trip_provider.dart';

import '../../../provider/models/trip.dart';

class TripCard extends StatelessWidget {
  final Trip trip;

  const TripCard(this.trip, {super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TripProvider>(
      builder: (context, tripProvider, child) => Dismissible(
        //Required for UI to update correctly when deleting
        key: ValueKey(trip.id),
        //Background behind card when swiping
        background: Container(
          color: Colors.red,
        ),
        //Delete trip on swipe
        onDismissed: (direction) => tripProvider.deleteTrip(trip.id),
        child: Card(
          child: ListTile(
            //Leading trip activities count
            leading: Text('${tripProvider.getTripActivities(trip.id).length}'),
            title: Text(trip.country),
            //Start and end date
            subtitle: Column(
              //Column starts on the left
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Start: ${DateFormat('dd/MM/yyyy').format(trip.startDate)}'),
                Text('End: ${DateFormat('dd/MM/yyyy').format(trip.endDate)}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
