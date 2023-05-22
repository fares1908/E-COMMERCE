import 'package:ShopApp/Lay_out/Cubit/cubit.dart';
import 'package:ShopApp/Lay_out/Cubit/states.dart';
import 'package:ShopApp/Lay_out/home_layout.dart';
import 'package:ShopApp/Shareing/Compounant/compunant.dart';
import 'package:ShopApp/models/CategoryModel.dart';
import 'package:ShopApp/models/Home_Model.dart';
import 'package:ShopApp/moduls/CategoryScreen.dart';
import 'package:ShopApp/moduls/Detiels_product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null &&
              ShopCubit.get(context).categoryModel != null,
          fallback: (context) => const Center(
              child: CircularProgressIndicator(
            color: Colors.orangeAccent,
            // strokeWidth: 3,
          )),
          builder: (context) => productBuilder(ShopCubit.get(context).homeModel,
              ShopCubit.get(context).categoryModel, context),
        );
      },
    );
  }
}

Widget productBuilder(
        HomeModel? model, CategoriesModel? categoriesModel, context) =>
    SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SPECIAL OFFERS',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              CarouselSlider.builder(
                itemCount:
                    ShopCubit.get(context).homeModel?.data?.banners.length,
                itemBuilder: (context, index, n) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    child: CachedNetworkImage(
                      imageUrl: ShopCubit.get(context)
                          .homeModel!
                          .data!
                          .banners[index]
                          .image,
                      fit: BoxFit.cover,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                        child: CircularProgressIndicator(
                          color: Colors.orangeAccent,
                          value: downloadProgress.progress,
                          strokeWidth: 4,
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(
                        Icons.error,
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  onPageChanged: (index, reason) {
                    ShopCubit.get(context).onPageChange(index);
                  },
                  height: MediaQuery.of(context).size.height / 2.5,
                  viewportFraction: 8,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                ),
              ),
              // SizedBox(
              //   height: 20,
              // ),
              // Row(
              //   children: [
              //     Text(
              //       'Latest Product',
              //       style: TextStyle(
              //           fontWeight: FontWeight.bold, color: Colors.black),
              //     ),
              //     // Spacer(),
              //     // MaterialButton(
              //     //   onPressed: () {},
              //     //   child: Text(
              //     //     'View All',
              //     //     style: TextStyle(
              //     //         fontWeight: FontWeight.w400,
              //     //         color: Colors.orangeAccent,
              //     //         decoration: TextDecoration.underline),
              //     //   ),
              //     // ),
              //   ],
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              //  Container(
              //    height: 100,
              //    child: ListView.separated(
              //
              //      scrollDirection: Axis.horizontal,
              //        // shrinkWrap: true,
              //        physics: BouncingScrollPhysics(),
              //        itemBuilder: (context, index) => buildProductItem(model!.data?.products[index],categoriesModel, context),
              //        separatorBuilder: (context, index) => SizedBox(
              //          width: 10,
              //        ),
              //        itemCount: 2,
              //
              //    ),
              //  ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  Spacer(),
                  MaterialButton(
                    onPressed: () {
                      navigateTo(context, CategoryScreen());
                    },
                    child: Text(
                      'View All',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.orangeAccent,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 70,
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => buildCategoryItem(
                      ShopCubit.get(context).categoryModel?.data.data[index]),
                  separatorBuilder: (context, index) => SizedBox(
                    width: 13,
                  ),
                  itemCount:
                      ShopCubit.get(context).categoryModel!.data.data.length,
                ),
              ),
              SizedBox(
                height: 10,
              ),

              Text(
                'All Product',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),

              SizedBox(
                height: 15,
              ),

              BuildMostPopular(ShopCubit.get(context).homeModel, context)
            ],
          ),
        ),
      ),
    );
Widget buildProductItem(
        ProductsModel? model, CategoriesModel? categoriesModel, context) =>
    Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.orangeAccent),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        image: DecorationImage(
          image: NetworkImage('${model?.image}'),
          fit: BoxFit.cover,
        ),
      ),
    );

Widget buildGridView(ProductsModel? model, context) => Container(
      color: Colors.white,
      child: Image(
        image: NetworkImage('${model?.image}'),
        // width: double.infinity,
        height: 30,
      ),
    );

Widget buildCategoryItem(DataModel? model) => Container(
      width: 100,
      child: Center(
        child: Text(
          textAlign: TextAlign.center,
          '${model!.name.toUpperCase()}',
          maxLines: 2,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.black54,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          color: Colors.orange.withOpacity(.2)),
    );
Widget BuildMostPopular(HomeModel? model, context) {
  return StaggeredGridView.countBuilder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    padding: EdgeInsets.symmetric(vertical: 15),
    crossAxisCount: 2,
    crossAxisSpacing: 10.0,
    mainAxisSpacing: 10.0,
    itemCount: model!.data!.products.length,
    staggeredTileBuilder: (index) {
      return StaggeredTile.count(1, index.isEven ? 1.8 : 1.4);
    },
    itemBuilder: (context, index) => InkWell(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.grey[300]),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: '${model.data!.products[index].image}',
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(
                        color: Colors.orangeAccent,
                        strokeWidth: 1.5,
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(
                      Icons.error,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  '${model.data?.products[index].name?.toUpperCase()}',
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      ' ${model.data!.products[index].price} EGP',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orangeAccent,
                          fontSize: 17),
                    ),
                  ),
                  if (model.data!.products[index].discount != 0)
                      Text(
                        ' ${model.data!.products[index].oldPrice} EGP',

                        // maxLines: 6,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.orangeAccent,
                            decoration: TextDecoration.lineThrough,
                            fontSize: 10),
                      ),
                ],
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        ShopCubit cubit = ShopCubit.get(context);
        ShopCubit.get(context).getProductDetailsModel(
            id: ShopCubit.get(context).homeModel?.data?.products[index].id
                as int);
        navigateTo(context, ProductDetails());
      },
    ),
  );
}
