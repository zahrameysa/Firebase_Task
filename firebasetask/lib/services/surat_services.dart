import 'package:cloud_firestore/cloud_firestore.dart';

class SuratService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addSurat(String jenisSurat, Map<String, dynamic> data) async {
    await _firestore.collection('pengajuan_surat').add({
      'jenisSurat': jenisSurat,
      'data': data,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
