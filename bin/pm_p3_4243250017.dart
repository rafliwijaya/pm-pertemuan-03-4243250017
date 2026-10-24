import 'dart:io';

// t2
typedef Tugas = ({int id, String judul, bool selesai, String prioritas});

extension Kapital on String {
  String get kapital =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';
}

final List<Tugas> daftar = [];
int _idBerikut = 1;

// ptrioritas tantagan ke2
const Map<String, int> _bobotPrioritas = {
  'Tinggi': 3,
  'Sedang': 2,
  'Rendah': 1,
};

void main() {
  print('=== TODO CLI ===');
  var jalan = true;
  while (jalan) {
    tampilkanMenu();
    final pilihan = baca('Pilih menu');
    try {
      switch (pilihan) {
        case '1':
          // tantangan ke2
          tambah(baca('Judul tugas'), bacaPrioritas('Prioritas (Tinggi/Sedang/Rendah)'));
        case '2':
          // tantangan ke3
          final r = ringkasan();
          print('Ringkasan: ${r.selesai}/${r.total} tugas selesai (${r.persen.toStringAsFixed(1)}%)');
          tampilkan(daftar);
        case '3':
          tandaiSelesai(bacaAngka('ID tugas'));
        case '4':
          hapus(bacaAngka('ID tugas'));
        case '5':
          tampilkan(cari(baca('Kata kunci')), judul: 'Hasil pencarian');
        case '6':
          tampilkan(daftar.where((t) => !t.selesai).toList(),
              judul: 'Belum selesai');
        case '7':
          ubahJudul(bacaAngka('ID tugas'), baca('Judul baru'));
        case '0':
          jalan = false;
        default:
          print('Menu tidak dikenal.');
      }
    } on FormatException catch (e) {
      print('Peringatan: ${e.message}');
    }
  }
  print('Sampai jumpa!');
}

void tampilkanMenu() {
  print('''
[1] Tambah [2] Lihat semua [3] Tandai selesai
[4] Hapus [5] Cari [6] Belum selesai [7] Ubah judul [0] Keluar''');
}

String baca(String label) {
  stdout.write('$label: ');
  return (stdin.readLineSync() ?? '').trim();
}

int bacaAngka(String label) {
  final teks = baca(label);
  final angka = int.tryParse(teks);
  if (angka == null) throw FormatException('"$teks" bukan angka.');
  return angka;
}

// Ftantangan ke2
String bacaPrioritas(String label) {
  final input = baca(label).kapital;
  if (!_bobotPrioritas.containsKey(input)) {
    throw FormatException('Prioritas harus berupa Tinggi, Sedang, atau Rendah.');
  }
  return input;
}

void tambah(String judul, [String prioritas = 'Sedang']) {
  if (judul.isEmpty) throw FormatException('Judul tidak boleh kosong.');
  daftar.add((
    id: _idBerikut++,
    judul: judul.kapital,
    selesai: false,
    prioritas: prioritas,
  ));
  print('Tugas ditambahkan.');
}

// tantangan ke3
({int total, int selesai, double persen}) ringkasan() {
  final total = daftar.length;
  final selesai = daftar.where((t) => t.selesai).length;
  final persen = total == 0 ? 0.0 : (selesai / total) * 100;
  return (total: total, selesai: selesai, persen: persen);
}

void tampilkan(List<Tugas> data, {String judul = 'Daftar tugas'}) {
  print('--- $judul (${data.length}) ---');
  if (data.isEmpty) {
    print('(kosong)');
    return;
  }
  // tantangan ke2
  final dataUrut = List<Tugas>.from(data);
  dataUrut.sort((a, b) =>
      (_bobotPrioritas[b.prioritas] ?? 0).compareTo(_bobotPrioritas[a.prioritas] ?? 0));

  for (final t in dataUrut) {
    final tanda = t.selesai ? '[x]' : '[ ]';
    print('${t.id.toString().padLeft(3)} $tanda [${t.prioritas}] ${t.judul}');
  }
}

int _indeksDari(int id) {
  final i = daftar.indexWhere((t) => t.id == id);
  if (i == -1) throw FormatException('Tugas dengan ID $id tidak ditemukan.');
  return i;
}

void tandaiSelesai(int id) {
  final i = _indeksDari(id);
  final t = daftar[i];
  daftar[i] = (id: t.id, judul: t.judul, selesai: true, prioritas: t.prioritas);
  print('"${t.judul}" ditandai selesai.');
}

// tantangan ke 1
void ubahJudul(int id, String judulBaru) {
  if (judulBaru.isEmpty) throw FormatException('Judul tidak boleh kosong.');
  final i = _indeksDari(id);
  final t = daftar[i];
  daftar[i] = (id: t.id, judul: judulBaru.kapital, selesai: t.selesai, prioritas: t.prioritas);
  print('Judul tugas ID $id diubah menjadi "${judulBaru.kapital}".');
}

void hapus(int id) {
  final t = daftar.removeAt(_indeksDari(id));
  print('"${t.judul}" dihapus.');
}

List<Tugas> cari(String kata) {
  final kunci = kata.toLowerCase();
  return daftar.where((t) => t.judul.toLowerCase().contains(kunci)).toList();
}