import 'package:eoapp/ui/shared/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// A page for sellers to manage and get an overview of all product listings
/// they have made on the platform
class SellerDashboard extends StatefulWidget {

  /// cards representing due product listings
  List<SellScrProductCard> dueCards;
  /// cards representing active product listings
  List<SellScrProductCard> activeCards;
  /// cards representing ended product listings
  List<SellScrProductCard> endedCards;
  
  SellerDashboard(this.dueCards, this.activeCards, this.endedCards);

  @override
  _SellerDashboard createState() => _SellerDashboard();

}

class _SellerDashboard extends State<SellerDashboard> {

  Widget _postProductButton() {

    return Padding(
      padding: EdgeInsets.all(10),
      child: ElevatedButton(
          onPressed: () {},
          child: Row(
            children: [
              Padding(
                  padding: EdgeInsets.only(right:5),
                  child: const Icon(Icons.add_circle_outline)
              ),
              Text("Post a product")
            ],
          )
      )
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Seller Dashboard")),
        body: SingleChildScrollView(
            child: Column(
              children: [
                this._postProductButton(),
                ProductCardGroup("Due Now", this.widget.dueCards),
                ProductCardGroup("Active", this.widget.activeCards),
                ProductCardGroup("Ended", this.widget.endedCards),
              ],
              crossAxisAlignment: CrossAxisAlignment.end,
            )
        )
    );
  }

}