import 'package:cloud_firestore/cloud_firestore.dart';

class SuratService {
  final CollectionReference _suratRef = FirebaseFirestore.instance.collection(
    'pengajuan_surat',
  );

  Future<void> addSurat(String jenisSurat, Map<String, dynamic> data) async {
    try {
      await _suratRef.add({
        ...data,
        'jenis': jenisSurat,
        'status': 'Menunggu Persetujuan',
        'tanggal':
            DateTime.now()
                .toIso8601String(), // atau format lain sesuai kebutuhan
      });
      print("✅ Data berhasil disimpan ke Firestore");
    } catch (e) {
      print("❌ Gagal menyimpan data ke Firestore: $e");
    }
  }
}
