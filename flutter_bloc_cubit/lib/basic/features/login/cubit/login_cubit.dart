import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_cubit/basic/features/login/model/login_model.dart';
import 'package:flutter_bloc_cubit/basic/features/login/model/token_model.dart';
import 'package:flutter_bloc_cubit/basic/features/login/service/login_service.dart';

import 'login_cubit_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(ILoginService loginService)
      : _loginService = loginService,
        super(LoginState());

  final ILoginService _loginService;

  Future<void> checkUser(String email, String password) async {
    emit(state.copyWith(isLoading: true, loginModel: LoginModel(email, password)));
    final _response = await _loginService.login(state.loginModel!);   
    emit(state.copyWith(isLoading: false, isCompleted: _response?.data != null,tokenModel: _response?.data));
  }
}
