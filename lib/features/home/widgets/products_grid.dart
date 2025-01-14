import 'package:flutter/material.dart';
import '../../../common/widgets/loader.dart';
import '../../../models/product.dart';
import '../../product_details/screens/product_details_screen.dart';
import '../service/home_services.dart';

class ProductsGrid extends StatefulWidget {
  const ProductsGrid({super.key});

  @override
  State<ProductsGrid> createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {
  List<Product>? products;

  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchDealOfDay();
  }

  void navigateToDetailScreen(BuildContext context, Product product) {
    Navigator.pushNamed(
      context,
      ProductDetailsScreen.routeName,
      arguments: product,
    );
  }

  void fetchDealOfDay() async {
    products = await homeServices.fetchAllProducts(
      context: context,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? Padding(
            padding: const EdgeInsets.only(top: 20),
            child: const Loader(),
          )
        : products?.length == 0
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: products?.length,
                  itemBuilder: (context, index) {
                    final product = products?[index];
                    return ProductCard(
                      product: product!,
                      navigateToDetailScreen: navigateToDetailScreen,
                    );
                  },
                ),
              );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final Function(BuildContext, Product) navigateToDetailScreen;

  const ProductCard({
    Key? key,
    required this.product,
    required this.navigateToDetailScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Decode the base64 image string
    // String decodedImage = product.images.first.split(',').last;
    // Uint8List imageBytes = base64Decode(decodedImage) as Uint8List;

    return GestureDetector(
      onTap: () {
        navigateToDetailScreen(context, product);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(5)),
              child: Image.network(
                product.images.first,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\₹${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.category,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
