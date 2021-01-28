import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:userapp/src/utils/colors.dart';
import 'package:userapp/src/utils/dimensions.dart';
import 'package:userapp/src/utils/styles.dart';
import 'package:userapp/src/widgets/custom_navigation_bar.dart';

class HomePage extends StatelessWidget {
  final List<NavigationItem> items = [
    NavigationItem(
      icon: '001-home.svg',
      text: 'Home',
    ),
    NavigationItem(
      icon: '002-speech-bubble.svg',
      text: 'Messages',
    ),
    NavigationItem(
      icon: '003-heart.svg',
      text: 'Likes',
    ),
    NavigationItem(
      icon: '004-user.svg',
      text: 'User',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomNavigationBar(
              items: items,
              selected: 0,
              onTabbarChanged: (int value) {
                print('Selected $value');
              },
            ),
            Expanded(
              child: Padding(
                padding: Dimensions.symetric(context, .08, .05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CONTACTOS',
                      style: Styles.textsubtitle(context),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: Dimensions.top(context, .05),
                        scrollDirection: Axis.vertical,
                        itemCount: 10,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return _item(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _item(BuildContext context) {
    return Container(
      margin: Dimensions.vertical(context, .02),
      decoration: BoxDecoration(
        color: CustomColors.yellow.withOpacity(.31),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image(
              image: CachedNetworkImageProvider(
                'https://public-v2links.adobecc.com/a358a5dc-03de-4d2e-40e1-be9ebed4f525/component?params=component_id%3A181c4926-e347-44f6-8e9c-3a4cd246e447&params=version%3A0&token=1611793276_da39a3ee_2e421c61153bd1fc82d9e9c3f075eaf97de3ce46&api_key=CometServer1',
              ),
              height: Dimensions.width(context) * .2,
              width: Dimensions.width(context) * .2,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: Dimensions.height(context) * .03,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'JORGE ROBLES',
                  style: Styles.itemtitle(context),
                ),
                Text(
                  'Gatitotraviso04',
                  style: Styles.itemSubtitle(context),
                ),
              ],
            ),
          ),
          IconButton(
            iconSize: 30,
            color: CustomColors.yellow,
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
