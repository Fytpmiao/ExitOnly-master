import 'package:eoapp/ui/shared/globals.dart';
import 'package:eoapp/ui/shared/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'make_payment.dart';


class ConfirmOrder extends StatefulWidget {
  final List<Product> productList;
  const ConfirmOrder({required this.productList});

  @override
  _ConfirmOrderState createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {

  num totalPrice = 0;
  List<ItemCounter> itemCounters = <ItemCounter>[];
  @override
  void initState(){
    for (var i=0;i<widget.productList.length;i++){
      itemCounters.add(ItemCounter(
          widget.productList[i].unit,widget.productList[i].price,widget.productList[i].productName));
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Global.lightGrey,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:<Widget>[
                        Container(
                        alignment:Alignment.topLeft,
                        padding: EdgeInsets.fromLTRB(10, 70, 0, 0),
                        child:InkWell(
                          onTap: (){Get.back();},
                          child: Icon(Icons.arrow_back_ios,size:20,color: Global.black,
                          ),
                          )
                        ),
                        ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.productList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: Column(
                              children: [
                                Container(
                                    height: MediaQuery.of(context).size.width * 0.35,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.1),
                                          spreadRadius: 2,
                                          blurRadius: 3,
                                          offset: Offset(0, 3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context).size.width * 0.5,
                                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                            child: Image.network(
                                              '${widget.productList[index].productImage}'
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text('${widget.productList[index].productName}',
                                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                                                Text('\$ ${widget.productList[index].price}/${widget.productList[index].unit}'),
                                            Row(
                                              children: [
                                                IconButton(icon: Icon(Icons.remove),onPressed: (){
                                                  setState(() {
                                                    itemCounters[index].number==0?itemCounters[index].number=0:itemCounters[index].number--;
                                                    totalPrice = 0;
                                                    itemCounters.forEach((element) {
                                                      totalPrice += element.number * element.price;
                                                    });
                                                });}),
                                                Text(itemCounters[index].number.toString()+widget.productList[index].unit),
                                                IconButton(icon: Icon(Icons.add),onPressed: (){
                                                  setState((){
                                                    itemCounters[index].number++;
                                                    totalPrice = 0;
                                                    itemCounters.forEach((element) {
                                                      totalPrice += element.number * element.price;
                                                    });
                                                  });}),
                                              ],
                                            ),
                                              ],
                                                    ),
                                          ),
                                        ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                                Container(
                                  height: MediaQuery.of(context).size.width * 0.5,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)
                                  ),
                                  boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 2,
                                    blurRadius: 3,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                  ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Available Date: ',
                                                style: TextStyle(fontSize: 16)),
                                            Text('${widget.productList[index].availableDate}',
                                                style: TextStyle(fontSize: 16)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      ),
                    ]
                  ),
                ),
        ),
              bottomNavigationBar: Container(
                height: MediaQuery.of(context).size.width*0.2,
                color:Global.white,
                child:Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Total \$ ${totalPrice.toStringAsFixed(2)}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                      SizedBox(width:MediaQuery.of(context).size.width*0.3),
                      ElevatedButton(
                        onPressed: () {Get.to(() => MakePayment(totalPrice: totalPrice,itemCounters: itemCounters,));},
                        child: Text('Checkout',style: TextStyle(fontSize: 12)),
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(10)),
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                            backgroundColor: MaterialStateProperty.all<Color>(Global.white),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.red)
                                )
                            )
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          );
  }
}

class ItemCounter {
  String name;
  String unit;
  num price;
  num number=0;
  ItemCounter(this.unit, [this.price = 0 ,this.name =""]);
}
