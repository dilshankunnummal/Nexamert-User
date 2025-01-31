import 'package:flutter/material.dart';
import 'package:nexamart_user/constants/global_variables.dart';
import 'package:nexamart_user/constants/utils.dart';
import 'package:nexamart_user/features/address/screens/address_screen.dart';
import 'package:nexamart_user/features/cart/widgets/cart_product.dart';
import 'package:nexamart_user/features/cart/widgets/cart_subtotal.dart';
import 'package:nexamart_user/features/home/widgets/address_box.dart';
import 'package:nexamart_user/features/search/screens/search_screen.dart';
import 'package:nexamart_user/provider/user_provider.dart';
// import 'package:nexamart/common/widgets/custon_button.dart';
// import 'package:nexamart/constants/global_variables.dart';
// import 'package:nexamart/constants/utils.dart';
// import 'package:nexamart/features/address/screens/address_screen.dart';
// import 'package:nexamart/features/cart/widgets/cart_product.dart';
// import 'package:nexamart/features/cart/widgets/cart_subtotal.dart';
// import 'package:nexamart/features/home/widgets/address_box.dart';
// import 'package:nexamart/features/search/screens/search_screen.dart';
// import 'package:nexamart/provider/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../common/widgets/custon_button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  void navigateToAddressScreen(int sum) {
    Navigator.pushNamed(
      context,
      AddressScreen.routeName,
      arguments: sum.toString(),
    );
  }

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
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      // appBar: PreferredSize(
      //   preferredSize: const Size.fromHeight(60),
      //   child: AppBar(
      //     flexibleSpace: Container(
      //       decoration:
      //           const BoxDecoration(color: GlobalVariables.backgroundColor),
      //     ),
      //     title: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         Expanded(
      //           child: Container(
      //             height: 42,
      //             // margin: const EdgeInsets.onl,
      //             child: Material(
      //               borderRadius: BorderRadius.circular(7),
      //               elevation: 1,
      //               child: TextFormField(
      //                 onFieldSubmitted: navigateToSearchScreen,
      //                 decoration: InputDecoration(
      //                   // prefixIcon: const SizedBox(),
      //                   suffixIcon: InkWell(
      //                     onTap: () {},
      //                     child: Container(
      //                       decoration: const BoxDecoration(
      //                         borderRadius: BorderRadius.only(
      //                             topRight: Radius.circular(7),
      //                             bottomRight: Radius.circular(7)),
      //                         color: GlobalVariables.secondaryColor,
      //                       ),
      //                       child: const Padding(
      //                         padding: EdgeInsets.only(left: 6),
      //                         child: Icon(
      //                           Icons.search,
      //                           color: Colors.black,
      //                           size: 23,
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //                   filled: true,
      //                   fillColor: Colors.white,
      //                   contentPadding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
      //                   border: const OutlineInputBorder(
      //                     borderRadius: BorderRadius.all(
      //                       Radius.circular(7),
      //                     ),
      //                     borderSide: BorderSide.none,
      //                   ),
      //                   enabledBorder: const OutlineInputBorder(
      //                     borderRadius: BorderRadius.all(
      //                       Radius.circular(7),
      //                     ),
      //                     borderSide:
      //                         BorderSide(color: Colors.black12, width: 1),
      //                   ),
      //                   hintText: 'Search NexaMart.in',
      //                   hintStyle: const TextStyle(
      //                       color: Colors.grey,fontSize: 14),
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ),
      //         // Container(
      //         //   color: Colors.transparent,
      //         //   height: 42,
      //         //   margin: const EdgeInsets.symmetric(
      //         //     horizontal: 10,
      //         //   ),
      //         //   child: const Icon(
      //         //     Icons.mic,
      //         //     color: Colors.black,
      //         //     size: 25,
      //         //   ),
      //         // )
      //       ],
      //     ),
      //   ),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const AddressBox(),
              const CartSubtotal(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                  text: 'Proceed to Buy(${user.cart.length})',
                  onTap: () => sum == 0
                      ? showSnackbar(context, 'Add a product for purchase')
                      : navigateToAddressScreen(sum.toInt()),
                  color: GlobalVariables.secondaryColor,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                color: Colors.black12.withOpacity(0.08),
                height: 1,
              ),
              const SizedBox(
                height: 5,
              ),
              ListView.builder(
                itemCount: user.cart.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return CartProduct(
                    index: index,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
