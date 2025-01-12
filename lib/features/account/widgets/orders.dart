import 'package:flutter/material.dart';
import 'package:nexamart_user/common/widgets/loader.dart';
import 'package:nexamart_user/constants/global_variables.dart';
import 'package:nexamart_user/features/account/services/account_services.dart';
import 'package:nexamart_user/features/account/widgets/single_product.dart';
import 'package:nexamart_user/features/order_details/order_details_screen.dart';
import 'package:nexamart_user/models/order.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  final AccountServices accountServices = AccountServices();
  List<Order>? orders;

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await accountServices.fetchMyOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : orders!.isEmpty
        ? const Center(
      child: Text(
        'No orders found',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
    )
        : Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Your Orders',
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w600),
              ),
              // Uncomment if you want a "See All" option.
              // Container(
              //   padding: const EdgeInsets.only(right: 15),
              //   child: Text(
              //     'See all',
              //     style: TextStyle(
              //       fontSize: 18,
              //       fontWeight: FontWeight.w600,
              //       color: GlobalVariables.selectedNavBarColor,
              //     ),
              //   ),
              // ),
            ],
          ),
          const SizedBox(height: 10),
          // List of orders displayed vertically
          SingleChildScrollView(
            child: ListView.builder(
              shrinkWrap: true,  // Allow it to take only the space it needs
              physics: const NeverScrollableScrollPhysics(), // Disable scrolling
              itemCount: orders!.length,
              itemBuilder: (context, index) {
                if (orders![index].products.isNotEmpty) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        OrderDetailsScreen.routeName,
                        arguments: orders![index],
                      );
                    },
                    child: SingleProduct(
                      image: orders![index].products[0].images[0],
                      productName: orders![index].products[0].name,
                      orderDate: orders![index].orderedAt,
                    ),
                  );
                } else {
                  return const SizedBox.shrink(); // Skip orders with no products
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
