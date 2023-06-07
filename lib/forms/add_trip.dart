import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:trip_planner/provider/trip_provider.dart';

class AddTrip extends StatefulWidget {
  const AddTrip({super.key});

  @override
  State<AddTrip> createState() => _AddTripState();
}

class _AddTripState extends State<AddTrip> {
  //Key for managing form
  final _formKey = GlobalKey<FormBuilderState>();

  //Countries variable, used to track initial loading
  late Future<List<DropdownMenuItem>> _countryItems;

  //  Get countries
  Future<List<DropdownMenuItem>> _getCountryItems() async {
    //Get the response
    final response =
        await http.get(Uri.parse('https://restcountries.com/v3.1/all'));
    //  Get the json data
    List data = jsonDecode(response.body);
    //  Map the array to a list of country strings
    List<String> countries =
        data.map((e) => e['name']['common'] as String).toList();
    //  Order them in alphabetical order
    countries.sort(
      (a, b) => a.compareTo(b),
    );
    //  Map to country items
    final countryItems = countries
        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
        .toList();
    return countryItems;
  }

  @override
  void initState() {
    super.initState();
    _countryItems = _getCountryItems();
  }

  _addTrip(){
  //  Validate form
    final isValid = _formKey.currentState!.validate();
  //  If valid
    if(isValid){
    //  Save form
      _formKey.currentState!.save();
    //  Get provider
      final tripProvider = Provider.of<TripProvider>(context,listen: false);
    //  Get form values
      final formValue = _formKey.currentState!.value;
      String country = formValue['country'];
      DateTime startDate = formValue['start-date'];
      DateTime endDate = formValue['end-date'];
    //  Save value to provider
      tripProvider.addTrip(country, startDate, endDate);
    //  Pop the form
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Trip'),
      ),
      body: FutureBuilder<List<DropdownMenuItem>>(
        future: _countryItems,
        builder: (context, snapshot) {
          //  If data not retrieved yet show loading
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          //  Get list of countries
          List<DropdownMenuItem> countryItems = snapshot.data!;
          //Return form
          return FormBuilder(
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
                  //Searchable dropdown
                  FormBuilderDropdown(
                    name: 'country',
                    items: countryItems,
                    decoration:
                        const InputDecoration(hintText: 'Select country'),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: 'Please select a country'),
                    ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //Start and end dates
                  Row(
                    children: [
                      Expanded(
                        child: FormBuilderDateTimePicker(
                          name: 'start-date',
                          format: DateFormat('dd/MM/yyyy'),
                          inputType: InputType.date,
                          decoration: const InputDecoration(
                            hintText: 'Start Date',
                          ),
                          validator: (value) {
                            //  If no date picked, show error
                            if (value == null) {
                              return 'Pick a start date';
                            }
                            //If value not before end date, return error
                            if (!value.isBefore(_formKey
                                .currentState!.fields['end-date']!.value)) {
                              return 'Must be Before End Date';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: FormBuilderDateTimePicker(
                          name: 'end-date',
                          inputType: InputType.date,
                          format: DateFormat('dd/MM/yyyy'),
                          decoration: const InputDecoration(
                            hintText: 'End Date',
                          ),
                          validator: (value) {
                            //If value null, return error
                            if (value == null) {
                              return 'Pick an end date';
                            }
                            //If value not after start date, return error
                            if (!value.isAfter(_formKey
                                .currentState!.fields['start-date']!.value)) {
                              return 'Must be After Start Date';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  //  Spacer to fill out space so button goes at bottom
                  const Spacer(
                    flex: 1,
                  ),
                  //Add button
                  ElevatedButton(
                    onPressed: () => _addTrip(),
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
