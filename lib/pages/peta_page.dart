import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PetaPage extends StatefulWidget {
  const PetaPage({super.key});

  @override
  State<PetaPage> createState() => _PetaPageState();
}

class _PetaPageState extends State<PetaPage> {
  static const LatLng lokasiKantor = LatLng(-6.914744, 107.609810);

  final Set<Marker> markers = {
    const Marker(
      markerId: MarkerId('kantor_layanan'),
      position: lokasiKantor,
      infoWindow: InfoWindow(
        title: 'Kantor Layanan Warga',
        snippet: 'Lokasi pelayanan Nusantara Cerdas Mobile',
      ),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lokasi Kantor'), centerTitle: true),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: lokasiKantor,
          zoom: 15,
        ),
        markers: markers,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: true,
      ),
    );
  }
}
