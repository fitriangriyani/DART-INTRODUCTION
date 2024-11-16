import 'package:flutter/material.dart';

// Fungsi utama untuk menjalankan aplikasi
void main() {
  runApp(const MyApp());
}

// Kelas utama aplikasi
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cosmetics E-Commerce', // Judul aplikasi
      theme: ThemeData(
        primarySwatch: Colors.pink, // Warna utama tema aplikasi
        fontFamily: 'Arial', // Font default untuk aplikasi
      ),
      home: const CosmeticsHomePage(), // Halaman utama aplikasi
    );
  }
}

class CosmeticsHomePage extends StatelessWidget {
  const CosmeticsHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Bagian atas halaman (AppBar)
      appBar: AppBar(
        title: const Row(
          children: [
            FlutterLogo(size: 24), // Logo Flutter di AppBar
            SizedBox(width: 8),
            Text('Cosmetics E-Commerce'), // Judul AppBar
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}), // Tombol pencarian
          IconButton(icon: const Icon(Icons.shopping_cart), onPressed: () {}), // Tombol keranjang
        ],
      ),
      // Isi utama halaman
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Banner promosi di bagian atas
            Container(
              padding: const EdgeInsets.all(50),
              color: Colors.pink.shade50,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Penawaran Hari Ini',
                          style: TextStyle(fontSize: 55, fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          'Diskon 50% untuk Produk Tertentu',
                          style: TextStyle(color: Colors.grey),
                        ),
                        ElevatedButton(
                          onPressed: () {}, // Tombol "Belanja Sekarang"
                          child: const Text('Belanja Sekarang'),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                        ),
                      ],
                    ),
                  ),
                  Image.asset(
                    'assets/gambar/satu.jpg', // Gambar promosi
                    width: 400,
                  ),
                ],
              ),
            ),
            // Bagian freelance terbaik
            const SectionTitle(title: 'Top Rated Freelances'),
            const FreelanceList(), // Widget daftar freelancer
            // Bagian layanan terbaik
            const SectionTitle(title: 'Layanan Terbaik'),
            const ServiceList(), // Daftar layanan
            // Bagian promosi terbaik
            const SectionTitle(title: 'Promosi Terbaik'),
            const PromotionBanner(), // Banner promosi
            // Bagian produk dengan rating tertinggi menggunakan GridView
            const SectionTitle(title: 'Produk Rating Tertinggi'),
            const ProductGrid(), // Daftar produk
          ],
        ),
      ),
      // Navigasi bawah halaman
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () {}, child: const Text('Daftar')), // Tombol daftar
            const SizedBox(width: 10),
            OutlinedButton(onPressed: () {}, child: const Text('Masuk')), // Tombol masuk
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

// Widget untuk menampilkan daftar freelancer
class FreelanceList extends StatelessWidget {
  const FreelanceList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180, // Tinggi widget daftar freelancer
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: freelanceData.length,
        itemBuilder: (context, index) {
          final freelancer = freelanceData[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(freelancer['imagePath']),
                  onBackgroundImageError: (_, __) {
                    debugPrint("Gambar tidak ditemukan: ${freelancer['imagePath']}");
                  },
                  child: freelancer['imagePath'] == null
                      ? const Icon(Icons.person, size: 40, color: Colors.grey)
                      : null, // Fallback gambar default
                ),
                const SizedBox(height: 8),
                Text(
                  freelancer['name'],
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Text(
                  freelancer['profession'],
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    Text(
                      freelancer['rating'].toString(),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// Data freelancer
const List<Map<String, dynamic>> freelanceData = [
  {
    'name': 'Wade Warren',
    'profession': 'Beautician',
    'rating': 4.9,
    'imagePath': 'assets/freelance/jenni.jpg',
  },
  {
    'name': 'John Doe',
    'profession': 'Stylist',
    'rating': 4.8,
    'imagePath': 'assets/freelance/jisoo.jpg',
  },
  {
    'name': 'Jane Smith',
    'profession': 'Makeup Artist',
    'rating': 4.7,
    'imagePath': 'assets/freelance/lisa.jpg',
  },
  {
    'name': 'Emily Johnson',
    'profession': 'Hairdresser',
    'rating': 4.9,
    'imagePath': 'assets/freelance/rose.jpg',
  },
];
class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1.2,
      ),
      itemCount: 5,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Card(
          elevation: 4,
          child: Column(
            children: [
              Image.asset(
                'assets/product/${productImages[index]}',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 2),
              Text(productNames[index]),
              Text('Rp ${(index + 1) * 20000}'),
            ],
          ),
        );
      },
    );
  }
}

const List<String> productImages = [
  'cushion.jpg',
  'farfum.jpg',
  'lipstik.jpg',
  'toner.jpg',
  'bedak.jpg',
];

const List<String> productNames = [
  'Cushion',
  'Farfum',
  'Lipstik',
  'Toner',
  'Bedak',
];


class Service {
  final String imagePath;
  final String name;
  final String subtitle;
  final String description;
  final double rating;

  Service({
    required this.imagePath,
    required this.name,
    required this.subtitle,
    required this.description,
    required this.rating,
  });
}

class ServiceList extends StatelessWidget {
  const ServiceList({super.key});

  @override
  Widget build(BuildContext context) {
    List<Service> services = [
      Service(
        imagePath: 'assets/service/beautician.jpg',
        name: 'Jenniy Kim',
        subtitle: 'Beautician',
        description: '',
        rating: 4.9,
      ),
      Service(
        imagePath: 'assets/service/makeup.jpg',
        name: 'Lalisa Manoban',
        subtitle: 'Makeup Artis',
        description: '',
        rating: 4.7,
      ),
      Service(
        imagePath: 'assets/service/stylis1.jpg',
        name: 'Jisoo Kim',
        subtitle: 'Stylist',
        description: '',
        rating: 4.8,
      ),
    ];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Container(
            color: Colors.blue,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Top Services',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'View All',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Service List
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: services.length,
            itemBuilder: (context, index) {
              Service service = services[index]; 
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 350, vertical: 16.0),
                child: Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          service.imagePath,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(child: Text('Error loading image'));
                          },
                        ),
                      ),
                    ),
                    // Overlay Card
                    Positioned(
                      top: 16,
                      right: 16,
                      child: Container(
                        width: 240,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(10, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              service.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              service.subtitle,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              service.description,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.star, color: Colors.amber, size: 16),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${service.rating}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(255, 190, 136, 200),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    'Book Now',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class PromotionBanner extends StatelessWidget {
  const PromotionBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(50),
      color: Colors.pink.shade100,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Diskon 60%', // Judul promosi
                  style: TextStyle(fontSize: 65, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Dapatkan produk kosmetik dengan diskon dengan 60%! Cepat, tawaran segera berakhir, jangan sampe ketinggalan',
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
                ElevatedButton(
                  onPressed: () {}, // Tombol "Belanja Sekarang"
                  child: const Text('Belanja Sekarang'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                ),
              ],
            ),
          ),
          Image.asset(
            'assets/gambar/satu.jpg', // Gambar promosi
            width: 400,
          ),
        ],
      ),
    );
  }
}
