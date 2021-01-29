import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:userapp/src/models/response.dart';
import 'package:userapp/src/models/user.dart';

import 'package:userapp/src/services/home_service.dart';

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

  Future<Response> _loadData(GraphQLClient client) async {
    return await HomeService().loadUsers(client);
  }

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
                      child: GraphQLConsumer(builder: (client) {
                        return FutureBuilder<Response>(
                            future: _loadData(client),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    backgroundColor: CustomColors.blue,
                                    strokeWidth: 10,
                                  ),
                                );
                              }

                              if (!snapshot.data.success) {
                                return Center(
                                  child: Text(
                                    snapshot.data.message,
                                    style: Styles.textField(context),
                                  ),
                                );
                              }

                              List<User> users = snapshot.data.body;

                              return ListView.builder(
                                padding: Dimensions.top(context, .05),
                                scrollDirection: Axis.vertical,
                                itemCount: users.length,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return _item(context, users[index]);
                                },
                              );
                            });
                      }),
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

  Container _item(BuildContext context, User user) {
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
                user.albums.first.photos.first.thumbnailUrl,
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
                  user.name,
                  style: Styles.itemtitle(context),
                ),
                Text(
                  user.email,
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
