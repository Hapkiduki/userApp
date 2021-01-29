import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:userapp/src/models/response.dart';
import 'package:userapp/src/models/user.dart';

class HomeService {
  Future<Response> loadUsers(GraphQLClient client) async {
    String query = """
      query getUsers(){
        users {
          data {
            id
            name
            username
            email
            phone
            albums {
              data {
                id
                title
                photos {
                  data {
                    id
                    title
                    url
                    thumbnailUrl
                  }
                }
              }
            }
          }
        }
      }
     """;

    var result = await client.query(QueryOptions(
      documentNode: gql(query),
      pollInterval: 10,
    ));

    if (result.hasException) {
      print(result.exception);

      return Response(
          success: false,
          message: 'Lo sentimos ha ocurrido un problema, inténtalo de nuevo.');
    }

    List<User> users = List<User>.from(
        result.data['users']['data'].map((x) => User.fromJson(x)));

    if (users.isEmpty) {
      return Response(
        success: false,
        message: 'No hay datos para mostrar',
      );
    }

    return Response(
      success: true,
      body: users,
    );
  }
}
