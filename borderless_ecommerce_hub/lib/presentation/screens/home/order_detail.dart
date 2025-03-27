import 'package:flutter/material.dart';

class OrderDetailScreen extends StatelessWidget {
  final String orderId;
  OrderDetailScreen({required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Order $orderId"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Status: Delivered", style: TextStyle(color: Colors.white, fontSize: 18)),
            SizedBox(height: 10),
            Text("Items:", style: TextStyle(color: Colors.white, fontSize: 18)),
            ListTile(
              leading: Icon(Icons.shopping_bag, color: Colors.purple),
              title: Text("4 Items", style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 10),
            Text("Shipping Details:", style: TextStyle(color: Colors.white, fontSize: 18)),
            ListTile(
              leading: Icon(Icons.location_on, color: Colors.purple),
              title: Text("2715 Ash St, Nairobi", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
