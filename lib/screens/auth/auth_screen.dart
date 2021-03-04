import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:myshop/widgets/auth/auth_card.dart';


enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    // final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    // transformConfig.translate(-10.0);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      // transform: Matrix4.rotationZ( * pi / 180)
                      //   ..translate(-10.0),
                      // ..translate(-10.0),

                      child: Container(
                          child: CarouselSlider(
                        options: CarouselOptions(
                          aspectRatio: 2.0,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                          autoPlay: true,
                        ),
                        items: [
                          Image.asset(
                            'assets/images/tokoku-logo.png',
                            fit: BoxFit.contain,
                          ),
                          Image.asset(
                            'assets/images/vector-1.png',
                            fit: BoxFit.contain,
                          ),
                          Image.asset(
                            'assets/images/vector-2.png',
                            fit: BoxFit.contain,
                          ),
                          Image.asset(
                            'assets/images/vector-3.png',
                            fit: BoxFit.contain,
                          ),
                        ],
                      )),
                    ),
                  ),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: AuthCard(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
