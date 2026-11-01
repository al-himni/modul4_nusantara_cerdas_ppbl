import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/pengajuan_model.dart';

class FormulirPage extends StatefulWidget {
  const FormulirPage({super.key});

  @override
  State<FormulirPage> createState() => _FormulirPageState();
}

class _FormulirPageState extends State<FormulirPage> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  bool setujuData = false;
  String? sesiTerpilih;
  bool sedangMengirim = false;

  @override
  void dispose() {
    namaController.dispose();
    emailController.dispose();
    super.dispose();
  }

  bool get formulirLengkap {
    return namaController.text.trim().isNotEmpty &&
        emailController.text.trim().isNotEmpty &&
        setujuData &&
        sesiTerpilih != null;
  }

  Future<void> kirimPengajuan() async {
    if (!formulirLengkap) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lengkapi formulir terlebih dahulu.')),
      );
      return;
    }

    setState(() {
      sedangMengirim = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    context.read<PengajuanModel>().tambahPengajuan(
      Pengajuan(
        nama: namaController.text.trim(),
        email: emailController.text.trim(),
        sesi: sesiTerpilih!,
      ),
    );

    setState(() {
      sedangMengirim = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Pengajuan berhasil dikirim.')),
    );

    resetForm();
  }

  void resetForm() {
    setState(() {
      namaController.clear();
      emailController.clear();
      setujuData = false;
      sesiTerpilih = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rincian Layanan'), centerTitle: true),

      floatingActionButton: FloatingActionButton(
        onPressed: resetForm,
        tooltip: 'Form Baru',
        child: const Icon(Icons.add),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Rincian layanan dipilih.')),
                    );
                  },
                  onLongPress: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Kartu layanan ditekan lama.'),
                      ),
                    );
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 28,
                            child: Icon(Icons.assignment),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Pengajuan Layanan Warga',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(height: 6),
                                const Text(
                                  'Isi data diri untuk mengajukan layanan.',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                Text(
                  'Nama Lengkap',
                  style: Theme.of(context).textTheme.titleMedium,
                ),

                const SizedBox(height: 8),

                TextField(
                  controller: namaController,
                  onChanged: (_) => setState(() {}),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Masukkan nama lengkap',
                    prefixIcon: Icon(Icons.person),
                  ),
                ),

                const SizedBox(height: 20),

                Text('Email', style: Theme.of(context).textTheme.titleMedium),

                const SizedBox(height: 8),

                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (_) => setState(() {}),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Masukkan email',
                    prefixIcon: Icon(Icons.email),
                  ),
                ),

                const SizedBox(height: 20),

                CheckboxListTile(
                  value: setujuData,
                  onChanged: (value) {
                    setState(() {
                      setujuData = value ?? false;
                    });
                  },
                  title: const Text('Saya menyetujui penggunaan data pribadi.'),
                  controlAffinity: ListTileControlAffinity.leading,
                ),

                const SizedBox(height: 12),

                Text(
                  'Sesi Kunjungan',
                  style: Theme.of(context).textTheme.titleMedium,
                ),

                const SizedBox(height: 8),

                RadioGroup<String>(
                  groupValue: sesiTerpilih,
                  onChanged: (value) {
                    setState(() {
                      sesiTerpilih = value;
                    });
                  },
                  child: Column(
                    children: [
                      RadioListTile<String>(
                        value: 'Pagi',
                        title: const Text('Sesi Pagi'),
                      ),
                      RadioListTile<String>(
                        value: 'Siang',
                        title: const Text('Sesi Siang'),
                      ),
                      RadioListTile<String>(
                        value: 'Sore',
                        title: const Text('Sesi Sore'),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: sedangMengirim ? null : kirimPengajuan,
                    icon: sedangMengirim
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.send),
                    label: Text(
                      sedangMengirim ? 'Mengirim...' : 'Kirim Pengajuan',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
