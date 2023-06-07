
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:trip_planner/provider/trip_provider.dart';

class AddTripActivity extends StatefulWidget {
  final String tripId;

  const AddTripActivity({super.key, required this.tripId});

  @override
  State<AddTripActivity> createState() => _AddTripActivityState();
}

class _AddTripActivityState extends State<AddTripActivity> {
  //Key for managing form
  final _formKey = GlobalKey<FormBuilderState>();

  _addTripActivity() {
    //  Validate form
    final isValid = _formKey.currentState!.validate();
    //  If valid
    if (isValid) {
      //  Save form
      _formKey.currentState!.save();
      //  Get provider
      final tripProvider = Provider.of<TripProvider>(context, listen: false);
      //  Get form values
      final formValue = _formKey.currentState!.value;
      //Get description and trim it of leading/trailing whitespace
      String description = formValue['description'].trim();
      //  Save value to provider
      tripProvider.addTripActivity(widget.tripId, description);
      //  Pop the form
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Trip Activity'),
      ),
      body: FormBuilder(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 12,
              ),
              //Text field for description
              FormBuilderTextField(
                name: 'description',
                decoration: const InputDecoration(hintText: 'Description'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: 'Enter description'),
                ]),
              ),
              //  Spacer to fill out space so button goes at bottom
              const Spacer(
                flex: 1,
              ),
              //Add button
              ElevatedButton(
                onPressed: () => _addTripActivity(),
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
