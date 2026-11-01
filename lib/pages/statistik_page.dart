import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/pengajuan_model.dart';

class StatistikPage extends StatelessWidget {
  const StatistikPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<PengajuanModel>();

    final pagi = model.jumlahSesi('Pagi');
    final siang = model.jumlahSesi('Siang');
    final sore = model.jumlahSesi('Sore');

    return Scaffold(
      appBar: AppBar(title: const Text('Statistik Layanan'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _statistik('Pagi', pagi),
                    _statistik('Siang', siang),
                    _statistik('Sore', sore),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            Expanded(
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY:
                      [
                        pagi,
                        siang,
                        sore,
                        1,
                      ].reduce((a, b) => a > b ? a : b).toDouble() +
                      2,
                  barGroups: [
                    BarChartGroupData(
                      x: 0,
                      barRods: [
                        BarChartRodData(toY: pagi.toDouble(), width: 35),
                      ],
                    ),
                    BarChartGroupData(
                      x: 1,
                      barRods: [
                        BarChartRodData(toY: siang.toDouble(), width: 35),
                      ],
                    ),
                    BarChartGroupData(
                      x: 2,
                      barRods: [
                        BarChartRodData(toY: sore.toDouble(), width: 35),
                      ],
                    ),
                  ],
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final labels = ['Pagi', 'Siang', 'Sore'];

                          if (value.toInt() >= labels.length) {
                            return const SizedBox();
                          }

                          return Text(labels[value.toInt()]);
                        },
                      ),
                    ),
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statistik(String label, int jumlah) {
    return Column(
      children: [
        Text(
          jumlah.toString(),
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        Text(label),
      ],
    );
  }
}
