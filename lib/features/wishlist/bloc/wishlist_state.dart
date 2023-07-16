import 'package:shopping_app/features/home/models/home_product_data_model.dart';

abstract class WishlistState {}

abstract class WishListActionState {}

class WishlistInitial extends WishlistState {}

class WishlistSuccessState extends WishlistState {
  final List<ProductDataModel> wishListItems;
  WishlistSuccessState({required this.wishListItems});
}
class WishlistRemovedActionState extends WishListActionState{}