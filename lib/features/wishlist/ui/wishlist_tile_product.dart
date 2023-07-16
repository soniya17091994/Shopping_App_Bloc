import 'package:flutter/material.dart';
import 'package:shopping_app/features/home/models/home_product_data_model.dart';
import 'package:shopping_app/features/wishlist/bloc/wishlist_bloc.dart';
import 'package:shopping_app/features/wishlist/bloc/wishlist_event.dart';

class WishlistTileWidget extends StatelessWidget {
  final ProductDataModel productDataModel;
  final WishlistBloc wishlistBloc;
  const WishlistTileWidget({super.key, required this.productDataModel, required this.wishlistBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          height: 200,
          width: double.maxFinite,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(productDataModel.imageUrl),
                  fit: BoxFit.cover)),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          productDataModel.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Text(productDataModel.description),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '\$ ${productDataModel.price.toString()}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      wishlistBloc.add(WishlistRemoveFromWishlistEvent(
                          productDataModel: productDataModel));
                    }, icon: const Icon(Icons.favorite, color: Colors.red,)),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.shopping_bag))
              ],
            )
          ],
        ),
      ]),
    );
  }
}
