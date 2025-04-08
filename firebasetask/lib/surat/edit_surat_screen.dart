import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditSuratScreen extends StatefulWidget {
  final Map<String, dynamic> suratData;
  final String docId;

  const EditSuratScreen({
    super.key,
    required this.suratData,
    required this.docId,
  });

  @override
  State<EditSuratScreen> createState() => _EditSuratScreenState();
}

class _EditSuratScreenState extends State<EditSuratScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController namaController;
  late TextEditingController jenisSuratController;
  late TextEditingController keperluanController;

  @override
  void initState() {
    super.initState();
    namaController = TextEditingController(text: widget.suratData['nama']);
    jenisSuratController = TextEditingController(
      text: widget.suratData['jenisSurat'],
    );
    keperluanController = TextEditingController(
      text: widget.suratData['keperluan'],
    );
  }

  @override
  void dispose() {
    namaController.dispose();
    jenisSuratController.dispose();
    keperluanController.dispose();
    super.dispose();
  }

  void _updateSurat() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance
            .collection('pengajuan_surat')
            .doc(widget.docId)
            .update({
              'nama': namaController.text,
              'jenisSurat': jenisSuratController.text,
              'keperluan': keperluanController.text,
              'updatedAt': DateTime.now(),
            });

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Surat berhasil diperbarui")));
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Gagal memperbarui surat: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Pengajuan Surat")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: namaController,
                decoration: InputDecoration(labelText: "Nama"),
                validator:
                    (value) =>
                        value!.isEmpty ? 'Nama tidak boleh kosong' : null,
              ),
              TextFormField(
                controller: jenisSuratController,
                decoration: InputDecoration(labelText: "Jenis Surat"),
                validator:
                    (value) =>
                        value!.isEmpty
                            ? 'Jenis surat tidak boleh kosong'
                            : null,
              ),
              TextFormField(
                controller: keperluanController,
                decoration: InputDecoration(labelText: "Keperluan"),
                validator:
                    (value) =>
                        value!.isEmpty ? 'Keperluan tidak boleh kosong' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateSurat,
                child: Text("Simpan Perubahan"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
