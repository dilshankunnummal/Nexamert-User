import 'package:flutter/material.dart';

String uri = 'http://34.207.150.19:5000';

class GlobalVariables {
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromRGBO(202, 208, 86, 1),
      Color.fromRGBO(177, 187, 42, 1),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromRGBO(202, 208, 86, 1);
  static const backgroundColor = Colors.white;
  static const greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = const Color.fromRGBO(202, 208, 86, 1);
  static const unselectedNavBarColor = Colors.black87;

  static const List<String> carouselImages = [
    'https://cdn1.vectorstock.com/i/1000x1000/28/15/shopping-basket-with-grocery-products-sale-banner-vector-33852815.jpg',
    'https://static.vecteezy.com/system/resources/previews/001/254/426/non_2x/online-grocery-shopping-banner-template-with-fruits-vector.jpg',
    'https://media.istockphoto.com/id/524158442/vector/grocery-shopping.jpg?s=612x612&w=0&k=20&c=pzf2ehHsmgcY7xFZdJAU6fwCjG6-WyYeex3tQjmXmgg=',
    'https://www.shutterstock.com/image-vector/farm-fresh-organic-vegetables-order-260nw-2477254945.jpg',
    'https://st.depositphotos.com/3600009/61527/v/450/depositphotos_615277536-stock-illustration-vegetables-grocery-shop-promo-posters.jpg'
  ];

  static const List<Map<String, String>> categoryImages = [
    {
      'title': 'Breakfast',
      'image': 'assets/images/bf.png',
    },
    {
      'title': 'Lunch',
      'image': 'assets/images/lunch.png',
    },
    {
      'title': 'Dinner',
      'image': 'assets/images/dinner.png',
    },
    {
      'title': 'Groceries',
      'image': 'assets/images/gro.png',
    },
    {
      'title': 'Vegetables',
      'image': 'assets/images/veg.png',
    },
  ];
}
