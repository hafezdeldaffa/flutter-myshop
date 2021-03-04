import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshop/widgets/utils/container_title.dart';

class CategoriesItem extends StatelessWidget {
  const CategoriesItem({
    Key key,
    @required this.deviceSize,
  }) : super(key: key);

  final Size deviceSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(width: 10),
              Container(
                margin: const EdgeInsets.only(top: 4),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: const Text(
                  'Discount up to 50%',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(width: 10),
              Container(
                margin: const EdgeInsets.only(top: 4),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: const Text(
                  'Sale Everyday!',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(width: 10),
              Container(
                margin: const EdgeInsets.only(top: 4),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.green[900],
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Text(
                  '100% Original Item',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(width: 10),
            ],
          ),
        ),
        SizedBox(height: 15),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.cyan[900],
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: const [
                  Icon(
                    Icons.confirmation_num,
                    color: Colors.white,
                    size: 30,
                  ),
                  Text(
                    'Coupon',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              Column(
                children: const [
                  Icon(
                    Icons.account_box_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                  Text(
                    'Account',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              Column(
                children: const [
                  Icon(
                    Icons.account_balance_wallet_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                  Text(
                    'Wallet',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
        ContainerTitle('Categories'),
        SizedBox(height: 5),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Container(
                height: deviceSize.height * 0.15,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Image.asset(
                        'assets/images/image-banner1.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Electronic',
                        textAlign: TextAlign.right,
                        style: GoogleFonts.muli(
                          color: Colors.white,
                          backgroundColor: Colors.black45,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: deviceSize.height * 0.15,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Image.asset(
                        'assets/images/image-banner2.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Fashion',
                        textAlign: TextAlign.right,
                        style: GoogleFonts.muli(
                          color: Colors.white,
                          backgroundColor: Colors.black45,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
