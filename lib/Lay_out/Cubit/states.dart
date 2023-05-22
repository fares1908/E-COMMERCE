import 'package:ShopApp/models/LoginModel.dart';
import 'package:ShopApp/models/getUser.dart';

abstract class ShopStates{}
class ShopInitialState extends ShopStates{}
class ShopChangeBottomNavState extends ShopStates{}
class ShopLoadingHomeDataState extends ShopStates{}
class ShopSuccessHomeDataState extends ShopStates{}
class ShopErrorHomeDataState extends ShopStates{}
class ShopLoadingCategoryDataState extends ShopStates{}
class ShopSuccessCategoryState extends ShopStates{}
class ShopErrorCategoryDataState extends ShopStates{}
class ShopLoadingDetailsState extends ShopStates{}
class ShopSuccessDetailsState extends ShopStates{}
class ShopErrorDetailsState extends ShopStates{

}
class ShopOnPageChangeState extends ShopStates{}
class ShopLoadingCartState extends ShopStates{}
class ShopSuccessCartState extends ShopStates{}
class ShopErrorCartState extends ShopStates{

}
class ShopLoadingRemoveOrAddCartState extends ShopStates{}
class ShopSuccessRemoveOrAddCartState extends ShopStates{}
class ShopErrorRemoveOrAddCartState extends ShopStates{

}
class CounterMinusState extends ShopStates{}
class CounterPlusState extends ShopStates{}
class ShopLoadingUpdateCartState extends ShopStates{}
class ShopSuccessUpdateCartState extends ShopStates{}
class ShopErrorUpdateCartState extends ShopStates{

}

class ShopOnPageChangeFavoriteState extends ShopStates{}
class ShopLoadingFavoriteState extends ShopStates{}
class ShopSuccessFavoriteState extends ShopStates{}
class ShopErrorFavoriteState extends ShopStates{}
class ShopLoadingRemoveOrAddFavoriteState extends ShopStates{}
class ShopSuccessRemoveOrAddFavoriteState extends ShopStates{}
class ShopErrorRemoveOrAddFavoriteState extends ShopStates{

}
class ShopLoadingGetUserState extends ShopStates{}
class ShopSuccessGetUserState extends ShopStates{}
class ShopErrorGetUserState extends ShopStates{

}
class ShopLoadingUpdateUserState extends ShopStates{}
class ShopSuccessUpdateUserState extends ShopStates{
  final GetUserModel model;
  ShopSuccessUpdateUserState(this.model);
}
class ShopErrorUpdateUserState extends ShopStates{

}
class ShopLoadingSearchState extends ShopStates{}
class ShopSuccessSearchState extends ShopStates{}
class ShopErrorSearchState extends ShopStates{

}
class ChangeColorState extends ShopStates{}