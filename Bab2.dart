import 'dart:core';

// Enum untuk FaseProyek
enum FaseProyek { Perencanaan, Pengembangan, Evaluasi }

// Mixin untuk Kinerja
mixin Kinerja {
  int produktivitas = 0;

  // Fungsi untuk memperbarui produktivitas setiap 30 hari
  void perbaruiProduktivitas(int nilai) {
    if (nilai >= 0 && nilai <= 100) {
      produktivitas = nilai;
    }
  }
}

class ProdukDigital {
  String namaProduk;
  double harga;
  String kategori;

  ProdukDigital({
    required this.namaProduk,
    required this.harga,
    required this.kategori,
  });

  void terapkanDiskon() {
    if (kategori == 'NetworkAutomation' && harga > 200000) {
      harga *= 0.85;
      if (harga < 200000) {
        harga = 200000;
      }
    }
  }
}

abstract class Karyawan {
  String nama;
  int umur;
  String peran;

  Karyawan({
    required this.nama,
    required this.umur,
    required this.peran,
  });

  void bekerja();
}

class KaryawanTetap extends Karyawan {
  KaryawanTetap({
    required String nama,
    required int umur,
    required String peran,
  }) : super(nama: nama, umur: umur, peran: peran);

  @override
  void bekerja() {
    print('$nama yang berusia $umur tahun sedang bekerja sebagai $peran.');
  }
}

class KaryawanKontrak extends Karyawan {
  KaryawanKontrak({
    required String nama,
    required int umur,
    required String peran,
  }) : super(nama: nama, umur: umur, peran: peran);

  @override
  void bekerja() {
    print('$nama yang berusia $umur tahun sedang bekerja sebagai $peran untuk proyek tertentu.');
  }
}

class KaryawanDenganKinerja extends Karyawan with Kinerja {
  KaryawanDenganKinerja({
    required String nama,
    required int umur,
    required String peran,
  }) : super(nama: nama, umur: umur, peran: peran);

  @override
  void bekerja() {
    print('$nama yang berusia $umur tahun sedang bekerja sebagai $peran dengan produktivitas $produktivitas.');
  }
}

class Perusahaan {
  List<Karyawan> karyawanAktif = [];
  List<Karyawan> karyawanNonAktif = [];
  final int maxKaryawanAktif = 20;

  void tambahKaryawan(Karyawan karyawan) {
    if (karyawanAktif.length < maxKaryawanAktif) {
      karyawanAktif.add(karyawan);
      print('${karyawan.nama} ditambahkan ke karyawan aktif.');
    } else {
      print('Jumlah karyawan aktif telah mencapai batas maksimum.');
    }
  }

  void resignKaryawan(Karyawan karyawan) {
    karyawanAktif.remove(karyawan);
    karyawanNonAktif.add(karyawan);
    print('${karyawan.nama} resign dan dipindahkan ke karyawan non-aktif.');
  }
}

// Enum FaseProyek untuk Transisi Proyek
class FaseProyekHandler {
  FaseProyek faseSaatIni;

  FaseProyekHandler(this.faseSaatIni);

  // Fungsi untuk mengecek apakah fase bisa beralih
  bool bisaBeralihKeFaseBerikutnya(
      int jumlahKaryawanAktif, int durasiProyek) {
    if (faseSaatIni == FaseProyek.Perencanaan) {
      return jumlahKaryawanAktif >= 5;
    } else if (faseSaatIni == FaseProyek.Pengembangan) {
      return durasiProyek > 45;
    }
    return false;
  }

  void beralihFase() {
    if (faseSaatIni == FaseProyek.Perencanaan) {
      faseSaatIni = FaseProyek.Pengembangan;
      print('Proyek beralih ke fase Pengembangan.');
    } else if (faseSaatIni == FaseProyek.Pengembangan) {
      faseSaatIni = FaseProyek.Evaluasi;
      print('Proyek beralih ke fase Evaluasi.');
    } else {
      print('Proyek sudah di fase Evaluasi.');
    }
  }
}

// Implementasi penggunaan positional dan named arguments
void buatKaryawan({
  required String nama,
  required int umur,
  required String peran,
}) {
  print('Karyawan: $nama, Umur: $umur, Peran: $peran');
}

void main() {
  ProdukDigital produk1 = ProdukDigital(
    namaProduk: 'Sistem Otomasi Jaringan',
    harga: 250000,
    kategori: 'NetworkAutomation',
  );
  produk1.terapkanDiskon();
  print('Harga setelah diskon: ${produk1.harga}');

  // penggunaan karyawan dan mixin kinerja
  KaryawanDenganKinerja karyawan1 = KaryawanDenganKinerja(
    nama: 'Budi',
    umur: 30,
    peran: 'Developer',
  );
  karyawan1.perbaruiProduktivitas(90);
  karyawan1.bekerja();

  // penggunaan perusahaan dan batasan jumlah karyawan aktif
  Perusahaan perusahaan = Perusahaan();
  perusahaan.tambahKaryawan(KaryawanTetap(
    nama: 'Andi',
    umur: 28,
    peran: 'Network Engineer',
  ));
  perusahaan.tambahKaryawan(KaryawanKontrak(
    nama: 'Citra',
    umur: 32,
    peran: 'Manager',
  ));

  FaseProyekHandler proyek = FaseProyekHandler(FaseProyek.Perencanaan);
  proyek.bisaBeralihKeFaseBerikutnya(6, 50);
  proyek.beralihFase();
}
