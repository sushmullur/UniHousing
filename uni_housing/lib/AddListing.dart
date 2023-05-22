import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase/supabase.dart';
import 'MyHomePage.dart';

class AddListing extends StatefulWidget {
  @override
  _AddListingState createState() => _AddListingState();
}

class _AddListingState extends State<AddListing> {
  //coed or not
  String _selectedType = 'co-ed';

  //price
  final _priceController = TextEditingController();

  //description
  final _descriptionController = TextEditingController();

  //location
  final _locationController = TextEditingController();

  //state
  final _stateController = TextEditingController();

  //city
  final _cityController = TextEditingController();

  //zipcode
  final _zipcodeController = TextEditingController();

  //address
  final _addressLineController = TextEditingController();

  @override
  void dispose() {
    _priceController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Listing'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Price'),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            Text('Type'),
            DropdownButton<String>(
              value: _selectedType,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedType = newValue!;
                });
              },
              items: <String>['co-ed', 'boys only', 'girls only']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            Text('Description'),
            TextField(
              controller: _descriptionController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
            SizedBox(height: 16),
            Text('Location'),
            TextField(
              controller: _locationController,
            ),
            SizedBox(height: 16),
            Text('Street Address'),
            TextField(
              controller: _addressLineController,
            ),
            SizedBox(height: 16),
            Text('City'),
            TextField(
              controller: _cityController,
            ),
            SizedBox(height: 16),
            Text('State'),
            TextField(
              controller: _stateController,
            ),
            SizedBox(height: 16),
            Text('Zipcode'),
            TextField(
              controller: _zipcodeController,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addListing,
              child: Text('Add Listing'),
            ),
          ],
        ),
      ),
    );
  }

  void _addListing() async {
    int zipcode = int.tryParse(_zipcodeController.text) ?? 0;
    final response =
        await Supabase.instance.client.from('housing_data').insert({
      'price': _priceController.text,
      'type': _selectedType,
      'description': _descriptionController.text,
      'location': _locationController.text,
      'state': _stateController.text,
      'city': _cityController.text,
      'zipcode': zipcode,
      'address_line': _addressLineController.text,
    }).execute();
    if (response != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    }
  }
}
