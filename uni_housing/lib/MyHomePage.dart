import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase/supabase.dart';
import 'ListingDetails.dart';
import 'AddListing.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic>? _housingData;
  String _searchTerm = '';

  @override
  Widget build(BuildContext context) {
    final filteredData = _housingData
        ?.where((data) =>
            data['location'].toLowerCase().contains(_searchTerm.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Colors.blue,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: _goToAddListing,
        child: Icon(
          Icons.add,
          color: Color.fromARGB(255, 33, 79, 243),
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.blue,
        title: Text(
          'UniHousing',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final searchTerm = await showSearch(
                context: context,
                delegate: HousingDataSearchDelegate(_housingData),
              );
              setState(() {
                _searchTerm = searchTerm ?? '';
              });
            },
          ),
        ],
      ),
      body: _housingData == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: filteredData?.length ?? 0,
              itemBuilder: (context, index) {
                final rowData = filteredData![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListingDetails(rowData: rowData),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin:
                        EdgeInsets.only(left: 12, right: 12, top: 5, bottom: 5),
                    child: ListTile(
                      title: Text(
                        rowData['location'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Type: ' + rowData['type']),
                      trailing: Container(
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Center(
                            child: Text(
                              '\$${rowData['price']}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Color.fromARGB(255, 33, 79, 243)),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  void _goToAddListing() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddListing()),
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchHousingData();
  }

  Future<void> _fetchHousingData() async {
    final response = await Supabase.instance.client
        .from('housing_data')
        .select(
            'location, price, type, description, city, zipcode, address_line, state')
        .execute();
    setState(() {
      _housingData = response.data;
    });
  }
}

class HousingDataSearchDelegate extends SearchDelegate<String?> {
  final List<dynamic>? housingData;

  HousingDataSearchDelegate(this.housingData);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final filteredData = housingData
        ?.where((data) =>
            data['location'].toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: filteredData?.length ?? 0,
      itemBuilder: (context, index) {
        final rowData = filteredData![index];
        return ListTile(
          title: Text(rowData['location']),
          subtitle: Text(rowData['type']),
          trailing: Text('\$${rowData['price']}'),
          onTap: () {
            close(context, rowData['location']);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final filteredData = housingData
        ?.where((data) =>
            data['location'].toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: filteredData?.length ?? 0,
      itemBuilder: (context, index) {
        final rowData = filteredData![index];
        return ListTile(
          title: Text(rowData['location']),
          subtitle: Text(rowData['type']),
          trailing: Text('\$${rowData['price']}'),
        );
      },
    );
  }
}
