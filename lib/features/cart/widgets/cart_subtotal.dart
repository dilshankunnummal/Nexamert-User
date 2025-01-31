import 'package:flutter/material.dart';
import 'package:nexamart_user/provider/user_provider.dart';
// import 'package:nexamart/provider/user_provider.dart';
import 'package:provider/provider.dart';

class CartSubtotal extends StatelessWidget {
  const CartSubtotal({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    double sum = 0;

    for (var item in user.cart) {
      var quantity = item['quantity'] as int;
      var product = item['product'] as Map<String, dynamic>;
      var price = product['price'].toDouble();
      sum += quantity * price;
    }
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          const Text(
            'Subtotal ',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Text(
            '\₹ $sum',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
