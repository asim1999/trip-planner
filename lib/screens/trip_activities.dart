import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_planner/forms/add_trip_activity.dart';
import 'package:trip_planner/widgets/screens/trip_activities/trip_activity_card.dart';

import '../provider/trip_provider.dart';

class TripActivities extends StatelessWidget {
  final String tripId;

  const TripActivities({super.key, required this.tripId});

  @override
  Widget build(BuildContext context) {
    return Consumer<TripProvider>(
      builder: (context, tripProvider, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Trip Activities'),
          actions: [
            //  Add Button
            TextButton.icon(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddTripActivity(tripId: tripId),
                ),
              ),
              icon: const Icon(Icons.add),
              label: const Text('Add'),
            ),
          ],
        ),
        body: tripProvider.getTripActivities(tripId).isNotEmpty
            ? ListView.builder(
                padding: const EdgeInsets.only(
                  top: 4,
                  left: 20,
                  right: 20,
                ),
                itemCount: tripProvider.getTripActivities(tripId).length,
                itemBuilder: (context, index) => TripActivityCard(
                  tripProvider.getTripActivities(tripId)[index],
                  tripId: tripId,
                ),
              )
            : const Center(
                child: Text('Add a trip activity'),
              ),
      ),
    );
  }
}
