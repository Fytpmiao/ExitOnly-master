import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'number_selector.dart';


abstract class ProductCard {

  static Text _pricePerUnit(num price, String unit) {
    return Text(
        "${NumberFormat.simpleCurrency(locale: 'en-AU').
        format(price)}/${unit}"
    );
  }

  static Text _title(title) {
    return Text(title, style: TextStyle(fontWeight: FontWeight.bold));
  }

  static Row _authorNameAndImage(double width, double height, String author,
      ImageProvider authorImage) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 2),
          child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: authorImage
                  )
              )
          ),
        ),
        Text(author)
      ],
    );
  }

  static AspectRatio _productImage(ImageProvider productImage) {
    return new AspectRatio(
      aspectRatio: 4 / 3,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: productImage
          )
        ),
      )
    );
  }

  static Column _availableDate(availableDate) {
    return Column(
      children: [
        Text("Available:", style: TextStyle(fontWeight: FontWeight.bold)),
        Text(availableDate)
      ],
    );
  }

  static Expanded _productDetails(int flex, List<Widget> children) {
    return Expanded(
        flex: flex,
        child: Padding(
            padding: EdgeInsets.all(5),
            child: Column(
              children: children,
            )
        )
    );
  }

  static Expanded _productImageExpPad(int flex, ImageProvider productImage) {
    return Expanded(
        flex: flex,
        child: Padding(
            padding: EdgeInsets.all(5),
            child: ProductCard._productImage(productImage)
        )
    );
  }
}

class BuyScrProductCard extends StatelessWidget {

  final ImageProvider productImage;
  final String title;
  final num price;
  final String unit;
  final String author;
  final ImageProvider authorImage;
  final String availableDate;

  BuyScrProductCard(this.productImage, this.title, this.price, this.unit,
      this.author, this.authorImage, this.availableDate);

  Row _rowI(BuildContext context) {
    return Row (
      children: [
        Expanded(
          flex: 6,
          child: Column(
            children: [
              ProductCard._title(this.title),
              ProductCard._pricePerUnit(this.price, this.unit),
              ProductCard._authorNameAndImage(
                MediaQuery.of(context).size.width * 0.05,
                MediaQuery.of(context).size.width * 0.05,
                this.author, this.authorImage
              )
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ),
        Expanded(
            flex: 4,
            child: ProductCard._availableDate(this.availableDate)
        )
      ],
    );
  }
  
  Row _rowII() {
    return Row(
      children: [
        IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add_shopping_cart),
        )
      ],
      mainAxisAlignment: MainAxisAlignment.end,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Row(
            children: [
              ProductCard._productImageExpPad(1, this.productImage),
              ProductCard._productDetails(2,
                  [this._rowI(context), this._rowII()])
            ]
        )
    );
  }

}

class SellScrProductCard extends StatelessWidget {

  static const int due = 0;
  static const int active = 1;
  static const int ended = 2;

  final ImageProvider productImage;
  final String title;
  final num price;
  final String unit;
  final ImageProvider authorImage;
  final String availableDate;
  final int listingStatus;
  final num quantity;

  SellScrProductCard(this.productImage, this.title, this.price,
      this.unit, this.authorImage, this.availableDate, this.listingStatus,
      this.quantity);

  String _rowIiStatistic() {
    switch (this.listingStatus) {
      case due:
        return "Total Due";
      case active:
        return "Current Pre-orders";
      case ended:
        return "Total Sales";
      default:
        throw Exception("Undefined listing status");
    }
  }

  Row _rowI() {
    return Row (
      children: [
        Expanded(
          flex: 6,
          child: Column(
            children: [
              ProductCard._title(this.title),
              ProductCard._pricePerUnit(this.price, this.unit)
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ),
        Expanded(
            flex: 4,
            child: ProductCard._availableDate(this.availableDate)
        )
      ],
    );
  }

  Padding _rowII() {
    return Padding(
      padding: EdgeInsets.only(top: 5),
      child: Row(
        children: [
          Text(
              "${this._rowIiStatistic()}: ",
              style: TextStyle(fontWeight: FontWeight.bold)
          ),
          Text("${this.quantity}${this.unit}")
        ],
      )
    );
  }

  Row _rowIII(context) {
    return Row (
      children: [
        Expanded(
          flex: 4,
          child: ProductCard._authorNameAndImage(
            MediaQuery.of(context).size.width * 0.05,
            MediaQuery.of(context).size.width * 0.05,
            "You", this.authorImage
          )
        ),
        Expanded(
            flex: 6,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.delete)
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit)
                )
              ],
              mainAxisAlignment: MainAxisAlignment.end,
            )
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Row(
            children: [
              ProductCard._productImageExpPad(1, this.productImage),
              ProductCard._productDetails(2,
                  [this._rowI(), this._rowII(), this._rowIII(context)]
              )
            ]
        )
    );
  }

}

class CartProductCard extends StatefulWidget {

  final ImageProvider productImage;
  final String title;
  final num price;
  final String unit;
  final String author;
  final ImageProvider authorImage;
  final String availableDate;
  List<String> distributionCentres;

  String dropdownValue = "defaultItem";

  CartProductCard(this.productImage, this.title, this.price, this.unit,
      this.author, this.authorImage, this.availableDate,
      this.distributionCentres);

  _CartProductCard createState() => _CartProductCard();
}

class _CartProductCard extends State<CartProductCard> {

  Expanded _deleteButtonExp() {
    return Expanded(
        flex: 1,
        child: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {},
        )
    );
  }

  Row _rowI(context) {
    return Row (
      children: [
        Expanded(
          flex: 1,
          child: ProductCard._title(this.widget.title)
        ),
        Expanded(
            flex: 1,
            child: ProductCard._authorNameAndImage(
                MediaQuery.of(context).size.width * 0.05,
                MediaQuery.of(context).size.width * 0.05,
                this.widget.author, this.widget.authorImage)
        )
      ],
    );
  }

  Row _rowII() {
    return Row (
      children: [
        // Expanded(
        //     flex: 6,
        //     child: NumberSelector(this.widget.unit)
        // ),
        Expanded(
            flex: 4,
            child: ProductCard._pricePerUnit(this.widget.price,
                this.widget.unit)
        )
      ],
    );
  }

  Row _rowIII() {
    DropdownMenuItem<String> defaultItem = DropdownMenuItem(
        value: "defaultItem",
        child: Text("Select distribution centre")
    );

    List<DropdownMenuItem<String>> dropdownItems = [defaultItem];
    for (String distributionCentre in this.widget.distributionCentres) {
      dropdownItems.add(
        DropdownMenuItem(
            value: distributionCentre,
            child: Text(distributionCentre)
        )
      );
    }

    return Row (
      children: [
        DropdownButton(
          value: this.widget.dropdownValue,
          items: dropdownItems,
          onChanged: (String? s) {this.setState(() {
            this.widget.dropdownValue = s!;
          });},
        )
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Row(
            children: [
              this._deleteButtonExp(),
              ProductCard._productImageExpPad(2, this.widget.productImage),
              ProductCard._productDetails(6,
                  [this._rowI(context), this._rowII(), this._rowIII()]
              )
            ]
        )
    );
  }

}

class ProductDetailsCard extends StatelessWidget {

  final String title;
  final num price;
  final String unit;
  final String availableDate;

  ProductDetailsCard(this.title, this.price, this.unit, this.availableDate);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          ProductCard._productDetails(1, [ProductCard._title(title), ProductCard._pricePerUnit(price, unit)]),
          ProductCard._productDetails(1, [ProductCard._availableDate(availableDate)])
        ],
      )
    );
  }

}

/// A collection of product cards under a heading
class ProductCardGroup extends StatefulWidget {

  /// the title of this card group
  String title;
  /// cards in this group
  List<Widget> cards;

  ProductCardGroup(this.title, this.cards);

  @override
  _ProductCardGroup createState() => _ProductCardGroup();
}

class _ProductCardGroup extends State<ProductCardGroup> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
              this.widget.title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24
              )
          ),
        ),
        Column(children: this.widget.cards,)
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }

}