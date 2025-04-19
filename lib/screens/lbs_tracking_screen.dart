import 'package:flutter/material.dart';
import '../services/lbs_api_service.dart';
import '../widgets/bottom_nav_bar.dart';

class LbsTrackingScreen extends StatefulWidget {
  @override
  _LbsTrackingScreenState createState() => _LbsTrackingScreenState();
}

class _LbsTrackingScreenState extends State<LbsTrackingScreen> {
  Map<String, dynamic>? _locationData;
  bool _loading = false;
  final LbsApiService _apiService = LbsApiService();

  void _fetchLocation() async {
    setState(() {
      _loading = true;
    });
    final data = await _apiService.fetchLocation();
    setState(() {
      _locationData = data;
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LBS Tracking'),
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : _locationData == null
              ? Center(child: Text('Failed to fetch location data'))
              : Padding(
                  padding: EdgeInsets.all(16.0),
                  child: ListView(
                    children: [
                      Text('IP: \${_locationData!['ip'] ?? 'N/A'}'),
                      Text('City: \${_locationData!['city'] ?? 'N/A'}'),
                      Text('Region: \${_locationData!['region'] ?? 'N/A'}'),
                      Text('Country: \${_locationData!['country_name'] ?? 'N/A'}'),
                      Text('Latitude: \${_locationData!['latitude'] ?? 'N/A'}'),
                      Text('Longitude: \${_locationData!['longitude'] ?? 'N/A'}'),
                      Text('Postal: \${_locationData!['postal'] ?? 'N/A'}'),
                      Text('Timezone: \${_locationData!['timezone'] ?? 'N/A'}'),
                    ],
                  ),
                ),
      bottomNavigationBar: BottomNavBar(currentIndex: 0),
    );
  }
}
