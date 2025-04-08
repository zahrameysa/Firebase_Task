import 'package:firebasetask/surat/form_pengajuan_surat.dart';
import 'package:flutter/material.dart';

class PengajuanSuratScreen extends StatefulWidget {
  @override
  _PengajuanSuratScreenState createState() => _PengajuanSuratScreenState();
}

class _PengajuanSuratScreenState extends State<PengajuanSuratScreen> {
  final List<String> jenisSuratList = [
    "Surat Keterangan Domisili",
    "Surat Keterangan Tidak Mampu",
    "Surat Pengantar RT/RW",
    "Surat Izin Keramaian",
    "Surat Keterangan Usaha",
    "Surat Keterangan Kematian",
  ];

  final List<String> suratIcons = [
    "assets/icons/domisili.png",
    "assets/icons/tidak_mampu.png",
    "assets/icons/pengantar.png",
    "assets/icons/keramaian.png",
    "assets/icons/market.png",
    "assets/icons/kematian.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pilih Jenis Surat")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: jenisSuratList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => FormPengajuanSuratScreen(
                          jenisSurat: jenisSuratList[index],
                        ),
                  ),
                );
              },
              child: Container(
                height:
                    120, // Memberi lebih banyak ruang agar teks tidak overflow
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(suratIcons[index], width: 50, height: 50),
                    SizedBox(height: 8),
                    Text(
                      jenisSuratList[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10, // Font lebih kecil agar muat
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines:
                          2, // Maksimal 2 baris agar tidak keluar dari kotak
                      overflow:
                          TextOverflow
                              .ellipsis, // Tambahkan "..." jika teks terlalu panjang
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
