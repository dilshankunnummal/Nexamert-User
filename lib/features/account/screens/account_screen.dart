import 'package:flutter/material.dart';
import 'package:nexamart_user/constants/global_variables.dart';
import 'package:nexamart_user/features/account/widgets/below_app_bar.dart';
import 'package:nexamart_user/features/account/widgets/orders.dart';
import 'package:nexamart_user/features/account/widgets/top_buttons.dart';
// import 'package:nexamart/constants/global_variables.dart';
// import 'package:nexamart/features/account/widgets/below_app_bar.dart';
// import 'package:nexamart/features/account/widgets/orders.dart';
// import 'package:nexamart/features/account/widgets/top_buttons.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: GlobalVariables.backgroundColor,
            ),
          ),
          title: Row(
            spacing: 20,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/images/logoNew.png',
                  width: 60,
                  height: 60,
                ),
              ),
              Text('Profile')
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const BelowAppBar(),
            Container(
              color: GlobalVariables.secondaryColor,
              height: 1,
            ),
            const SizedBox(
              height: 10,
            ),
            const TopButtons(),
            const SizedBox(height: 20),
            const Orders()
          ],
        ),
      ),
    );
  }
}
