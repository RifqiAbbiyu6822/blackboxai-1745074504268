import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/steam_game.dart';

class SteamApiService {
  static const String steamApiUrl = 'https://api.steampowered.com/ISteamApps/GetAppList/v2/';

  Future<List<SteamGame>> fetchSteamGames() async {
    try {
      final response = await http.get(Uri.parse(steamApiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final apps = data['applist']['apps'] as List<dynamic>;
        // For demo, limit to first 20 games
        final games = apps.take(20).map((app) {
          return SteamGame(
            appId: app['appid'],
            name: app['name'],
            headerImage: 'https://cdn.cloudflare.steamstatic.com/steam/apps/\${app['appid']}/header.jpg',
            trailerUrl: '',
            steamPageUrl: 'https://store.steampowered.com/app/\${app['appid']}',
          );
        }).toList();
        return games;
      }
    } catch (e) {
      print('Error fetching Steam games: \$e');
    }
    return [];
  }
}
