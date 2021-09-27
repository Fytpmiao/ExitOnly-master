import 'package:eoapp/ui/shared/globals.dart';
import 'package:eoapp/ui/views/confirm_order.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay/pay.dart';

class MakePayment extends StatefulWidget {
  final num totalPrice;
  final List<ItemCounter> itemCounters;
  const MakePayment({required this.totalPrice,required this.itemCounters});

  @override
  _MakePaymentState createState() => _MakePaymentState();
}

class _MakePaymentState extends State<MakePayment> {

  void onGooglePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
  }

  void onApplePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
  }

  @override
  Widget build(BuildContext context) {
    List<PaymentItem> _paymentItems = [
      PaymentItem(
        label: 'Total',
        amount: '${widget.totalPrice}',
        status: PaymentItemStatus.final_price,
      )
    ];
    return Scaffold(
      body: Column(
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
            Text("Order Summary",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 24)),
            Flexible(
              child: ListView(
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(15),
                        itemCount: widget.itemCounters.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:[Text("${widget.itemCounters[index].name} x ${widget.itemCounters[index].number}",
                                  style: TextStyle(fontSize: 16)),
                                Text("\$ ${(widget.itemCounters[index].number*widget.itemCounters[index].price).toStringAsFixed(2)}",
                                    style: TextStyle(fontSize: 16,))]
                            ),
                      );
                    },
                      separatorBuilder: (BuildContext context, int index) => const Divider(),
                      )
                    ]
                ),
            ),
            Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                  children:[
                    Container(
                      decoration: BoxDecoration( //
                        border: Border(bottom: BorderSide(color: Colors.black)),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total :",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                      Text(" \$ ${widget.totalPrice.toStringAsFixed(2)}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                    ],
                  ),]
            ),
                )
            ),
                Container(
                width:MediaQuery.of(context).size.width*0.9, height:MediaQuery.of(context).size.width*0.15,
                    child:GooglePayButton(
                          paymentConfigurationAsset:
                          'default_payment_profile_google_pay.json',
                          paymentItems: _paymentItems,
                          style: GooglePayButtonStyle.black,
                          type: GooglePayButtonType.pay,
                          margin: const EdgeInsets.only(top: 15.0),
                          onPaymentResult: onGooglePayResult,
                          loadingIndicator: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                ),
                Container(
                width:MediaQuery.of(context).size.width*0.9, height:MediaQuery.of(context).size.width*0.15,
                child:ApplePayButton(
                      paymentConfigurationAsset: 'default_payment_profile_apple_pay.json',
                      paymentItems: _paymentItems,
                      style: ApplePayButtonStyle.black,
                      type: ApplePayButtonType.buy,
                      margin: const EdgeInsets.only(top: 15.0),
                      onPaymentResult: onApplePayResult,
                      loadingIndicator: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                ),
                SizedBox(height: MediaQuery.of(context).size.width*0.2),
      ]
      ),
              );
  }
}
