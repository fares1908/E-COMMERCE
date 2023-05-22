import 'package:ShopApp/Lay_out/Cubit/cubit.dart';
import 'package:ShopApp/Lay_out/Cubit/states.dart';
import 'package:ShopApp/Shareing/Compounant/compunant.dart';
import 'package:ShopApp/models/LoginModel.dart';
import 'package:ShopApp/moduls/SearchScreen.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Home_Layout extends StatefulWidget {
  const Home_Layout({Key? key}) : super(key: key);

  @override

  State<Home_Layout> createState() => _Home_LayoutState();
}


class _Home_LayoutState extends State<Home_Layout> {
  @override
  void initState(){
    BlocProvider.of<ShopCubit>(context).getUser();
    BlocProvider.of<ShopCubit>(context).getCart();
    BlocProvider.of<ShopCubit>(context).getFavorite();
  }
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(

      listener: (context, state) {

      },
      builder: (context, state) {
        var cubit=ShopCubit.get(context);
        ShopLoginModel ? loginModel;
        return   Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            title: Text(
              'WELCOME ${cubit.getUserModel?.data.name?.toUpperCase()}',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14
              ),
            ),
            actions: [
              IconButton(
                  onPressed: (){
                    navigateTo(context, SearchScreen ());
                  },
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                  )
              ),
            ],
            elevation: 0,
          ),
          body:ShopCubit.get(context).screens[cubit.currentIndex],
          bottomNavigationBar: Container(
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 20,
              ),
              child: GNav(
                backgroundColor: Colors.black,
                color: Colors.white,
                activeColor: Colors.orangeAccent,
                tabBackgroundColor: Colors.grey.shade800,
                gap: 8,

                onTabChange: (index) {
                  cubit.changeScreen(index);
                },

                padding: EdgeInsets.all(20),

                tabs: [
                  GButton(
                    icon: Icons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.favorite,
                    text: 'Favorite',
                  ),

                  GButton(
                    icon: Icons.shopping_cart,
                    text: 'Cart',
                  ),

                  GButton(
                    icon: Icons.person,
                    text: 'User',
                  ),
                ],
              ),
            ),
          ),
        );
      },

      );
  }
}


