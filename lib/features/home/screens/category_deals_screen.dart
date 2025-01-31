import 'package:flutter/material.dart';
import 'package:nexamart_user/common/widgets/loader.dart';
import 'package:nexamart_user/features/cart/services/cart_services.dart';
import 'package:nexamart_user/features/home/service/home_services.dart';

// import 'package:nexamart_user/features/home/service/home_services.dart
import 'package:nexamart_user/features/product_details/services/product_details_services.dart';
import 'package:nexamart_user/models/product.dart';
import 'package:nexamart_user/provider/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../constants/global_variables.dart';

// import 'package:nexamart/common/widgets/loader.dart';
// import 'package:nexamart/constants/global_variables.dart';
// import 'package:nexamart/features/home/service/home_services.dart';
// import 'package:nexamart/features/product_details/screens/product_details_screen.dart';
// import 'package:nexamart/models/product.dart';

class CategoryDealsScreen extends StatefulWidget {
  static const String routeName = '/category-deals';
  final String category;

  const CategoryDealsScreen({super.key, required this.category});

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  List<Product>? productList;
  final HomeServices homeServices = HomeServices();

  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();
  final CartServices cartServices = CartServices();

  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  fetchCategoryProducts() async {
    productList = await homeServices.fetchCategoryProducts(
        context: context, category: widget.category);
    setState(() {});
  }

  // void findInCart(Product product) async{
  //   final productInCart = context.watch<UserProvider>()
  //       .user.cart.length;
  //   for(var item in context.watch<UserProvider>().user.cart){
  //     // if(item['product.id'])
  //     print(product.id);
  //     print(item['product']['_id']);
  //   }
  //   print(productInCart.toString());
  //   // setState(() {
  //   //   var quantity1 = (productInCart != null) ? productInCart['quantity'] : 0;
  //   // });
  // }

  // void addToCart() async {
  //   productDetailsServices.addToCart(
  //     context: context,
  //     product: widget.product,
  //   );
  // }

  // void addToCart(Product product) {
  //   cartServices.addToCart(context: context, product: product);
  // }

  void increaseQuantity(Product product) {
    productDetailsServices.addToCart(context: context, product: product);
  }

  void decreaseQuantity(Product product) {
    cartServices.removeFromCart(context: context, product: product);
  }

  @override
  Widget build(BuildContext context) {
    // final productCart = context.watch<UserProvider>().user.cart[widget.index];
    // final product = Product.fromMap(productCart['product']);
    // final quantity = productCart['quantity'];
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Text(widget.category),
        ),
      ),
      body: productList == null
          ? const Loader()
          : Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Keep shopping for ${widget.category}',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: productList!.length,
                    itemBuilder: (context, index) {
                      final product = productList![index];
                      final productInCart =
                          context.watch<UserProvider>().user.cart.firstWhere(
                                (cartItem) =>
                                    cartItem['product'] != null &&
                                    cartItem['product']['_id'] == product.id,
                                orElse: () => <String, dynamic>{},
                              );

                      final quantity = (productInCart != null)
                          ? productInCart['quantity']
                          : 0;

                      return Column(
                        children: [
                          Row(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3)),
                                    child: Image.network(
                                      product.images[0],
                                      fit: BoxFit.contain,
                                      height: 100,
                                      width: 100,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    width: 235,
                                    child: Text(
                                      product.name,
                                      style: const TextStyle(fontSize: 16),
                                      maxLines: 2,
                                    ),
                                  ),
                                  Container(
                                    width: 235,
                                    padding:
                                        const EdgeInsets.only(left: 10, top: 5),
                                    child: Text(
                                      '\₹${product.price}',
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                      maxLines: 2,
                                    ),
                                  ),
                                  Container(
                                    width: 235,
                                    padding: const EdgeInsets.only(left: 10),
                                    child: const Text(
                                        'Eligible for Free Shipping'),
                                  ),
                                  Container(
                                    width: 235,
                                    padding:
                                        const EdgeInsets.only(left: 10, top: 5),
                                    child: product.quantity != 0
                                        ? const Text(
                                            'In Stocks',
                                            style:
                                                TextStyle(color: Colors.teal),
                                            maxLines: 2,
                                          )
                                        : const Text(
                                            'Out of Stocks',
                                            style: TextStyle(color: Colors.red),
                                            maxLines: 2,
                                          ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black12, width: 1.5),
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.black12,
                                  ),
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () => decreaseQuantity(product),
                                        child: Container(
                                          width: 25,
                                          height: 25,
                                          alignment: Alignment.center,
                                          child: const Icon(
                                            Icons.remove,
                                            size: 15,
                                          ),
                                        ),
                                      ),
                                      DecoratedBox(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black12,
                                              width: 1.5),
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(0),
                                        ),
                                        child: Container(
                                          width: 25,
                                          height: 25,
                                          alignment: Alignment.center,
                                          child: Text(
                                            quantity == null
                                                ? '0'
                                                : quantity.toString(),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () => increaseQuantity(product),
                                        child: Container(
                                          width: 25,
                                          height: 25,
                                          alignment: Alignment.center,
                                          child: const Icon(
                                            Icons.add,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
