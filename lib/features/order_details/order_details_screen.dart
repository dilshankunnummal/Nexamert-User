import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nexamart_user/common/widgets/custon_button.dart';
import 'package:nexamart_user/constants/global_variables.dart';
import 'package:nexamart_user/features/admin/services/admin_service.dart';
import 'package:nexamart_user/features/search/screens/search_screen.dart';
import 'package:nexamart_user/models/order.dart';
import 'package:nexamart_user/provider/user_provider.dart';
// import 'package:nexamart/common/widgets/custon_button.dart';
// import 'package:nexamart/constants/global_variables.dart';
// import 'package:nexamart/features/admin/services/admin_service.dart';
// import 'package:nexamart/features/search/screens/search_screen.dart';
// import 'package:nexamart/models/order.dart';
// import 'package:nexamart/provider/user_provider.dart';
import 'package:provider/provider.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const String routeName = '/order-details';
  final Order order;
  const OrderDetailsScreen({super.key, required this.order});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final AdminServices adminServices = AdminServices();
  int currentStep = 0;

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  void initState() {
    currentStep = widget.order.status;
    super.initState();
  }

  //admin part
  void changeOrderStatus(int status) {
    adminServices.changeOrderStatus(
        context: context,
        status: status + 1,
        order: widget.order,
        onSuccess: () {
          setState(() {
            currentStep += 1;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          automaticallyImplyLeading: false,
                    flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Center(
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    'assets/images/logoNew.png',
                    height: 50,
                  ),
                ),
                SizedBox(
                  width: 70,
                ),
                const Text(
                  'Order details',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          // title: Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Expanded(
          //       child: Container(
          //         height: 42,
          //         margin: const EdgeInsets.only(left: 15),
          //         child: Material(
          //           borderRadius: BorderRadius.circular(7),
          //           elevation: 1,
          //           child: TextFormField(
          //             onFieldSubmitted: navigateToSearchScreen,
          //             decoration: InputDecoration(
          //               prefixIcon: InkWell(
          //                 onTap: () {},
          //                 child: const Padding(
          //                   padding: EdgeInsets.only(left: 6),
          //                   child: Icon(
          //                     Icons.search,
          //                     color: Colors.black,
          //                     size: 23,
          //                   ),
          //                 ),
          //               ),
          //               filled: true,
          //               fillColor: Colors.white,
          //               contentPadding: const EdgeInsets.only(top: 10),
          //               border: const OutlineInputBorder(
          //                 borderRadius: BorderRadius.all(
          //                   Radius.circular(7),
          //                 ),
          //                 borderSide: BorderSide.none,
          //               ),
          //               enabledBorder: const OutlineInputBorder(
          //                 borderRadius: BorderRadius.all(
          //                   Radius.circular(7),
          //                 ),
          //                 borderSide:
          //                     BorderSide(color: Colors.black38, width: 1),
          //               ),
          //               hintText: 'Search Sahachari',
          //               hintStyle: const TextStyle(
          //                   fontWeight: FontWeight.w500, fontSize: 17),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //     Container(
          //       color: Colors.transparent,
          //       height: 42,
          //       margin: const EdgeInsets.symmetric(
          //         horizontal: 10,
          //       ),
          //       child: const Icon(
          //         Icons.mic,
          //         color: Colors.black,
          //         size: 25,
          //       ),
          //     )
          //   ],
          // ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order Date:    ${DateFormat().format(
                          DateTime.fromMillisecondsSinceEpoch(
                              widget.order.orderedAt),
                        )}',
                      ),
                      Text("Order ID:        ${widget.order.id}"),
                      Text("Order Total:    \₹${widget.order.totalPrice}")
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Purchase Details',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black12)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      for (int i = 0; i < widget.order.products.length; i++)
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Container(
                                child: Image.network(
                                  widget.order.products[i].images[0],
                                  height: 120,
                                  width: 120,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.order.products[i].name,
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Tracking',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Container(
                  child: Stepper(
                      currentStep: currentStep,
                      controlsBuilder: (context, details) {
                        if (user.type == 'admin') {
                          return CustomButton(
                            text: 'Done',
                            onTap: () => changeOrderStatus(details.currentStep),
                          );
                        }
                        return const SizedBox();
                      },
                      steps: [
                        Step(
                          title: const Text('Pending'),
                          content: const Text(
                            'Your Order is yet to be Out for Delivered',
                          ),
                          isActive: currentStep > 0,
                          state: currentStep > 0
                              ? StepState.complete
                              : StepState.indexed,
                        ),
                        Step(
                          title: const Text('Out for Delivery'),
                          content: const Text(
                            'The order is with the delivery partner and on its way to the customer',
                          ),
                          isActive: currentStep > 1,
                          state: currentStep > 1
                              ? StepState.complete
                              : StepState.indexed,
                        ),
                        Step(
                          title: const Text('Delivered'),
                          content: const Text(
                            'The order has been successfully delivered to the customer',
                          ),
                          isActive: currentStep > 2,
                          state: currentStep > 2
                              ? StepState.complete
                              : StepState.indexed,
                        ),
                        // Step(
                        //   title: const Text('Delivered'),
                        //   content: const Text(
                        //     'Your Order is yet to be delivered and confirmed!',
                        //   ),
                        //   isActive: currentStep >= 3,
                        //   state: currentStep >= 3
                        //       ? StepState.complete
                        //       : StepState.indexed,
                        // ),
                      ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
