import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/session_manager.dart';
import '../screens/home_screen.dart';
import '../screens/member_list_screen.dart';
import '../screens/help_screen.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  BottomNavBar({required this.currentIndex});

  void _onTap(BuildContext context, int index) {
    final sessionManager = Provider.of<SessionManager>(context, listen: false);
    switch (index) {
      case 0:
        if (currentIndex != 0) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => HomeScreen()),
            (route) => false,
          );
        }
        break;
      case 1:
        if (currentIndex != 1) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => MemberListScreen()),
            (route) => false,
          );
        }
        break;
      case 2:
        if (currentIndex != 2) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => HelpScreen()),
            (route) => false,
          );
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final sessionManager = Provider.of<SessionManager>(context);

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        if (index == 2) {
          // Help menu includes logout button, so just navigate to HelpScreen
          _onTap(context, index);
        } else {
          _onTap(context, index);
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.group),
          label: 'Members',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.help),
          label: 'Help / Logout',
        ),
      ],
    );
  }
}
