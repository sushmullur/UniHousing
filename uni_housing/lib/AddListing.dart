import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase/supabase.dart';
import 'MyHomePage.dart';

class AddListing extends StatefulWidget {
  @override
  _AddListingState createState() => _AddListingState();
}

class _AddListingState extends State<AddListing> {
  String _selectedType = 'co-ed';
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();

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
    final response =
        await Supabase.instance.client.from('housing_data').insert({
      'price': _priceController.text,
      'type': _selectedType,
      'description': _descriptionController.text,
      'location': _locationController.text,
    }).execute();
    if (response != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    }
  }
}
