import 'package:flutter/material.dart';
import 'package:nexamart_user/constants/global_variables.dart';
import 'package:nexamart_user/features/home/widgets/carousel_image.dart';
import 'package:nexamart_user/features/home/widgets/deal_of_day.dart';
import 'package:nexamart_user/features/home/widgets/price_drop.dart';
import 'package:nexamart_user/features/home/widgets/products_grid.dart';
import 'package:nexamart_user/features/home/widgets/top_catagories.dart';
import 'package:nexamart_user/features/search/screens/search_screen.dart';
// import 'package:nexamart/constants/global_variables.dart';
// import 'package:nexamart/features/home/widgets/carousel_image.dart';
// import 'package:nexamart/features/home/widgets/deal_of_day.dart';
// import 'package:nexamart/features/home/widgets/price_drop.dart';
// import 'package:nexamart/features/home/widgets/top_catagories.dart';
// import 'package:nexamart/features/search/screens/search_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(color: GlobalVariables.backgroundColor),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/images/logoNew.png',
                  height: 50,
                ),
              ),
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      controller: searchController,
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                        // prefixIcon: const SizedBox(),
                        suffixIcon: InkWell(
                          onTap: () {
                            navigateToSearchScreen(searchController.text);
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(7),
                                  bottomRight: Radius.circular(7)),
                              color: GlobalVariables.secondaryColor,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.only(left: 6),
                              child: Icon(
                                Icons.search,
                                color: Colors.black,
                                size: 23,
                              ),
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide:
                              BorderSide(color: Colors.black12, width: 1),
                        ),
                        hintText: 'Search Sahachari',
                        hintStyle:
                            const TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ),
                  ),
                ),
              ),
              // Container(
              //   color: Colors.transparent,
              //   height: 42,
              //   margin: const EdgeInsets.symmetric(
              //     horizontal: 10,
              //   ),
              //   child: const Icon(
              //     Icons.mic,
              //     color: Colors.black,
              //     size: 25,
              //   ),
              // )
            ],
          ),
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            TopCatagories(),
            // SizedBox(
            //   height: 10,
            // ),
            PageViewImage(),
            ProductsGrid()
            //DealOfDay(),
            //PriceDrop()
          ],
        ),
      ),
    );
  }
}
