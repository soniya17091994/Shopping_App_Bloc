import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/features/home/bloc/home_bloc.dart';
import 'package:shopping_app/features/home/bloc/home_event.dart';
import 'package:shopping_app/features/home/bloc/home_state.dart';
import 'package:shopping_app/features/home/ui/product_tile_widget.dart';
import 'package:shopping_app/features/wishlist/ui/wishlist_page.dart';
import '../../cart/ui/cart_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
        bloc: homeBloc,
        listenWhen: (previous, current) => current is HomeActionState,
        buildWhen: (previous, current) => current is! HomeActionState,
        builder: (context, state) {
          switch (state.runtimeType) {
            case HomeLoadingState:
              return Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            case HomeLoadedSuccessState:
              final successState = state as HomeLoadedSuccessState;
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.teal,
                  title: const Text('Grocery App'),
                  actions: [
                    IconButton(
                        onPressed: () {
                          homeBloc.add(HomeWishListButtonNavigateEvent());
                        },
                        icon: Icon(Icons.favorite_border)),
                    IconButton(
                        onPressed: () {
                          homeBloc.add(HomeCartButtonNavigateEvent());
                        },
                        icon: Icon(Icons.shopping_bag_outlined))
                  ],
                ),
                body: ListView.builder(
                  itemCount: successState.products.length,
                  itemBuilder: (context, index) {
                    return ProductTileWidget(
                      homeBloc: homeBloc,
                        productDataModel: successState.products[index]);
                  },
                ),
              );
            case HomeErrorState:
              return const Scaffold(
                body: Center(child: Text('Error')),
              );
            default:
              return const SizedBox();
          }
        },
        listener: (context, state) {
          if (state is HomeNavigateToCartPageActionState) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const CartPage()));
          } else if (state is HomeNavigateToWishlistPageActionState) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const WishlistPage()));
          } else if (state is HomeProductItemCartedActionState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Item Carted')));
          } else if (state is HomeProductItemWishListedActionState){
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Item Wishlisted')));
          }
        });
  }
}
