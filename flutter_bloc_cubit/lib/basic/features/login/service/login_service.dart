import 'package:flutter_bloc_cubit/basic/features/login/model/login_model.dart';
import 'package:flutter_bloc_cubit/basic/features/login/model/token_model.dart';
import 'package:vexana/vexana.dart';

abstract class ILoginService {
  final INetworkManager networkManager;

  ILoginService(this.networkManager);

  Future<IResponseModel<TokenModel?>?> login(LoginModel model);

  final _loginPath = 'api/login';
}

class LoginService extends ILoginService {
  LoginService(INetworkManager networkManager) : super(networkManager);

  @override
  Future<IResponseModel<TokenModel?>?> login(LoginModel model) async {
    return await networkManager.send<TokenModel, TokenModel>(_loginPath, parseModel: TokenModel(), method: RequestType.POST, data: model);
  }
}
