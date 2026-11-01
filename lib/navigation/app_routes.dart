import 'package:flutter/material.dart';

import '../pages/detail_pengajuan_page.dart';
import 'kerangka_navigasi.dart';

class AppRoutes {
  static const String beranda = '/';
  static const String detailPengajuan = '/detail-pengajuan';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case beranda:
        return MaterialPageRoute(builder: (_) => const KerangkaNavigasi());

      case detailPengajuan:
        return MaterialPageRoute(builder: (_) => const DetailPengajuanPage());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('Halaman Tidak Ditemukan')),
            body: const Center(child: Text('Route tidak ditemukan.')),
          ),
        );
    }
  }
}
