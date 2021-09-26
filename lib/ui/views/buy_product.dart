import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eoapp/ui/views/product_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import '../shared/product_card.dart';
import 'package:get/get.dart';

class BuyProduct extends StatelessWidget {
  BuyProduct({Key? key}) : super(key: key);
  final Stream<QuerySnapshot> products = FirebaseFirestore.instance.collection('products').snapshots();

  @override
  Widget build(BuildContext context) {
      return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 150,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: GestureDetector(
                  onTap: () => null,
                  child: Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 45),
                    child:
                      Container(
                           height: 30,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(24),
                          ),
                        child:TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                            prefixIcon: Icon(Icons.search_outlined),
                            contentPadding: EdgeInsets.all(10.0),
                              filled: false,
                              hintStyle: TextStyle(color: Colors.grey[800]),
                              hintText: "Search",
                              ),
                        ),
                        // child:CupertinoTextField(
                        //   keyboardType: TextInputType.text,
                        //   placeholder: 'Search',
                        //   placeholderStyle: TextStyle(
                        //     color: Color(0xffC4C6CC),
                        //     fontSize: 14.0,
                        //     fontFamily: 'Brutal',
                        //   ),
                        //   prefix: Padding(
                        //     padding: const EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 5.0),
                        //     child: Icon(
                        //       Icons.search,
                        //       size: 18,
                        //       color: Colors.black,
                        //     ),
                        //   ),
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(8.0),
                        //     color: Colors.white,
                        //   ),
                        // ),
                      ),
                  ),
                ),
                background: Image.network(
                  "https://images.pexels.com/photos/65256/pomegranate-open-cores-fruit-fruit-logistica-65256.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // SliverList(
            //     delegate: new SliverChildListDelegate([
            //       StreamBuilder<QuerySnapshot>(
            //           stream: products,
            //           builder: (
            //           BuildContext context,
            //           AsyncSnapshot<QuerySnapshot> snapshot,
            //           ) {
            //             if(snapshot.hasError){
            //               return Text('Something went wrong.');
            //             }
            //             if(snapshot.connectionState == ConnectionState.waiting){
            //               return Text('Loading');
            //             }
            //             final data = snapshot.requireData;
            //
            //             return ListView.builder(
            //               shrinkWrap: true,
            //               itemCount: data.size,
            //               itemBuilder: (context, index) {
            //                 return InkWell(onTap: (){
            //                   Get.to(() => ProductDetail(data:data.docs[index]));
            //                 },
            //                   child: BuyScrProductCard(
            //                          NetworkImage(data.docs[index]['productImage']),
            //                         data.docs[index]['productName'], data.docs[index]['price'], data.docs[index]['unit'],data.docs[index]['sellerName'] ,
            //                          NetworkImage(data.docs[index]['sellerImage']), data.docs[index]['availableDate'], ),
            //                 );
            //               }
            //             );
            //           }
            //       )
            //     ]),
            //   ),
          ];
        },
        body:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment:CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: products,
                    builder: (
                        BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot,
                        ) {
                      if(snapshot.hasError){
                        return Text('Something went wrong.');
                      }
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return Text('Loading');
                      }
                      final data = snapshot.requireData;

                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: data.size,
                          itemBuilder: (context, index) {
                            return InkWell(onTap: (){
                              Get.to(() => ProductDetail(data:data.docs[index]));
                            },
                              child: BuyScrProductCard(
                                NetworkImage(data.docs[index]['productImage']),
                                data.docs[index]['productName'], data.docs[index]['price'], data.docs[index]['unit'],data.docs[index]['sellerName'] ,
                                NetworkImage(data.docs[index]['sellerImage']), data.docs[index]['availableDate'], ),
                            );
                          }
                      );
                    }
                ),
              ),

            ]
        ),
      );
  }
}
