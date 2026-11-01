import 'package:flutter/material.dart';

import '../pages/formulir_page.dart';
import '../pages/chat_page.dart';
import '../pages/peta_page.dart';
import '../pages/statistik_page.dart';

class KerangkaNavigasi extends StatefulWidget {
  const KerangkaNavigasi({super.key});

  @override
  State<KerangkaNavigasi> createState() => _KerangkaNavigasiState();
}

class _KerangkaNavigasiState extends State<KerangkaNavigasi> {
  int halamanAktif = 0;

  final List<Widget> halaman = const [
    FormulirPage(),
    ChatPage(),
    PetaPage(),
    StatistikPage(),
  ];

  final List<String> judul = const ['Formulir', 'Chat', 'Peta', 'Statistik'];

  final List<IconData> ikon = const [
    Icons.assignment,
    Icons.chat,
    Icons.map,
    Icons.bar_chart,
  ];

  @override
  Widget build(BuildContext context) {
    final lebar = MediaQuery.of(context).size.width;
    final layarLebar = lebar >= 700;

    if (layarLebar) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: halamanAktif,
              onDestinationSelected: (index) {
                setState(() {
                  halamanAktif = index;
                });
              },
              labelType: NavigationRailLabelType.all,
              destinations: List.generate(
                judul.length,
                (index) => NavigationRailDestination(
                  icon: Icon(ikon[index]),
                  label: Text(judul[index]),
                ),
              ),
            ),
            const VerticalDivider(width: 1),
            Expanded(child: halaman[halamanAktif]),
          ],
        ),
      );
    }

    return Scaffold(
      body: halaman[halamanAktif],
      bottomNavigationBar: NavigationBar(
        selectedIndex: halamanAktif,
        onDestinationSelected: (index) {
          setState(() {
            halamanAktif = index;
          });
        },
        destinations: List.generate(
          judul.length,
          (index) => NavigationDestination(
            icon: Icon(ikon[index]),
            label: judul[index],
          ),
        ),
      ),
    );
  }
}
