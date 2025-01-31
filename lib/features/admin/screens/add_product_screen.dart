import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:nexamart_user/common/widgets/custom_textfield.dart';
import 'package:nexamart_user/common/widgets/custon_button.dart';
import 'package:nexamart_user/constants/utils.dart';
import 'package:nexamart_user/features/admin/services/admin_service.dart';

import '../../../constants/global_variables.dart';
// import 'package:nexamart/common/widgets/custom_textfield.dart';
// import 'package:nexamart/common/widgets/custon_button.dart';
// import 'package:nexamart/constants/global_variables.dart';
// import 'package:nexamart/constants/utils.dart';
// import 'package:nexamart/features/admin/services/admin_service.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add-product';
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  final AdminServices adminServices = AdminServices();

  String category = 'Mobiles';
  List<File> images = [];

  final _addProductFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  List<String> productCategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion'
  ];

  void sellProducts() {
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.sellProducts(
        context: context,
        name: productNameController.text,
        description: descriptionController.text,
        price: double.parse(priceController.text),
        quantity: double.parse(quantityController.text),
        category: category,
        images: images,
      );
    }
  }

  void selectImage() async {
    var res = await pickImages();
    if (res.isNotEmpty) {
      setState(() {
        images = res;
      });
      for (var img in images) {
        print('Image path: ${img.path}');
      }
    } else {
      print('No images selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: const Text(
            'Add Product',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _addProductFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                images.isNotEmpty
                    ? SizedBox(
                  height: 200,
                  child: PageView.builder(
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      return Image.file(
                        images[index],
                        fit: BoxFit.cover,
                        height: 200,
                      );
                    },
                  ),
                )
                    : GestureDetector(
                  onTap: selectImage,
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(10),
                    dashPattern: const [10, 4],
                    strokeCap: StrokeCap.round,
                    child: Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.folder_open,
                            size: 40,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Select Product Images',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey.shade400,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextfield(
                    controller: productNameController,
                    hintText: 'Product Name'),
                const SizedBox(
                  height: 10,
                ),
                CustomTextfield(
                  controller: descriptionController,
                  hintText: 'Description',
                  maxLines: 7,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextfield(controller: priceController, hintText: 'Price'),
                const SizedBox(
                  height: 10,
                ),
                CustomTextfield(
                    controller: quantityController, hintText: 'Quantity'),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    items: productCategories.map((String item) {
                      return DropdownMenuItem(value: item, child: Text(item));
                    }).toList(),
                    onChanged: (String? newVal) {
                      setState(() {
                        category = newVal!;
                      });
                    },
                    value: category,
                    icon: const Icon(Icons.keyboard_arrow_down),
                  ),
                ),
                const SizedBox(height: 10),
                CustomButton(text: 'Sell', onTap: sellProducts),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
