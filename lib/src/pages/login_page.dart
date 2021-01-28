import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:userapp/src/services/login_service.dart';
import 'package:userapp/src/utils/colors.dart';
import 'package:userapp/src/utils/custom-dialogs.dart';
import 'package:userapp/src/utils/dimensions.dart';
import 'package:userapp/src/utils/routes.dart';
import 'package:userapp/src/utils/styles.dart';
import 'package:userapp/src/widgets/buttons.dart';
import 'package:userapp/src/widgets/custom_input.dart';

class LoginPage extends StatelessWidget {
  final ValueNotifier<bool> _loading = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _isValid = ValueNotifier<bool>(false);
  final formKey = GlobalKey<FormState>();

  validateForm() {
    _isValid.value = formKey.currentState.validate();
  }

  String _validator(String value) {
    if (value.isEmpty) {
      return 'Este campo es obligatorio';
    }

    if (value.length < 3) {
      return 'Debe contener mínimo 3 caracteres';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.yellow,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: Dimensions.height(context),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    color: CustomColors.yellow,
                  ),
                ),
                Expanded(
                  child: Stack(
                    overflow: Overflow.visible,
                    children: [
                      Container(
                        padding: Dimensions.fromLTRB(context, .1, .2, .1, 0),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 2,
                              color: CustomColors.white2,
                            )
                          ],
                          color: CustomColors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(120),
                          ),
                        ),
                        child: GraphQLConsumer(builder: (client) {
                          return _form(context, client);
                        }),
                      ),
                      Positioned(
                        left: Dimensions.width(context) * .1,
                        right: 0,
                        top: -(Dimensions.height(context) * .4),
                        child: Image(
                          image: AssetImage('assets/images/download.png'),
                          fit: BoxFit.scaleDown,
                          height: Dimensions.height(context) * .5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _form(BuildContext context, GraphQLClient client) {
    Map<String, dynamic> data = {};

    return ValueListenableBuilder(
      valueListenable: _loading,
      builder: (context, bool loading, child) => Stack(
        children: [
          AbsorbPointer(
            absorbing: loading,
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onChanged: validateForm,
              child: Column(
                children: [
                  CustomInput(
                    icon: Icons.person_outline,
                    placeholder: 'Username',
                    validator: _validator,
                    onSaved: (value) {
                      data['username'] = value;
                    },
                  ),
                  SizedBox(
                    height: Dimensions.height(context) * .02,
                  ),
                  CustomInput(
                    isPassword: true,
                    icon: Icons.lock_outlined,
                    placeholder: 'Password',
                    validator: _validator,
                    onSaved: (value) {
                      data['phone'] = value;
                    },
                  ),
                  SizedBox(
                    height: Dimensions.height(context) * .05,
                  ),
                  ValueListenableBuilder(
                      valueListenable: _isValid,
                      builder: (context, bool isValid, child) =>
                          Buttons().circularButton(
                            context,
                            onPressed: !isValid
                                ? null
                                : () async {
                                    formKey.currentState.save();
                                    _loading.value = true;

                                    // 'Bret', '1-770-736'
                                    var result = await LoginService()
                                        .login(data, client);

                                    _loading.value = false;

                                    if (!result.success) {
                                      CustomDialogs.showMessageDialog(
                                          result.message, context);
                                      return;
                                    }

                                    Navigator.pushReplacementNamed(
                                        context, Routes.HOME);
                                  },
                            text: 'SIGN IN',
                            color: CustomColors.yellow,
                          )),
                  SizedBox(
                    height: Dimensions.height(context) * .02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don’t have an account?',
                        style: Styles.textMini(context),
                      ),
                      FlatButton(
                          onPressed: () {},
                          child: Text(
                            'SIGN UP',
                            style: Styles.textLink(context),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
          if (loading)
            Center(
              child: CircularProgressIndicator(
                backgroundColor: CustomColors.blue,
                strokeWidth: 10,
              ),
            ),
        ],
      ),
    );
  }
}
