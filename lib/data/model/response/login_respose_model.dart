class LoginResponseModel {
  bool? _isSuccess;
  String? _message;
  bool? _signup;
  LoginResponseModel(this._isSuccess, this._message,this._signup);

  String? get message => _message;
  bool? get isSuccess => _isSuccess;
  bool? get signup => _signup;
}