class FavoriteModel {
  bool? status;
  Data? data;


  FavoriteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = (json['data'] != null ? Data.fromJson(json['data']) : null)!;
  }

}

class Data {
  int? currentPage;
  List< FavouriteItems> data=[];
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? path;
  int? perPage;
  int? to;
  int? total;


  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    // if (json['data'] != null) {
    //   data = < FavouriteItems>[];
      json['data'].forEach((v) {
        data.add(FavouriteItems.fromJson(v));
      });
    // }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

}

class FavouriteItems {
  int? id;
  Product? product;

  FavouriteItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
    (json['product'] != null ? Product.fromJson(json['product']) : null)!;
  }
}

class Product {
 dynamic id;
 dynamic price;
 dynamic oldPrice;
 dynamic discount;
 late String? image;
 late String? name;
 late String? description;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
