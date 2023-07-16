import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/features/wishlist/bloc/wishlist_event.dart';
import 'package:shopping_app/features/wishlist/ui/wishlist_tile_product.dart';
import '../bloc/wishlist_bloc.dart';
import '../bloc/wishlist_state.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  void initState() {
    wishlistBloc.add(WishlistInitialEvent());
    super.initState();
  }

  final WishlistBloc wishlistBloc = WishlistBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist Items'),
      ),
      body: BlocConsumer<WishlistBloc, WishlistState>(
          bloc: wishlistBloc,
          listener: (context, state) {},
          listenWhen: (previous, current) => current is WishListActionState,
          buildWhen: (previous, current) => current is! WishListActionState,
          builder: (context, state) {
            if(state is WishlistSuccessState) {
              return ListView.builder(
                  itemBuilder: (context, index) {
                    return WishlistTileWidget(
                      wishlistBloc: wishlistBloc,
                      productDataModel: state.wishListItems[index],
                    );
                  },
                  itemCount: state.wishListItems.length,
                );
            }
            return Container();
          }),
    );
  }
}
