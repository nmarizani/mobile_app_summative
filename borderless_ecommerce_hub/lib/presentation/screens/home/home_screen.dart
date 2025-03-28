import 'package:flutter/material.dart';
import 'package:borderless_ecommerce_hub/presentation/screens/home/product/smartwatch_product_listing.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Borderless App',
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            'Categories',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(10),
              children: [
                _buildCategoryCard(context, 'Hoodies', Icons.checkroom),
                _buildCategoryCard(context, 'Bag', Icons.shopping_bag),
                _buildCategoryCard(context, 'Accessories', Icons.watch),
                _buildCategoryCard(context, 'Shoes', Icons.sports_soccer),
                _buildCategoryCard(context, 'Gadget', Icons.devices),
                _buildCategoryCard(context, 'Food', Icons.fastfood),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, String title, IconData icon) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => title == 'Hoodies' ? const HoodiesScreen() : CategoriesScreen(category: title),
          ),
        );
      },
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50),
            Text(title, style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}

class CategoriesScreen extends StatelessWidget {
  final String category;
  const CategoriesScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$category Category'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Products under $category coming soon!'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}

class HoodiesScreen extends StatelessWidget {
  const HoodiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hoodies'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(10),
        children: [
          _buildHoodieCard(context, "Men's Fleece Pullover Hoodie", 100, 'assets/hoodie1.png', true), // First hoodie navigates
          _buildHoodieCard(context, "Fleece Skate Hoodie", 150, 'assets/hoodie2.png', false),
          _buildHoodieCard(context, "Men's Ice-Dye Pullover Hoodie", 120, 'assets/hoodie3.png', false),
          _buildHoodieCard(context, "Classic Green Hoodie", 90, 'assets/hoodie4.png', false),
        ],
      ),
    );
  }

  Widget _buildHoodieCard(BuildContext context, String title, int price, String imagePath, bool navigateToProductListing) {
    return GestureDetector(
      onTap: () {
        if (navigateToProductListing) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProductListingScreen()),
          );
        }
      },
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, height: 100),
            Text(title, style: const TextStyle(fontSize: 16)),
            Text('\$$price', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
