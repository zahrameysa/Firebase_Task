import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/form_field_model.dart';

class FormPengajuanSuratScreen extends StatefulWidget {
  final String jenisSurat;
  FormPengajuanSuratScreen({required this.jenisSurat});

  @override
  _FormPengajuanSuratScreenState createState() =>
      _FormPengajuanSuratScreenState();
}

class _FormPengajuanSuratScreenState extends State<FormPengajuanSuratScreen> {
  final _formKey = GlobalKey<FormState>();
  Map<String, TextEditingController> controllers = {};

  // Definisi Form Fields berdasarkan jenis surat
  final Map<String, List<FormFieldModel>> formFields = {
    "Surat Keterangan Domisili": [
      FormFieldModel(key: "nama", label: "Nama Lengkap", isRequired: true),
      FormFieldModel(key: "alamat", label: "Alamat", isRequired: true),
      FormFieldModel(key: "keterangan", label: "Keterangan Tambahan"),
    ],
    "Surat Keterangan Tidak Mampu": [
      FormFieldModel(key: "nama", label: "Nama Lengkap", isRequired: true),
      FormFieldModel(key: "pekerjaan", label: "Pekerjaan"),
      FormFieldModel(
        key: "penghasilan",
        label: "Penghasilan per Bulan",
        isRequired: true,
      ),
    ],
    // Tambahkan jenis surat lainnya jika diperlukan
  };

  @override
  void initState() {
    super.initState();
    if (formFields.containsKey(widget.jenisSurat)) {
      for (var field in formFields[widget.jenisSurat]!) {
        controllers[field.key] = TextEditingController();
      }
    }
  }

  @override
  void dispose() {
    for (var controller in controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _submitPengajuan() async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> data = {};
      for (var field in formFields[widget.jenisSurat]!) {
        data[field.key] = controllers[field.key]!.text;
      }

      data['jenisSurat'] = widget.jenisSurat;
      data['status'] = 'Diproses';
      data['tanggal'] = DateTime.now().toIso8601String();

      try {
        await FirebaseFirestore.instance
            .collection('pengajuan_surat')
            .add(data);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Pengajuan ${widget.jenisSurat} berhasil!")),
        );

        if (mounted) {
          Navigator.pop(context);
        }
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Gagal mengajukan surat: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Form ${widget.jenisSurat}")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              if (formFields.containsKey(widget.jenisSurat)) ...[
                ...formFields[widget.jenisSurat]!.map((field) {
                  return TextFormField(
                    controller: controllers[field.key],
                    decoration: InputDecoration(labelText: field.label),
                    validator: (value) {
                      if (field.isRequired &&
                          (value == null || value.isEmpty)) {
                        return "${field.label} wajib diisi!";
                      }
                      return null;
                    },
                  );
                }).toList(),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitPengajuan,
                  child: Text("Ajukan Surat"),
                ),
              ] else ...[
                Center(child: Text("Jenis surat tidak ditemukan.")),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
