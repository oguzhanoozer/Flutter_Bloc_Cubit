// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:flutter_bloc_cubit/basic/features/login/model/login_model.dart';
import 'package:flutter_bloc_cubit/basic/features/login/model/token_model.dart';

///abstract class LoginState {}

// class LoginInitial extends LoginState {
//   final bool isLoading = false;
// }

class LoginState extends Equatable {
  final bool isLoading;
  final LoginModel? loginModel;
  final TokenModel? tokenModel;
  final bool isCompleted;

  LoginState({this.isLoading = false, this.loginModel, this.tokenModel, this.isCompleted = false});

  @override
  List<Object?> get props => [isLoading, loginModel];

  LoginState copyWith({
    bool? isLoading,
    LoginModel? loginModel,
    TokenModel? tokenModel,
    bool? isCompleted,
  }) {
    return LoginState(
      isLoading: isLoading ?? false,
      loginModel: loginModel ?? this.loginModel,
      tokenModel: tokenModel ?? this.tokenModel,
      isCompleted: isCompleted ?? false,
    );
  }
}
