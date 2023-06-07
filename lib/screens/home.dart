import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_planner/forms/add_trip.dart';
import 'package:trip_planner/provider/trip_provider.dart';
import 'package:trip_planner/widgets/screens/home/trip_card.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TripProvider>(
      builder: (context, tripProvider, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Trip Planner'),
          actions: [
            //  Add Button
            TextButton.icon(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddTrip(),
                ),
              ),
              icon: const Icon(Icons.add),
              label: const Text('Add'),
            ),
          ],
        ),
        body: tripProvider.trips.isNotEmpty ? ListView.builder(
          padding: const EdgeInsets.only(
            top: 4,
            left: 20,
            right: 20,
          ),
          itemCount: tripProvider.trips.length,
          itemBuilder: (context, index) => TripCard(
            tripProvider.trips[index],
          ),
        ) : const Center(
          child: Text('Add a trip'),
        ),
      ),
    );
  }
}
