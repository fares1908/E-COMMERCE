import 'package:ShopApp/Lay_out/Cubit/cubit.dart';
import 'package:ShopApp/Lay_out/Cubit/states.dart';
import 'package:ShopApp/Lay_out/home_layout.dart';
import 'package:ShopApp/Shareing/constant/constant.dart';
import 'package:ShopApp/moduls/Login/Login_Screen.dart';
import 'package:ShopApp/moduls/Login/cubit/cubit.dart';
import 'package:ShopApp/moduls/OnBoarding.dart';
import 'package:ShopApp/network/bloc_observer.dart';
import 'package:ShopApp/network/dio_helper.dart';
import 'package:ShopApp/network/network.local.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  Dio_Helper.init();
  await CashHelper.init();
  Widget ? widget;
  bool ? onBoarding = CashHelper.getData(key: 'onBoarding');
  print(onBoarding);
   token = CashHelper.getData(key: 'token');
  print(token);
  if (onBoarding != null) {
    if(token!=null){
      widget=Home_Layout();
    }else{
      widget=LoginScreen();
    }
  }else{
    widget=onBoardingScreen();
  }
  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  // final bool  onBoarding;
  final Widget startWidget;

  MyApp(
      {
      // required this.onBoarding,
      required this.startWidget});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
        create: (context) => ShopCubit()
          ..getHome()
          ..getCategory()
          ..getFavorite()
          ..getCart()
          ..getUser()
          ..getProductDetailsModel()

          , //عشان اول ما اخش استدعي الموديل ده
        ),
        BlocProvider(
          create: (context) =>ShopLoginCubit()

          , //عشان اول ما اخش استدعي الموديل ده
        ),

      ],
      child: BlocConsumer<ShopCubit,ShopStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          return MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.blueGrey,

              scaffoldBackgroundColor: Colors.white,

              appBarTheme: AppBarTheme(

                iconTheme: IconThemeData(
                    color: Colors.white
                ),
                titleTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 22.0,
                ),
                systemOverlayStyle:SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness:Brightness.dark,

                ),
                elevation: 0,
                color: Colors.white,
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
              ),
            ),
            themeMode: ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: startWidget,
          );
        },

      ),
    );
  }
}
