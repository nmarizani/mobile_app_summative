import 'package:flutter/material.dart';
import 'package:borderless_ecommerce_hub/presentation/screens/home/product/filter.dart' as filter_screen;
import 'package:borderless_ecommerce_hub/presentation/screens/home/product/smartwatch_product_listing.dart' as product_listing;

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const filter_screen.FilterScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'RECENT SEARCH',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildRecentSearchItem(context, 'Smart Watch', true),
                  _buildRecentSearchItem(context, 'Laptop', false),
                  _buildRecentSearchItem(context, 'Women bag', false),
                  _buildRecentSearchItem(context, 'Headphones', false),
                  _buildRecentSearchItem(context, 'Shoes', false),
                  _buildRecentSearchItem(context, 'Eye glasses', false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentSearchItem(BuildContext context, String text, bool isAvailable) {
    return ListTile(
      title: Text(text),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        if (isAvailable) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const product_listing.ProductListingScreen()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Out of stock, more products coming soon')),
          );
        }
      },
    );
  }
}

