import 'package:flutter/material.dart';
import 'order_detail.dart';

class OrderListScreen extends StatefulWidget {
  @override
  _OrderListScreenState createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  final List<String> tabs = ["Processing", "Shipped", "Delivered", "Returned", "Canceled"];
  int selectedTabIndex = 0;

  final List<Map<String, String>> orders = [
    {"id": "#5678", "status": "Processing", "date": "28 May"},
    {"id": "#1234", "status": "Shipped", "date": "27 May"},
    {"id": "#9101", "status": "Delivered", "date": "26 May"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Orders"),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                tabs.length,
                (index) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: ChoiceChip(
                    label: Text(tabs[index]),
                    selected: selectedTabIndex == index,
                    onSelected: (_) => setState(() => selectedTabIndex = index),
                    selectedColor: Colors.purple,
                    backgroundColor: Colors.grey[900],
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.grey[900],
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text("Order ${orders[index]["id"]}", style: TextStyle(color: Colors.white)),
                    subtitle: Text("Status: ${orders[index]["status"]}", style: TextStyle(color: Colors.grey)),
                    trailing: Text(orders[index]["date"]!, style: TextStyle(color: Colors.purple)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                         builder: (context) => OrderDetailScreen(orderId: orders[index]["id"]!),
                    ),
                 );
                    },
                  ),
                );  
              },
            ),
          ),
        ],
      ),
    );
  }
}
