import 'package:flutter/material.dart';
import 'package:borderless_ecommerce_hub/presentation/screens/home/product/search.dart';
import 'package:borderless_ecommerce_hub/presentation/screens/home/product/filter.dart';
import 'package:borderless_ecommerce_hub/presentation/screens/home/product/product_details.dart';
import 'package:borderless_ecommerce_hub/presentation/screens/home/wishlist/wishlist_screen.dart'; // Ensure WishlistScreen exists

class ProductListingScreen extends StatefulWidget {
  const ProductListingScreen({super.key});

  @override
  _ProductListingScreenState createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  List<Map<String, dynamic>> watches = [
    {'name': "Loop Silicone Smartwatch", 'price': 15.25, 'oldPrice': 20.00, 'image': 'assets/loop_silicone.png', 'liked': false},
    {'name': "K800 Ultra Smart Watch", 'price': 32.00, 'oldPrice': 55.00, 'image': 'assets/k800_ultra.png', 'liked': false},
    {'name': "Waterproof Sport M4", 'price': 8.95, 'oldPrice': 15.00, 'image': 'assets/sport_m4.png', 'liked': false},
    {'name': "M6 Smart Watch IP67", 'price': 12.00, 'oldPrice': 18.00, 'image': 'assets/m6_smart.png', 'liked': false},
    {'name': "Classic Silver Watch", 'price': 45.00, 'oldPrice': 60.00, 'image': 'assets/classic_silver.png', 'liked': false},
    {'name': "Smart Fitness Band", 'price': 20.00, 'oldPrice': 30.00, 'image': 'assets/fitness_band.png', 'liked': false},
  ];

  Set<String> wishlist = {}; // ✅ Define Wishlist Set

  Future<void> _openFilterScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FilterScreen()),
    );

    if (result != null && result is String) {
      _applyFilter(result);
    }
  }

  void _applyFilter(String filter) {
    setState(() {
      if (filter == 'Price (Low to High)') {
        watches.sort((a, b) => a['price'].compareTo(b['price']));
      } else if (filter == 'Price (High to Low)') {
        watches.sort((a, b) => b['price'].compareTo(a['price']));
      } else if (filter == 'A - Z') {
        watches.sort((a, b) => a['name'].compareTo(b['name']));
      } else if (filter == 'Z - A') {
        watches.sort((a, b) => b['name'].compareTo(a['name']));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Watches'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SearchScreen()),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _openFilterScreen,
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WishlistScreen(wishlistItems: wishlist), // ✅ Fixed
              ),
            ),
          ),
        ],
      ), // ✅ Fixed misplaced closing parenthesis

      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.7,
        ),
        itemCount: watches.length,
        itemBuilder: (context, index) {
          return _buildWatchCard(index);
        },
      ),
    );
  }

  Widget _buildWatchCard(int index) {
    final watch = watches[index];

    return GestureDetector(
      onTap: () {
        if (watch['name'] == "Loop Silicone Smartwatch") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProductDetailScreen()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("More product details coming soon!")),
          );
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(watch['image'], height: 120),
                const SizedBox(height: 5),
                Text(watch['name'], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '\$${watch['price']}',
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '\$${watch['oldPrice']}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey, decoration: TextDecoration.lineThrough),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (i) => _buildColorDot(Colors.primaries[i])),
                ),
              ],
            ),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: Icon(
                  watch['liked'] ? Icons.favorite : Icons.favorite_border,
                  color: watch['liked'] ? Colors.red : null,
                ),
                onPressed: () {
                  setState(() {
                    watches[index]['liked'] = !watches[index]['liked'];

                    // ✅ Update Wishlist Set
                    if (watches[index]['liked']) {
                      wishlist.add(watch['name']);
                    } else {
                      wishlist.remove(watch['name']);
                    }
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorDot(Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black, width: 0.5),
      ),
    );
  }
}
