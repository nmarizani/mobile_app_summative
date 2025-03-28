import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShippingDetailsPage extends StatefulWidget {
  @override
  _ShippingDetailsPageState createState() => _ShippingDetailsPageState();
}

class _ShippingDetailsPageState extends State<ShippingDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();

  String? _selectedProvince;
  String? _selectedCity;
  List<String> provinces = ['Province 1', 'Province 2', 'Province 3'];
  Map<String, List<String>> cities = {
    'Province 1': ['City A1', 'City B1'],
    'Province 2': ['City A2', 'City B2'],
    'Province 3': ['City A3', 'City B3'],
  };

  void _navigateToPayment() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PaymentMethodPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Shipping Details')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Full Name'),
                validator: (value) => value!.isEmpty ? 'Enter your name' : null,
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (value) => value!.isEmpty ? 'Enter phone number' : null,
              ),
              DropdownButtonFormField<String>(
                value: _selectedProvince,
                hint: Text('Select Province'),
                items: provinces.map((String province) {
                  return DropdownMenuItem<String>(
                    value: province,
                    child: Text(province),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedProvince = value;
                    _selectedCity = null;
                  });
                },
                validator: (value) => value == null ? 'Select province' : null,
              ),
              DropdownButtonFormField<String>(
                value: _selectedCity,
                hint: Text('Select City'),
                items: _selectedProvince != null
                    ? cities[_selectedProvince]!.map((String city) {
                        return DropdownMenuItem<String>(
                          value: city,
                          child: Text(city),
                        );
                      }).toList()
                    : [],
                onChanged: (value) {
                  setState(() {
                    _selectedCity = value;
                  });
                },
                validator: (value) => value == null ? 'Select city' : null,
              ),
              TextFormField(
                controller: _streetController,
                decoration: InputDecoration(labelText: 'Street Address'),
                validator: (value) => value!.isEmpty ? 'Enter street address' : null,
              ),
              TextFormField(
                controller: _postalCodeController,
                decoration: InputDecoration(labelText: 'Postal Code'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Enter postal code' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _navigateToPayment,
                child: Text('Save & Continue to Payment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentMethodPage extends StatefulWidget {
  @override
  _PaymentMethodPageState createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  String? _selectedPaymentMethod;
  List<String> paymentMethods = ['PayPal', 'Google Pay', 'Credit Card'];

  void _confirmPayment() {
    if (_selectedPaymentMethod != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment method: $_selectedPaymentMethod selected')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Payment Method')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Select a Payment Method', style: TextStyle(fontSize: 18)),
            ...paymentMethods.map((method) => RadioListTile<String>(
                  title: Text(method),
                  value: method,
                  groupValue: _selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      _selectedPaymentMethod = value;
                    });
                  },
                )),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _confirmPayment,
              child: Text('Confirm Payment'),
            ),
          ],
        ),
      ),
    );
  }
}