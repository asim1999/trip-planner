import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_planner/provider/trip_provider.dart';
import 'package:trip_planner/widgets/screens/home/trip_card.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TripProvider>(
      builder: (context, tripProvider, child) => Scaffold(
        appBar: AppBar(
          title: Text('Trip Planner'),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: tripProvider.trips.length,
          itemBuilder: (context, index) => TripCard(
            tripProvider.trips[index],
          ),
        ),
      ),
    );
  }
}
