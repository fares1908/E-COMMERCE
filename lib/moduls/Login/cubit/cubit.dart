import 'package:ShopApp/Lay_out/Cubit/cubit.dart';
import 'package:ShopApp/Shareing/constant/constant.dart';
import 'package:ShopApp/models/LoginModel.dart';
import 'package:ShopApp/moduls/Login/cubit/states.dart';
import 'package:ShopApp/network/dio_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../network/end_points.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());
  static ShopLoginCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? loginModel;
  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());
    Dio_Helper.postData(url: LOGIN, data: {
      'email': email,
      'password': password,
      'token': token,
    }).then((value) {
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);

      print(loginModel!.data!.image);
      emit(ShopLoginSuccessState(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  void userRegister({
    required String email,
    required String name,
    required String password,
    required String phone,
  }) {
    Dio_Helper.postData(url: REGISTER, data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone
    }).then((value) {
      print(value.data);
      loginModel=ShopLoginModel.fromJson(value.data);
     emit(ShopRegisterSuccessState(loginModel!));
    }).catchError((error){
        emit(ShopRegisterErrorState(error.toString()));
    });
  }
}
