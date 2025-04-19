import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/bottom_nav_bar.dart';
import '../utils/session_manager.dart';

class HelpScreen extends StatelessWidget {
  final String usageInstructions = '''
Cara Penggunaan Aplikasi:

1. Login menggunakan username dan password.
2. Pada halaman utama, pilih salah satu menu aplikasi yang tersedia.
3. Gunakan aplikasi stopwatch untuk mengukur waktu.
4. Gunakan aplikasi jenis bilangan untuk mengetahui tipe bilangan.
5. Gunakan aplikasi tracking LBS untuk mengetahui lokasi Anda.
6. Gunakan aplikasi konversi waktu untuk mengubah tahun ke jam, menit, dan detik.
7. Gunakan daftar game Steam untuk melihat game favorit dan trailer.
8. Gunakan menu Daftar Anggota untuk melihat anggota tim.
9. Gunakan menu Bantuan untuk melihat instruksi ini atau logout dari aplikasi.
''';

  @override
  Widget build(BuildContext context) {
    final sessionManager = Provider.of<SessionManager>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Bantuan'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          usageInstructions,
          style: TextStyle(fontSize: 16),
        ),
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 2),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          sessionManager.logout();
          Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
        },
        label: Text('Logout'),
        icon: Icon(Icons.logout),
      ),
    );
  }
}
