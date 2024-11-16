import 'dart:async';

enum Peran { Admin, Pelanggan }

class Produk {
  String namaProduk;
  double harga;
  bool tersedia;
  Produk({required this.namaProduk, required this.harga, required this.tersedia});
}

class Pengguna {
  String nama;
  int umur;
  late List<Produk> daftarProduk;
  Peran? peran;
  Pengguna({required this.nama, required this.umur, this.peran}) {
    daftarProduk = []; 
  }
}

class AdminPengguna extends Pengguna {
  AdminPengguna({required String nama, required int umur}) : super(nama: nama, umur: umur) {
    peran = Peran.Admin;
  }

  void tambahProduk(Produk produk) {
    if (!produk.tersedia) {
      throw Exception('Produk "${produk.namaProduk}" tidak tersedia dalam stok.');
    }
    if (!daftarProduk.contains(produk)) {
      daftarProduk.add(produk);
    }
  }

  void hapusProduk(Produk produk) {
    daftarProduk.remove(produk);
  }
}

class PelangganPengguna extends Pengguna {
  PelangganPengguna({required String nama, required int umur}) : super(nama: nama, umur: umur) {
    peran = Peran.Pelanggan;
  }

  void lihatProduk() {
    print("Daftar produk untuk ${nama}:");
    for (var produk in daftarProduk) {
      print("- ${produk.namaProduk} (Rp${produk.harga}) - ${produk.tersedia ? 'Tersedia' : 'Tidak Tersedia'}");
    }
  }
}

Future<void> ambilDetailProduk(Produk produk) async {
  await Future.delayed(Duration(seconds: 2)); 
  print("Detail produk ${produk.namaProduk}: Harga Rp${produk.harga}, Stok: ${produk.tersedia ? 'Tersedia' : 'Tidak Tersedia'}");
}

void main() {
  var produk1 = Produk(namaProduk: 'Laptop', harga: 15000000, tersedia: true);
  var produk2 = Produk(namaProduk: 'Mouse', harga: 200000, tersedia: true);
  var produk3 = Produk(namaProduk: 'Keyboard', harga: 500000, tersedia: false);

  var admin = AdminPengguna(nama: 'fit', umur: 20);
  var pelanggan = PelangganPengguna(nama: 'jay', umur: 22);

  try {
    admin.tambahProduk(produk1);
    admin.tambahProduk(produk2);
    admin.tambahProduk(produk3); 
  } catch (e) {
    print("Error: ${e.toString()}");
  }

  pelanggan.lihatProduk();

  Map<String, Produk> katalogProduk = {
    produk1.namaProduk: produk1,
    produk2.namaProduk: produk2,
    produk3.namaProduk: produk3,
  };

  Set<Produk> produkUnik = {produk1, produk2, produk3};

  ambilDetailProduk(produk1);
  ambilDetailProduk(produk3);
}
