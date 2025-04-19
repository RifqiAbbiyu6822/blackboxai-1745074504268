import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import '../models/steam_game.dart';
import '../services/steam_api_service.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/favorite_button.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SteamGameListScreen extends StatefulWidget {
  @override
  _SteamGameListScreenState createState() => _SteamGameListScreenState();
}

class _SteamGameListScreenState extends State<SteamGameListScreen> {
  final SteamApiService _apiService = SteamApiService();
  List<SteamGame> _games = [];
  Set<int> _favoriteAppIds = Set();
  Map<int, VideoPlayerController> _videoControllers = {};

  @override
  void initState() {
    super.initState();
    _loadFavorites();
    _fetchGames();
  }

  @override
  void dispose() {
    _videoControllers.forEach((key, controller) {
      controller.dispose();
    });
    super.dispose();
  }

  Future<void> _loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final favs = prefs.getStringList('favoriteAppIds') ?? [];
    setState(() {
      _favoriteAppIds = favs.map((e) => int.parse(e)).toSet();
    });
  }

  Future<void> _saveFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favoriteAppIds', _favoriteAppIds.map((e) => e.toString()).toList());
  }

  void _fetchGames() async {
    try {
      final games = await _apiService.fetchSteamGames();
      setState(() {
        _games = games;
      });
      // Initialize video controllers for trailers if available
      for (var game in games) {
        if (game.trailerUrl.isNotEmpty) {
          final controller = VideoPlayerController.network(game.trailerUrl);
          await controller.initialize();
          _videoControllers[game.appId] = controller;
        }
      }
    } catch (e) {
      print('Error fetching or initializing games: \$e');
      setState(() {
        _games = [];
      });
    }
  }

  void _toggleFavorite(int appId) {
    setState(() {
      if (_favoriteAppIds.contains(appId)) {
        _favoriteAppIds.remove(appId);
      } else {
        _favoriteAppIds.add(appId);
      }
    });
    _saveFavorites().catchError((e) {
      print('Error saving favorites: \$e');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Steam Game List'),
      ),
      body: _games.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _games.length,
              itemBuilder: (context, index) {
                final game = _games[index];
                final isFavorite = _favoriteAppIds.contains(game.appId);
                final videoController = _videoControllers[game.appId];

                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(game.headerImage, fit: BoxFit.cover),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          game.name,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      if (videoController != null && videoController.value.isInitialized)
                        AspectRatio(
                          aspectRatio: videoController.value.aspectRatio,
                          child: VideoPlayer(videoController),
                        ),
                      ButtonBar(
                        alignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              // Open Steam page in browser
                              // Using url_launcher package would be ideal, but not included here
                            },
                            child: Text('Go to Steam Page'),
                          ),
                          FavoriteButton(
                            isFavorite: isFavorite,
                            onChanged: (fav) => _toggleFavorite(game.appId),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
      bottomNavigationBar: BottomNavBar(currentIndex: 0),
    );
  }
}
