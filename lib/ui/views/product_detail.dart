import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eoapp/ui/shared/globals.dart';
import 'package:eoapp/ui/shared/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'confirm_order.dart';

class ProductDetail extends StatefulWidget {
  final QueryDocumentSnapshot data;

  ProductDetail({required this.data});

  @override
   createState() => _ProductDetail();
}

class _ProductDetail extends State<ProductDetail>{
  late GoogleMapController mapController;
  Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId('id-1'),
        position: LatLng(widget.data['farmLocation'].latitude, widget.data['farmLocation'].longitude),
        infoWindow: InfoWindow(
          title: 'Farm Location'
        )
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Global.lightGrey,
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.width*0.5,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  background: Image.network(
                    widget.data['productImage'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ];
          },
          body:SingleChildScrollView(
                    child:Column(
                      children: [
                        Container(
                        color: Global.white,
                        width:MediaQuery.of(context).size.width,
                        child:Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment:CrossAxisAlignment.start,
                            children:<Widget>[
                              Text('${widget.data['productName']}',
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment:CrossAxisAlignment.start,
                                children: [
                                  Text('\$ ${widget.data['price'].toStringAsFixed(2)}/${widget.data['unit']}',
                                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                                  ),
                                  Text('Available from ${widget.data['availableDate']}',
                                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),
                                  ),
                                ],
                              ),
                            ]
                          ),
                          )
                        ),
                        SizedBox(height: 10),
                        Container(
                            width:MediaQuery.of(context).size.width,
                            color: Global.white,
                            child:Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                  crossAxisAlignment:CrossAxisAlignment.start,
                                  children:<Widget>[
                                    Text('Description',
                                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                                    ),
                                    SizedBox(height: 10),
                                    Text('${widget.data['description']}',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ]
                              ),
                            )
                        ),
                        SizedBox(height: 10),
                        Container(
                          width:MediaQuery.of(context).size.width,
                          color: Global.white,
                          child:Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                                crossAxisAlignment:CrossAxisAlignment.start,
                                children:<Widget>[
                                  Text('Farm Location',
                                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    height: 250,
                                    child: GoogleMap(
                                      onMapCreated: _onMapCreated,
                                      initialCameraPosition: CameraPosition(
                                        target: LatLng(widget.data['farmLocation'].latitude, widget.data['farmLocation'].longitude),
                                        zoom: 11.0,
                                      ),
                                        markers: _markers,
                                    ),
                                  ),
                                ]
                            ),
                          )
                        ),
                        SizedBox(height: 5),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment:CrossAxisAlignment.start,
                            children:[
                              ElevatedButton(
                              onPressed: () {
                                // Respond to button press
                              },
                              child: Text('ADD TO CART',style: TextStyle(fontSize: 10)),
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(10)),
                                  foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                  backgroundColor: MaterialStateProperty.all<Color>(Global.lightGrey),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18.0),
                                          side: BorderSide(color: Colors.red)
                                      )
                                  )
                              ),
                              ),
                              SizedBox(width: 5),
                              ElevatedButton(
                                onPressed: () {
                                  var productList = <Product>[];
                                  Product product = Product(widget.data['productName'],
                                      widget.data['price'],widget.data['unit'],widget.data['availableDate'],
                                      widget.data['productImage']);
                                  productList.add(product);
                                  Get.to(() => ConfirmOrder(productList: productList));
                                  // Respond to button press
                                },
                                child: Text('ORDER NOW',style: TextStyle(fontSize: 10)),
                                style: ButtonStyle(
                                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(18.0),
                                            side: BorderSide(color: Colors.red)
                                        )
                                    )
                                ),
                              ),
                              SizedBox(width: 10,)]
                        ),
                      ],
                    ),
                )
            )
      );
  }
}
