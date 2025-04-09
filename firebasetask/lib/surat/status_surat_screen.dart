import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Untuk format tanggal
import 'edit_surat_screen.dart'; // Pastikan file ini mengarah ke halaman edit sebenarnya

class StatusSuratScreen extends StatelessWidget {
  const StatusSuratScreen({super.key});

  void _hapusSurat(String docId, BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('pengajuan_surat')
          .doc(docId)
          .delete();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Surat berhasil dihapus')));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal menghapus surat')));
    }
  }

  void _konfirmasiHapus(BuildContext context, String docId) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Hapus Surat'),
            content: Text('Yakin ingin menghapus pengajuan surat ini?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context), // Batal
                child: Text('Batal'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Tutup dialog
                  _hapusSurat(docId, context); // Hapus data
                },
                child: Text('Hapus', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final CollectionReference suratRef = FirebaseFirestore.instance.collection(
      'pengajuan_surat',
    );

    return Scaffold(
      appBar: AppBar(title: Text('Status Pengajuan Surat')),
      body: StreamBuilder<QuerySnapshot>(
        stream: suratRef.orderBy('tanggal', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("Belum ada surat yang diajukan."));
          }

          final daftarSurat = snapshot.data!.docs;

          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: daftarSurat.length,
            itemBuilder: (context, index) {
              final surat = daftarSurat[index].data() as Map<String, dynamic>;
              final docId = daftarSurat[index].id;

              // ✅ Perbaikan: konversi Timestamp ke DateTime
              final Timestamp? timestamp = surat['tanggal'];
              final DateTime? tanggal = timestamp?.toDate();

              final String tanggalFormatted =
                  tanggal != null
                      ? DateFormat(
                        'dd MMMM yyyy • HH:mm',
                        'id_ID',
                      ).format(tanggal)
                      : 'Tanggal tidak tersedia';

              return Card(
                elevation: 2,
                margin: EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  title: Text(
                    surat['nama'] ?? 'Tanpa Nama',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Jenis Surat: ${surat['jenisSurat'] ?? '-'}"),
                      Text("Tanggal: $tanggalFormatted"),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        surat['status'] ?? '',
                        style: TextStyle(
                          color:
                              (surat['status'] == 'Selesai')
                                  ? Colors.green
                                  : Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8),
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => EditSuratScreen(
                                    docId: docId,
                                    suratData: surat,
                                  ),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _konfirmasiHapus(context, docId),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
