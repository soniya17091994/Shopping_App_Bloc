import 'package:shopping_app/features/home/models/home_product_data_model.dart';
abstract class CartState {}

abstract class CartActionState extends CartState {}

class CartInitial extends CartState {}

class CartSuccessState extends CartState {
  final List<ProductDataModel> cartItems;
  CartSuccessState({required this.cartItems});
}

class CartRemovedActionState extends CartActionState{}