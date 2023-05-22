import 'package:ShopApp/Shareing/constant/constant.dart';
import 'package:ShopApp/models/AddOrRemoveCart.dart';
import 'package:ShopApp/models/CartModel.dart';
import 'package:ShopApp/models/CartModelUpdate.dart';
import 'package:ShopApp/models/CategoryModel.dart';
import 'package:ShopApp/models/DetielsModel.dart';
import 'package:ShopApp/models/FavoriteModel.dart';
import 'package:ShopApp/models/Home_Model.dart';
import 'package:ShopApp/models/LoginModel.dart';
import 'package:ShopApp/models/SearchModel.dart';
import 'package:ShopApp/models/UpdateFavorite.dart';
import 'package:ShopApp/models/UpdateUserModel.dart';
import 'package:ShopApp/models/getUser.dart';
import 'package:ShopApp/moduls/CartScreen.dart';
import 'package:ShopApp/moduls/Favorite.dart';
import 'package:ShopApp/moduls/UserScreen.dart';
import 'package:ShopApp/moduls/home_screen.dart';
import 'package:ShopApp/network/dio_helper.dart';
import 'package:ShopApp/network/end_points.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Shareing/Compounant/compunant.dart';
import 'states.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);
  List<Widget> screens = [
    HomeScreen(),
    FavoriteScreen(),
    CartScreen(),
    UserScreen()
  ];
  CategoriesModel? categoryModel;
  dynamic currentIndex = 0;

  void changeScreen(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;

  void getHome() {
    emit(ShopLoadingHomeDataState());
    Dio_Helper.getData(
      url: HOME,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      printFullText(homeModel!.data!.banners[0].image);
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  void getCategory() {
    emit(ShopLoadingCategoryDataState());
    Dio_Helper.getData(url: SET_CATEGORY).then((value) {
      categoryModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoryState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoryDataState());
    });
  }

  // ProductDetailsModel? productDetailsModel;
  // void getProductDetailsData() {
  //   emit(ShopLoadingDetailsState());
  //   Dio_Helper.getData(url: PRODUCT, token: token).then((value) {
  //     productDetailsModel = ProductDetailsModel.fromJson(value.data);
  //     print(value.data.toString());
  //     print(productDetailsModel!.data!.data![1].name);
  //
  //     emit(ShopSuccessDetailsState());
  //   }).catchError((onError) {
  //     emit(ShopErrorDetailsState());
  //     print(onError.toString());
  //   });
  // }
  ProductDetailsModel ? productDetailsModel;

   getProductDetailsModel({
    int? id,
  }) async{
    emit(ShopLoadingDetailsState());

    Dio_Helper.getData(
      url: 'products/$id',
      token: token,
    ).then((value) async{
      productDetailsModel = await ProductDetailsModel.fromJson(value.data);
      emit(ShopSuccessDetailsState());
      print(productDetailsModel?.productData?.id);
    }).catchError((error) {
      emit(ShopErrorDetailsState());
      print(error.toString());
    });
  }

  int activeIndex = 0;

  void onPageChange(int index) {
    activeIndex = index;
    emit(ShopOnPageChangeState());
  }

  CartModel? cartModel;

  Future<void> getCart() async {
    emit(ShopLoadingCartState());
    Dio_Helper.getData(
      url: Cart,
      token: token,
    ).then((value) {
      cartModel = CartModel.fromJson(value.data);
      emit(ShopSuccessCartState());
    }).catchError((error) {
      emit(ShopErrorCartState());
      print(error.toString());
    });
  }

  Map<int, bool> carts = {};
  ChangeCartsModel? changeCartsModel;

  void changCart(
  { int? productId}) {
    carts[productId] != carts[productId];
    emit(ShopLoadingRemoveOrAddCartState());
    Dio_Helper.postData(
      url: Cart,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeCartsModel = ChangeCartsModel.fromJson(value.data);
      if (!changeCartsModel!.status!) {
        //معناها ان الاستيتس بفولس  يعني هيكون المنتج في ال كارت عادي
        carts[productId] != carts[productId];
      } else {
        // معناها ان الاستيتس ب ترو يعني المنتج لسه مرحش ال الكارت هدوس هيروح وهيبقي ب تروو
        getCart();
      }
      showToast(
        text: '${changeCartsModel!.message}',
        state: ToastState.Success,
      );
      emit(ShopSuccessRemoveOrAddCartState());
    }).catchError((error) {
      emit(ShopErrorRemoveOrAddCartState());
      print(error.toString());
    });
  }

  late UpdateCartModel updateCartModel;
  void updateCart(int? cartId, int? quantity) {
    emit(ShopLoadingUpdateCartState());
    Dio_Helper.putData(
      url: 'carts/$cartId',
      data: {
        'quantity': quantity,
      },
      token: token,
    ).then((value) {
      updateCartModel = UpdateCartModel.fromJson(value.data);
      if (updateCartModel.status)
        getCart();
      else
        showToast(
            state: ToastState.Success,
            text: 'Update Cart ' + updateCartModel.status.toString());
      emit(ShopSuccessUpdateCartState());
    }).catchError((error) {
      emit(ShopErrorUpdateCartState());
      print(error.toString());
    });
  }

  ////////////////////////////////////Favorite//////////////
  FavoriteModel? favoriteModel;
  void getFavorite() {
    emit(ShopLoadingFavoriteState());
    Dio_Helper.getData(
      url: FAVORITE,
      token: token,
    ).then((value) {
      favoriteModel = FavoriteModel.fromJson(value.data);
      emit(ShopSuccessFavoriteState());
    }).catchError((error) {
      emit(ShopErrorFavoriteState());
      print(error.toString());
    });
  }

  Map<int, bool> favorites =
      {}; //ماب بتاخد بولين و اينت لو ال الاي دي فافوريت يبقي  ترو ايلس يبقي فولس
  UpdateFavoriteModel? updateFavoriteModel;

  void changFavorite( {
    int? productId
}) {
    favorites[productId] != favorites[productId];
    emit(ShopLoadingRemoveOrAddFavoriteState());
    Dio_Helper.postData(
      url: FAVORITE,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      updateFavoriteModel = UpdateFavoriteModel.fromJson(value.data);
      if (!updateFavoriteModel!.status!) {
        //معناها ان الاستيتس بفولس  يعني هيكون المنتج في ال كارت عادي
        favorites[productId] != favorites[productId]!;
      } else {
        // معناها ان الاستيتس ب ترو يعني المنتج لسه مرحش ال الكارت هدوس هيروح وهيبقي ب تروو
        getFavorite();
      }
      showToast(
        text: '${updateFavoriteModel!.message}',
        state: ToastState.Success,
      );
      emit(ShopSuccessRemoveOrAddFavoriteState());
    }).catchError((error) {
      emit(ShopErrorRemoveOrAddFavoriteState());
      print(error.toString());
    });
  }

  GetUserModel? getUserModel;
  void getUser() {
    emit(ShopLoadingGetUserState());
    Dio_Helper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      getUserModel = GetUserModel.fromJson(value.data);
      printFullText(getUserModel!.data.name!);
      emit(ShopSuccessGetUserState());
    }).catchError((error) {
      emit(ShopErrorGetUserState());
      print(error.toString());
    });
  }

  // UpdateUserModel ? updateUserModel;
  void updateUser({
    required String nameUser,
    required String emailUser,
    required String phoneUser,
  }) {
    emit(ShopLoadingUpdateUserState());
    Dio_Helper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': nameUser,
        'email': emailUser,
        'phone': phoneUser,
      },
    ).then((value) {
      emit(ShopSuccessUpdateUserState(getUserModel!));
      getUserModel = GetUserModel.fromJson(value.data);
      print('update done');
    }).catchError((error) {
      emit(ShopErrorUpdateUserState());
      print(error.toString());
    });
  }

  SearchModel? searchModel;
  void SearchProduct({
    required String text,
  }) {
    emit(ShopLoadingSearchState());
    Dio_Helper.postData(
      url: SEARCH,
      data: {'text': text},
      token: token,
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(ShopSuccessSearchState());
    }).catchError((error) {
      emit(ShopErrorSearchState ());
      print(error.toString());
    });
  }
  // bool isFav = true;
  // Color theColor = Colors.grey;

  // void changeColor(
  //   int productId
  // ) {
  //   isFav = !isFav;
  //   if (isFav) {
  //     theColor = Colors.grey;
  //   } else {
  //     theColor = Colors.orange;
  //   }
  //   emit(ChangeColorState());
  // }
}
