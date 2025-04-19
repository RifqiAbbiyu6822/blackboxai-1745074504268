import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/session_manager.dart';
import 'stopwatch_screen.dart';
import 'number_type_screen.dart';
import 'lbs_tracking_screen.dart';
import 'time_conversion_screen.dart';
import 'steam_game_list_screen.dart';
import 'member_list_screen.dart';
import 'help_screen.dart';
import '../widgets/bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  final List<_MenuItem> menuItems = [
    _MenuItem('Stopwatch', Icons.timer, StopwatchScreen()),
    _MenuItem('Number Type', Icons.calculate, NumberTypeScreen()),
    _MenuItem('LBS Tracking', Icons.location_on, LbsTrackingScreen()),
    _MenuItem('Time Conversion', Icons.access_time, TimeConversionScreen()),
    _MenuItem('Steam Games', Icons.videogame_asset, SteamGameListScreen()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Menu'),
      ),
      body: Center(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: menuItems.length,
          itemBuilder: (context, index) {
            final item = menuItems[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 48.0),
              child: ElevatedButton.icon(
                icon: Icon(item.icon, size: 28),
                label: Text(item.title, style: TextStyle(fontSize: 20)),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => item.screen),
                  );
                },
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 0),
    );
  }
}

class _MenuItem {
  final String title;
  final IconData icon;
  final Widget screen;

  _MenuItem(this.title, this.icon, this.screen);
}
