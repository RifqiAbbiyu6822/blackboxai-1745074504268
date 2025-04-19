import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';

class MemberListScreen extends StatelessWidget {
  final List<String> members = [
    'Member 1',
    'Member 2',
    'Member 3',
    'Member 4',
    'Member 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Anggota'),
      ),
      body: ListView.builder(
        itemCount: members.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(child: Text(members[index][0])),
            title: Text(members[index]),
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 1),
    );
  }
}
