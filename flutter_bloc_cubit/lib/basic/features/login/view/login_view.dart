import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_cubit/basic/features/login/cubit/login_cubit_state.dart';
import 'package:flutter_bloc_cubit/basic/features/login/service/login_service.dart';
import 'package:flutter_bloc_cubit/basic/features/travel/view/travel_tab_view.dart';
import 'package:kartal/kartal.dart';

import '../cubit/login_cubit.dart';
import '../service/vexana_network_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    final _loginText = "Login";
    final _formLoginKey = GlobalKey<FormState>();
    final _emailController = TextEditingController();
    final _passController = TextEditingController();

    _emailController.text = 'eve.holt@reqres.in';
    _passController.text = 'cityslicka';

    return BlocProvider<LoginCubit>(
      create: (context) => LoginCubit(LoginService(VexanaNetworkManager())),
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              return state.isLoading ? CircularProgressIndicator(color: context.colorScheme.onSecondary) : SizedBox();
            },
          ),
          centerTitle: true,
        ),
        body: Form(
            key: _formLoginKey,
            child: Padding(
              padding: context.paddingLow,
              child: Column(
                children: [
                  _buildTextField(emailController: _emailController, passController: _passController),
                  context.emptySizedHeightBoxLow,
                  BlocConsumer<LoginCubit, LoginState>(
                    listener: (context, state) {
                      if (state.isCompleted) {
                        context.navigateToPage(const TravelTabView());
                      }
                    },
                    builder: (context, state) {
                      return ElevatedButton(
                          onPressed: () {
                            if (_formLoginKey.currentState?.validate() ?? false) {
                              context.read<LoginCubit>().checkUser(_emailController.text, _passController.text);
                            }
                          },
                          child: Padding(
                            padding: context.paddingNormal,
                            child: Text('$_loginText-${state.loginModel?.email ?? ''}'),
                          ));
                    },
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

class _buildTextField extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passController;

  const _buildTextField({
    Key? key,
    required this.emailController,
    required this.passController,
  })  : _emailController = emailController,
        _passController = passController,
        super(key: key);

  final TextEditingController _emailController;
  final TextEditingController _passController;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LoginCubit, LoginState, bool>(
      selector: (state) {
        return state.isLoading;
      },
      builder: (context, state) {
        return IgnorePointer(
          ignoring: state,
          child: AnimatedOpacity(
            duration: context.durationLow,
            opacity: state ? 0.3 : 1,
            child: Column(
              children: [
                TextFormField(
                  controller: _emailController,
                  autovalidateMode: AutovalidateMode.always,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) => (value?.isValidEmail ?? false) ? null : "Problem",
                ),
                TextFormField(
                  controller: _passController,
                  autovalidateMode: AutovalidateMode.always,
                  decoration: const InputDecoration(labelText: 'Password'),
                  validator: (value) => ((value?.length ?? 0) > 6) ? null : "Problem",
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
