A. IDENTITAS
- Nama: Muhammad Rafli Wijaya
- NIM: 4243250017
- Kelas: PSIK 24D

B. TANGKAPAN LAYAR OUTPUT
- Layar satu sesi
![Screenshot output](./assets/Screenshot%202026-10-24%20171858.png)

-Dart Analyze
![Screenshot dart analyze](./assets/Screenshot%202026-10-24%20171926.png)

C. Pemakaian higher-order function
Penerapan Higher-Order Function ada pada fungsi hitungIp menggunakan .fold() untuk mengakumulasi total SKS dan mutu, serta fngsi cetakKhs menggunakan .sort() dengan fungsi pembanding untuk mengurutkan nilai dari tertinggi dan .where() untuk menyaring mata kuliah berbobot di bawah 2.0. Sedangkan Error Handling diterapkan dengan memisahkan fungsi validasi validasiSks dan bobot yang melempar FormatException, kemudian ditangkap pada fungsi main menggunakan blok try ... on FormatException catch. Dengan begini, kesalahan input pengguna tidak membuat program crash, melainkan data yang salah otomatis diabaikan saja dan program tetap berjalan lancar.


D. Penggunaan AI
Saya menggunakan AI untuk me-generate kode template sesuai output "Contoh keluaran (format boleh berbeda)" pada file modul, kemudian mengetikkan ulang kode yang diberikan AI secara mandiri/manual. Saya juga menggunakan AI untuk membuat beberapa spesifikasi yang belum saya paham seperti poin 2, 4 dan 5. Menggunakan AI untuk memahami higher-order function yang ternyata merupakan fungsi "pintar" yang menerima fungsi lain di dalam kurungnya untuk membantunya mengolah data (misal: menjumlahkan, mengurutkan, atau menyaring).
