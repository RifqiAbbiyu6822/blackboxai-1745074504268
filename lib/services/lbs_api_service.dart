import 'dart:convert';
import 'package:http/http.dart' as http;

class LbsApiService {
  static const String apiUrl = 'https://ipapi.co/json/';

  Future<Map<String, dynamic>?> fetchLocation() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } catch (e) {
      print('Error fetching location: \$e');
    }
    return null;
  }
}
