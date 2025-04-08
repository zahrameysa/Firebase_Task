import 'package:firebasetask/surat/pengajuan_surat.dart';
import 'package:firebasetask/surat/status_surat_screen.dart'; // ✅ Tambahkan import ini
import 'package:flutter/material.dart';

class FeatureMenu extends StatefulWidget {
  const FeatureMenu({super.key});

  @override
  _FeatureMenuState createState() => _FeatureMenuState();
}

class _FeatureMenuState extends State<FeatureMenu> {
  final List<String> featureNames = [
    "Pembayaran Iuran",
    "Tagihan Iuran",
    "History Pembayaran",
    "Pengajuan Surat",
    "Kegiatan RT",
    "Hasil Rapat RT",
    "Berita RT",
    "Status Surat",
    "Layanan Pengaduan",
  ];

  final List<String> featureImages = [
    "assets/icons/payment.png",
    "assets/icons/bill.png",
    "assets/icons/history.png",
    "assets/icons/document.png",
    "assets/icons/event.png",
    "assets/icons/meeting.png",
    "assets/icons/news.png",
    "assets/icons/progress.png",
    "assets/icons/complaint.png",
  ];

  List<String> filteredFeatures = [];
  List<String> filteredImages = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredFeatures = List.from(featureNames);
    filteredImages = List.from(featureImages);
  }

  void _searchFeature(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredFeatures = List.from(featureNames);
        filteredImages = List.from(featureImages);
      } else {
        List<int> matchingIndexes = [];
        for (int i = 0; i < featureNames.length; i++) {
          if (featureNames[i].toLowerCase().contains(query.toLowerCase())) {
            matchingIndexes.add(i);
          }
        }
        filteredFeatures = matchingIndexes.map((i) => featureNames[i]).toList();
        filteredImages = matchingIndexes.map((i) => featureImages[i]).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Container(
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
            child: TextField(
              controller: searchController,
              onChanged: _searchFeature,
              decoration: InputDecoration(
                hintText: "Cari fitur...",
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 16,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: 150,
          margin: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(child: Text("Carousel Placeholder")),
        ),
        SizedBox(height: 10),
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 10,
            ),
            itemCount: filteredFeatures.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  if (filteredFeatures[index] == "Pengajuan Surat") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PengajuanSuratScreen(),
                      ),
                    );
                  } else if (filteredFeatures[index] == "Status Surat") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => StatusSuratScreen(), // ✅ Navigasi baru
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                DetailScreen(name: filteredFeatures[index]),
                      ),
                    );
                  }
                },
                child: Container(
                  constraints: BoxConstraints(minHeight: 120),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0xffF2F9FF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(filteredImages[index], width: 42, height: 42),
                      SizedBox(height: 4),
                      Text(
                        filteredFeatures[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class DetailScreen extends StatelessWidget {
  final String name;
  const DetailScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Center(child: Text("Ini halaman detail dari $name")),
    );
  }
}
