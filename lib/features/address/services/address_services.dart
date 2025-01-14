// ignore_for_file: use_build_context_synchronously, unnecessary_import

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:nexamart_user/common/widgets/bottom_bar.dart';
import 'package:nexamart_user/constants/error_handling.dart';
import 'package:nexamart_user/constants/global_variables.dart';
import 'package:nexamart_user/constants/utils.dart';
import 'package:nexamart_user/models/user.dart';
import 'package:nexamart_user/provider/user_provider.dart';
import 'package:provider/provider.dart';

class AddressServices {
  void saveUserAdress({
    required BuildContext context,
    required String address,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res =
          await http.post(Uri.parse('$uri/api/save-user-address'),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': userProvider.user.token,
              },
              body: jsonEncode({
                'address': address,
              }));

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            User user = userProvider.user.copyWith(
              address: jsonDecode(res.body)['address'],
            );
            userProvider.setUserFromModel(user);
          });
    } catch (e) {
      showSnackbar(
        context,
        e.toString(),
      );
      print('error is here');
    }
  }

  void placeOrder({
    required BuildContext context,
    required String address,
    required double totalSum,
  }) async {
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );

    try {
      // Extract adminId from the first product in the cart (if needed for all, handle differently)
      // String? adminId = userProvider.user.cart.isNotEmpty
      //     ? Product.fromMap(userProvider.user.cart.first).adminId
      //     : null;

      // print(adminId);
      // Prepare the cart without modification
      List<Map<String, dynamic>> cartWithDetails =
          userProvider.user.cart.map((item) {
        return Map<String, dynamic>.from(item); // Ensure it's properly mapped
      }).toList();

      // Make the HTTP request
      http.Response res = await http.post(
        Uri.parse('$uri/api/order'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'cart': cartWithDetails, // Full cart data
          'address': address,
          'totalPrice': totalSum,
          // 'adminId': adminId, // Add adminId to the top-level object
        }),
      );

      // Handle the response
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackbar(context, 'Order has been placed');
          User user = userProvider.user.copyWith(cart: []);
          userProvider.setUserFromModel(user);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  BottomBar(), // Replace with your target screen
            ),
          );
        },
      );
    } catch (e) {
      showSnackbar(
        context,
        e.toString(),
      );
      print(e);
    }
  }
}
