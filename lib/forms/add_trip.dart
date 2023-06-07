import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class AddTrip extends StatefulWidget {
  const AddTrip({super.key});

  @override
  State<AddTrip> createState() => _AddTripState();
}

class _AddTripState extends State<AddTrip> {
  //Key for managing form
  final _formKey = GlobalKey<FormBuilderState>();

  //Countries variable, used to track initial loading
  late Future<List<String>> _countries;

  //  Get countries
  Future<List<String>> _getCountries() async {
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
    return countries;
  }

  @override
  void initState() {
    super.initState();
    _countries = _getCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Trip'),
      ),
      body: FutureBuilder<List<String>>(
        future: _countries,
        builder: (context, snapshot) {
          //  If data not retrieved yet show loading
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          //  Get list of countries
          List<String> countries = snapshot.data!;
          //Return form
          return FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                //Searchable dropdown
                FormBuilderSearchableDropdown<String>(
                  name: 'country',
                  popupProps: const PopupProps.menu(showSearchBox: true),
                  dropdownSearchDecoration: const InputDecoration(
                    hintText: 'Search',
                  ),
                  items: countries,
                  decoration:
                      const InputDecoration(hintText: 'Search for a country'),
                  filterFn: (country, filter) =>
                      country.toLowerCase().contains(filter.toLowerCase()),
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
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Submit'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
