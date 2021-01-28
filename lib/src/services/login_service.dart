import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:userapp/src/models/user.dart';
import 'package:userapp/src/models/response.dart';

class LoginService {
  Future<Response> login(
      Map<String, dynamic> data, GraphQLClient client) async {
    String query = """
      query getUSer(\$username: String, \$phone: String){
        users(options: {
          operators: [
            {
              kind: LIKE
              field: "username"
              value: \$username
            }
            {
              kind: LIKE
              field: "phone"
              value: \$phone
            }
          ]
        }) {
          data {
            id
            name
            username
            email
            phone
            
          }
        }
      }

     """;

    var result = await client.query(QueryOptions(
      documentNode: gql(query),
      variables: data,
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
        message: 'El usuario que ingresaste no existe en el sistema.',
      );
    }

    return Response(
      success: true,
      body: users.first,
    );
  }
}
