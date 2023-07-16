import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/data/wishlist_items.dart';
import 'package:shopping_app/features/wishlist/bloc/wishlist_event.dart';
import 'package:shopping_app/features/wishlist/bloc/wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<WishlistInitialEvent>(wishlistInitialEvent);
    on<WishlistRemoveFromWishlistEvent>(wishlistRemoveFromWishlistEvent);
  }

  FutureOr<void> wishlistInitialEvent(
      WishlistInitialEvent event, Emitter emit) {
    emit(WishlistSuccessState(wishListItems: wishListItems));
  }

  FutureOr<void> wishlistRemoveFromWishlistEvent(
      WishlistRemoveFromWishlistEvent event, Emitter emit) {
    wishListItems.remove(event.productDataModel);
    emit(WishlistSuccessState(wishListItems: wishListItems));
  }
}
