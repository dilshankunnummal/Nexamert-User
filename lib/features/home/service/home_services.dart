import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nexamart_user/constants/error_handling.dart';
import 'package:nexamart_user/constants/global_variables.dart';
import 'package:nexamart_user/constants/utils.dart';
import 'package:nexamart_user/models/product.dart';
import 'package:nexamart_user/provider/user_provider.dart';
// import 'package:nexamart/constants/error_handling.dart';
// import 'package:nexamart/constants/global_variables.dart';
// import 'package:nexamart/constants/utils.dart';
// import 'package:nexamart/models/product.dart';
// import 'package:nexamart/provider/user_provider.dart';
import 'package:provider/provider.dart';

class HomeServices {
  Future<List<Product>> fetchCategoryProducts({
    required BuildContext context,
    required String category,
  }) async {
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );
    List<Product> productList = [];
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/api/products?category=$category'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              productList.add(
                Product.fromJson(
                  jsonEncode(
                    jsonDecode(
                      res.body,
                    )[i],
                  ),
                ),
              );
            }
          });
    } catch (e) {
      showSnackbar(
        context,
        e.toString(),
      );
      print(e);
    }
    return productList;
  }

  Future<Product> fetchDealOfDay({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );
    Product product = Product(
      name: '',
      description: '',
      quantity: 0,
      images: [],
      category: '',
      price: 0,
    );
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/api/deal-of-day'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            product = Product.fromJson(res.body);
          });
    } catch (e) {
      showSnackbar(
        context,
        e.toString(),
      );
    }
    return product;
  }

  //Get All Products
  Future<List<Product>> fetchAllProducts({
    required BuildContext context,
  }) async {
    List<Product> products = [];

    try {
      http.Response res = await http.get(
        Uri.parse('http://34.207.150.19:5000/api/get-products'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            products.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(
                    res.body,
                  )[i],
                ),
              ),
            );
          }
        });
      print(products[0].images.first.length);
    } catch (e) {
      print('Error: $e');
      showSnackbar(context, e.toString());
    }
    return products;
  }

  Future<Product> fetchPriceDrop({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );
    Product product = Product(
      name: '',
      description: '',
      quantity: 0,
      images: [],
      category: '',
      price: 0,
    );
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/api/price-drop'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          final Map<String, dynamic> decodedBody = jsonDecode(res.body);
          product = Product.fromMap(decodedBody);
        },
      );
    } catch (e) {
      showSnackbar(
        context,
        e.toString(),
      );
    }
    return product;
  }
}
