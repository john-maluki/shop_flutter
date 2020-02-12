import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';

import '../providers/cart.dart';
import '../widgets/badge.dart';
import '../widgets/products_grid.dart';
import './cart_screen.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScren extends StatefulWidget {
  @override
  _ProductsOverviewScrenState createState() => _ProductsOverviewScrenState();
}

class _ProductsOverviewScrenState extends State<ProductsOverviewScren> {
  var _showFavoriteOnly = false;
  @override
  Widget build(BuildContext context) {
    // final productContainer = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: <Widget>[
          Consumer<Cart>(
            builder: (_, cart, ch) {
              return Badge(child: ch, value: cart.itemCount.toString());
            },
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
              icon: Icon(Icons.shopping_cart),
            ),
          ),
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  // productContainer.showFavoriteOnly();
                  _showFavoriteOnly = true;
                } else {
                  // productContainer.showAll();
                  _showFavoriteOnly = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorite'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show all'),
                value: FilterOptions.All,
              )
            ],
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: ProductGrid(_showFavoriteOnly),
    );
  }
}
