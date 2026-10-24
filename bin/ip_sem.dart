import 'dart:io';

typedef MataKuliah = ({String nama, int sks, String nilai, double bobot});

extension FormatTeks on String {
  String get kapital =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';
}

String baca(String label) {
  stdout.write('$label : ');
  return (stdin.readLineSync() ?? '').trim();
}

/// fungsi validasi sks (spek 4)
/// lempar formatexception kalauu bukan angka bulat antara 1 sampai 6
int validasiSks(String teks) {
  final sks = int.tryParse(teks);
  if (sks == null || sks < 1 || sks > 6) {
    throw FormatException('SKS harus berupa angka 1-6, bukan "$teks".');
  }
  return sks;
}

/// pakai switch konveri nilai huruf ke angka (spek 2 & 3)
double bobot(String huruf) => switch (huruf.trim().toUpperCase()) {
      'A' => 4.0,
      'B' => 3.0,
      'C' => 2.0,
      'D' => 1.0,
      'E' => 0.0,
      _ => throw FormatException(
          'Nilai huruf harus berupa A, B, C, D, atau E, bukan "$huruf".'),
    };

/// spek 2 & 5: hitung indeks prestasi (IP) menggunakan higher-order function fold
double hitungIp(List<MataKuliah> data) {
  if (data.isEmpty) return 0.0;
  final totalSks = data.fold<int>(0, (sum, mk) => sum + mk.sks);
  final totalMutu =
      data.fold<double>(0.0, (sum, mk) => sum + (mk.sks * mk.bobot));
  return totalSks == 0 ? 0.0 : totalMutu / totalSks;
}

/// minimal 4 fungsi terpisah (spek 2)
String predikat(double ip) => switch (ip) {
      >= 3.51 => 'Dengan Pujian',
      >= 3.00 => 'Sangat Memuaskan',
      >= 2.76 => 'Memuaskan',
      >= 2.00 => 'Cukup',
      _ => 'Kurang',
    };

void cetakKhs(List<MataKuliah> data, {bool urutkan = true}) {
  if (data.isEmpty) {
    print('\nBelum ada data mata kuliah yang dimasukkan.');
    return;
  }

  final listTampil = List<MataKuliah>.from(data);

  // khs di urutkan menggunakan sort (spek 6)
  if (urutkan) {
    listTampil.sort((a, b) => b.bobot.compareTo(a.bobot));
  }

  print('\n----------------------------------------');
  print('${'Mata Kuliah'.padRight(26)} ${'SKS'.padLeft(4)}  ${'Nilai'.padLeft(5)}');
  print('----------------------------------------');

  for (final mk in listTampil) {
    print('${mk.nama.padRight(26)} ${mk.sks.toString().padLeft(4)}  ${mk.nilai.padLeft(5)}');
  }

  print('----------------------------------------');

  final totalSks = data.fold<int>(0, (sum, mk) => sum + mk.sks);
  final ip = hitungIp(data);

  print('Total SKS : $totalSks');
  print('IP        : ${ip.toStringAsFixed(2)} (${predikat(ip)})');

  //  daftar mata kuliah dengan bobot < 2 ditampilkan dengan where (spek 5)
  final perluPerbaiki = data.where((mk) => mk.bobot < 2.0).toList();
  if (perluPerbaiki.isNotEmpty) {
    final daftarNama = perluPerbaiki.map((mk) => mk.nama).join(', ');
    print('Perlu diperbaiki: $daftarNama');
  }
}

void main() {
  final List<MataKuliah> daftarMk = [];

  print('Masukkan data mata kuliah. Kosongkan nama untuk selesai.\n');

  // Sperulangan while yg berhenti jika nama kosong (spek 1)
  var selesai = false;
  while (!selesai) {
    final nama = baca('Nama MK');
    if (nama.isEmpty) {
      selesai = true;
      break;
    }

    // exception supaya program ga crash (spek 4)
    try {
      final inputSks = baca('SKS    ');
      final sks = validasiSks(inputSks);

      final inputNilai = baca('Nilai  ');
      final nilaiBobot = bobot(inputNilai);

      daftarMk.add((
        nama: nama.kapital,
        sks: sks,
        nilai: inputNilai.toUpperCase(),
        bobot: nilaiBobot,
      ));
    } on FormatException catch (e) {
      print('Data diabaikan: ${e.message}\n');
    }
  }

  cetakKhs(daftarMk, urutkan: true);
}