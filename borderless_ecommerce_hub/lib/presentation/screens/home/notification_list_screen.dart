import 'package:flutter/material.dart';

class NotificationListScreen extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {"title": "Order Shipped", "message": "Your order #5678 has been shipped"},
    {"title": "Order Delivered", "message": "Your order #5678 was delivered"},
    {"title": "New Offer!", "message": "20% off on selected items"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Notifications"),
        backgroundColor: Colors.black,
      ),
      body: notifications.isEmpty
          ? Center(child: Text("No Notifications Yet", style: TextStyle(color: Colors.white)))
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.grey[900],
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: Icon(Icons.notifications, color: Colors.purple),
                    title: Text(notifications[index]["title"]!, style: TextStyle(color: Colors.white)),
                    subtitle: Text(notifications[index]["message"]!, style: TextStyle(color: Colors.grey)),
                  ),
                );
              },
            ),
    );
  }
}