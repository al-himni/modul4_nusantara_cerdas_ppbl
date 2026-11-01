import 'package:flutter/foundation.dart';

class Pengajuan {
  final String nama;
  final String email;
  final String sesi;

  Pengajuan({required this.nama, required this.email, required this.sesi});
}

class PengajuanModel extends ChangeNotifier {
  final List<Pengajuan> _pengajuan = [];

  List<Pengajuan> get pengajuan => List.unmodifiable(_pengajuan);

  void tambahPengajuan(Pengajuan data) {
    _pengajuan.add(data);
    notifyListeners();
  }

  int jumlahSesi(String sesi) {
    return _pengajuan.where((item) => item.sesi == sesi).length;
  }

  void hapusSemua() {
    _pengajuan.clear();
    notifyListeners();
  }
}
