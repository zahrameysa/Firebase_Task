import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StatusSuratScreen extends StatelessWidget {
  const StatusSuratScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CollectionReference suratRef = FirebaseFirestore.instance.collection(
      'pengajuan_surat',
    );

    return Scaffold(
      appBar: AppBar(title: Text('Status Pengajuan Surat')),
      body: StreamBuilder<QuerySnapshot>(
        stream: suratRef.snapshots(),
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

              return Card(
                elevation: 2,
                margin: EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  title: Text(surat['jenisSurat'] ?? ''),
                  subtitle: Text('Tanggal: ${surat['tanggal']}'),
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
                                    dataSurat: surat,
                                  ),
                            ),
                          );
                        },
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

// Dummy halaman edit
class EditSuratScreen extends StatelessWidget {
  final String docId;
  final Map<String, dynamic> dataSurat;

  const EditSuratScreen({
    super.key,
    required this.docId,
    required this.dataSurat,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Surat')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text('Edit surat: ${dataSurat['jenis']} (ID: $docId)'),
      ),
    );
  }
}
