import 'package:flutter/material.dart';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const ZodiakCeriaApp());
}

class ZodiakCeriaApp extends StatelessWidget {
  const ZodiakCeriaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ZodiakCeriaPage(),
    );
  }
}

class ZodiakCeriaPage extends StatefulWidget {
  const ZodiakCeriaPage({super.key});

  @override
  State<ZodiakCeriaPage> createState() => _ZodiakCeriaPageState();
}

class _ZodiakCeriaPageState extends State<ZodiakCeriaPage>
    with SingleTickerProviderStateMixin {
  final random = Random();
  final player = AudioPlayer();

  bool showDice = false;
  double diceRotation = 0;

  String? zodiakDipilih;
  Map<String, dynamic>? hasilRamalan;

  // =================== GAMBAR ZODIAK ===================
  final Map<String, String> gambarZodiak = {
    "Aries": "assets/images/ariess.jpg",
    "Taurus": "assets/images/tauruss.jpg",
    "Gemini": "assets/images/geminii.jpg",
    "Cancer": "assets/images/cancerr.jpg",
    "Leo": "assets/images/leoo.jpg",
    "Virgo": "assets/images/virgoo.jpg",
    "Libra": "assets/images/libraa.jpg",
    "Scorpio": "assets/images/scorpioo.jpg",
    "Sagitarius": "assets/images/sagitariuss.jpg",
    "Capricorn": "assets/images/capricornn.jpg",
    "Aquarius": "assets/images/aquariuss.jpg",
    "Pisces": "assets/images/piscess.jpg",
  };

  // ===================== LIST RAMALAN =====================
  final List<String> cintaList = [
    "Hubunganmu makin hangat hari ini 💖",
    "Seseorang diam-diam memperhatikanmu 👀",
    "Percintaanmu penuh kejutan kecil hari ini 💌",
  ];

  final List<String> uangList = [
    "Keuanganmu stabil, tapi jangan boros 💰",
    "Ada peluang kecil untuk dapat rezeki 🎁",
    "Waktunya nabung buat hal penting 💸",
  ];

  final List<String> moodList = [
    "Mood kamu cerah banget ☀️",
    "Santai aja, semua akan baik-baik aja 🌈",
    "Sedikit lelah, tapi tetap semangat 💪",
  ];

  // ===================== DESKRIPSI ZODIAK =====================
  final Map<String, String> deskripsiZodiak = {
    "Aries": "Berani, spontan, dan penuh semangat.",
    "Taurus": "Sabar, penyayang, dan suka kenyamanan.",
    "Gemini": "Cerdas, komunikatif, dan mudah bergaul.",
    "Cancer": "Sensitif, setia, dan penuh kasih sayang.",
    "Leo": "Percaya diri, karismatik, dan suka jadi pusat perhatian.",
    "Virgo": "Analitis, perfeksionis, dan pekerja keras.",
    "Libra": "Ramah, adil, dan menyukai keharmonisan.",
    "Scorpio": "Misterius, kuat, dan sangat setia.",
    "Sagitarius": "Optimis, bebas, dan suka petualangan.",
    "Capricorn": "Disiplin, ambisius, dan praktis.",
    "Aquarius": "Inovatif, unik, dan idealis.",
    "Pisces": "Lembut, imajinatif, dan penuh empati.",
  };

  // ===================== CARI ZODIAK =====================
  String cariZodiak(DateTime tgl) {
    int d = tgl.day;
    int b = tgl.month;

    if ((b == 12 && d >= 22) || (b == 1 && d <= 19)) return "Capricorn";
    if ((b == 1 && d >= 20) || (b == 2 && d <= 18)) return "Aquarius";
    if ((b == 2 && d >= 19) || (b == 3 && d <= 20)) return "Pisces";
    if ((b == 3 && d >= 21) || (b == 4 && d <= 19)) return "Aries";
    if ((b == 4 && d >= 20) || (b == 5 && d <= 20)) return "Taurus";
    if ((b == 5 && d >= 21) || (b == 6 && d <= 20)) return "Gemini";
    if ((b == 6 && d >= 21) || (b == 7 && d <= 22)) return "Cancer";
    if ((b == 7 && d >= 23) || (b == 8 && d <= 22)) return "Leo";
    if ((b == 8 && d >= 23) || (b == 9 && d <= 22)) return "Virgo";
    if ((b == 9 && d >= 23) || (b == 10 && d <= 22)) return "Libra";
    if ((b == 10 && d >= 23) || (b == 11 && d <= 21)) return "Scorpio";
    if ((b == 11 && d >= 22) || (b == 12 && d <= 21)) return "Sagitarius";

    return "Tidak diketahui";
  }

  // ================================================================
  //                          FITUR TAMBAHAN
  // ================================================================

  void tampilkanKecocokan(BuildContext context, String zodiak) {
    final daftarZodiak = gambarZodiak.keys.toList();

    String? pasanganDipilih;
    int compatibility = random.nextInt(41) + 60;

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text("💞 Kecocokan Zodiak"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Pilih zodiak pasanganmu:"),
                DropdownButton<String>(
                  value: pasanganDipilih,
                  hint: const Text("Pilih Zodiak"),
                  items: daftarZodiak.map((z) {
                    return DropdownMenuItem(value: z, child: Text(z));
                  }).toList(),
                  onChanged: (val) {
                    player.play(AssetSource('sounds/heart.mp3'));
                    setState(() {
                      pasanganDipilih = val;
                      compatibility = random.nextInt(41) + 60;
                    });
                  },
                ),
                if (pasanganDipilih != null) ...[
                  const SizedBox(height: 10),
                  Text(
                    "$zodiak ❤️ $pasanganDipilih",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: compatibility / 100,
                    color: Colors.pinkAccent,
                    backgroundColor: Colors.pink[100],
                    minHeight: 10,
                  ),
                  const SizedBox(height: 6),
                  Text("Tingkat kecocokan: $compatibility%"),
                ],
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Tutup"),
              ),
            ],
          );
        },
      ),
    );
  }

  void tampilkanRamalanMingguan(BuildContext context, String zodiak) {
    final ramalan = [
      "Awal minggu penuh semangat 💪",
      "Pertengahan minggu ada kejutan kecil 🎁",
      "Akhir minggu waktunya istirahat 😴",
    ];

    player.play(AssetSource('sounds/magic.mp3'));

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("📅 Ramalan Mingguan $zodiak"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(ramalan.length, (i) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  const Text("• ",
                      style: TextStyle(color: Colors.purple)),
                  Expanded(child: Text(ramalan[i])),
                ],
              ),
            );
          }),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Tutup"),
          ),
        ],
      ),
    );
  }

  void tampilkanDeskripsiZodiak(BuildContext context, String zodiak) {
    player.play(AssetSource('sounds/info.mp3'));

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("🪐 Tentang $zodiak"),
        content: Text(deskripsiZodiak[zodiak] ?? "Deskripsi tidak tersedia."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Tutup"),
          ),
        ],
      ),
    );
  }

  // ================================================================
  //                       RAMALAN UTAMA
  // ================================================================

  void tampilkanRamalan(BuildContext context, String zodiak) {
    hasilRamalan = {
      "cinta": cintaList[random.nextInt(cintaList.length)],
      "uang": uangList[random.nextInt(uangList.length)],
      "mood": moodList[random.nextInt(moodList.length)],
    };

    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.4),
      builder: (context) {
        return StatefulBuilder(builder: (context, setStateDialog) {
          return Dialog(
            backgroundColor: Colors.white.withOpacity(0.95),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedRotation(
                    turns: diceRotation,
                    duration: const Duration(milliseconds: 800),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        gambarZodiak[zodiak]!,
                        width: 130,
                        height: 130,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  Text(
                    zodiak,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),

                  const SizedBox(height: 10),

                  if (!showDice) ...[
                    Text("💖 ${hasilRamalan!["cinta"]}",
                        textAlign: TextAlign.center),
                    Text("💰 ${hasilRamalan!["uang"]}",
                        textAlign: TextAlign.center),
                    Text("😄 ${hasilRamalan!["mood"]}",
                        textAlign: TextAlign.center),
                  ] else ...[
                    const SizedBox(height: 30),
                    const CircularProgressIndicator(
                        color: Colors.purpleAccent),
                    const SizedBox(height: 10),
                    const Text("Mengocok ramalan 🎲...",
                        style: TextStyle(color: Colors.purple)),
                  ],

                  const SizedBox(height: 20),

                  GestureDetector(
                    onTap: () async {
                      player.play(AssetSource('sounds/dice.mp3'));

                      setStateDialog(() {
                        showDice = true;
                        diceRotation += 2;
                      });

                      await Future.delayed(const Duration(seconds: 2));

                      setStateDialog(() {
                        showDice = false;
                        hasilRamalan = {
                          "cinta": cintaList[random.nextInt(cintaList.length)],
                          "uang": uangList[random.nextInt(uangList.length)],
                          "mood": moodList[random.nextInt(moodList.length)],
                        };
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 12),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFfbc2eb), Color(0xFFa6c1ee)],
                        ),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(2, 3),
                          ),
                        ],
                      ),
                      child: const Text(
                        "Ramal Lagi 🎲",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.favorite,
                            color: Colors.pinkAccent),
                        tooltip: "Cocok dengan siapa?",
                        onPressed: () =>
                            tampilkanKecocokan(context, zodiak),
                      ),
                      IconButton(
                        icon: const Icon(Icons.calendar_month,
                            color: Colors.blueAccent),
                        tooltip: "Ramalan Mingguan",
                        onPressed: () =>
                            tampilkanRamalanMingguan(context, zodiak),
                      ),
                      IconButton(
                        icon: const Icon(Icons.info_outline,
                            color: Colors.deepPurple),
                        tooltip: "Tentang Zodiak",
                        onPressed: () =>
                            tampilkanDeskripsiZodiak(context, zodiak),
                      ),
                    ],
                  ),

                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Tutup"),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  // ================================================================
  //                          UI UTAMA
  // ================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFfbc2eb),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFfbc2eb), Color(0xFFa6c1ee)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),

              const Text(
                "🌈 Zodiak Ceria ✨",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black26,
                      offset: Offset(1, 2),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Klik zodiakmu atau cari sesuai tanggal lahir 💫",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white70,
                ),
              ),

              const SizedBox(height: 12),

              ElevatedButton.icon(
                onPressed: () async {
                  final tgl = await showDatePicker(
                    context: context,
                    initialDate: DateTime(2000),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );

                  if (tgl != null) {
                    String z = cariZodiak(tgl);

                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text(
                          "✨ Zodiakmu ✨",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.purple),
                        ),
                        content: Text(
                          "Kamu adalah $z ♈",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        actionsAlignment: MainAxisAlignment.center,
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Oke"),
                          )
                        ],
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.search),
                label: const Text("Cari Zodiakku"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.purpleAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              Expanded(
                child: GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  padding: const EdgeInsets.all(16),
                  children: gambarZodiak.entries.map((entry) {
                    return ZodiakCard(
                      namaZodiak: entry.key,
                      imagePath: entry.value,
                      onTap: () => tampilkanRamalan(context, entry.key),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ================================================================
//                        KARTU ZODIAK
// ================================================================

class ZodiakCard extends StatefulWidget {
  final String namaZodiak;
  final String imagePath;
  final VoidCallback onTap;

  const ZodiakCard({
    super.key,
    required this.namaZodiak,
    required this.imagePath,
    required this.onTap,
  });

  @override
  State<ZodiakCard> createState() => _ZodiakCardState();
}

class _ZodiakCardState extends State<ZodiakCard> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.95),
      onTapUp: (_) {
        setState(() => _scale = 1.0);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _scale = 1.0),
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 150),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: AssetImage(widget.imagePath),
              fit: BoxFit.cover,
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(2, 4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
